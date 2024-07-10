// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/auth/sign_up.dart';
import 'package:flutter_coffee_application/Page/on_boarding.dart';
import 'package:flutter_coffee_application/component/Home/navbar_home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_coffee_application/resource/provider/auth/auth_provider.dart';
import 'package:flutter_coffee_application/resource/services/api/auth/auth_services.dart';

import '../../resource/const_resource.dart';

class AuthPage extends ConsumerStatefulWidget {
  AuthPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    CircularProgressIndicator()); // Show loading indicator while checking authentication state
          }
          if (snapshot.hasData) {
            final user = snapshot.data!;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Navigate based on authentication state after the build process is complete
              _loginUser(user);
            });
            return Center(
                child:
                    CircularProgressIndicator()); // Return an empty container as the widget is being built
          } else {
            return OnBoarding(); // Display OnBoarding widget if user is not authenticated
          }
        },
      ),
    );
  }

  void _loginUser(User user) async {
    try {
      Map<String, dynamic> dataBody = {
        "uid": user.uid,
        "token_fcm": fcmToken,
        "displayName": user.displayName,
        "email": user.email,
        "phoneNumber": user.phoneNumber,
        "photoURL": user.photoURL,
        "refreshToken": user.refreshToken
      };
      final response = await AuthServices()
          .login(dataBody)
          .timeout(Duration(seconds: apiWaitTime));
      if (response["status"] == 1) {
        ref.read(isLogin.notifier).update((state) => true);
        // Navigate to Home
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()),
          (route) => false,
        );
      } else if (response["status"] == 0) {
        ref.read(isLogin.notifier).update((state) => true);
        // Navigate to SignUp
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SignUp(body: dataBody,)),
          (route) => false,
        );
      } else {
        // Handle other response statuses
        print("Unexpected response status: ${response["status"]}");
      }
    } catch (e) {
      print("Error logging in user: $e");
      // Handle login error
    }
  }
}
