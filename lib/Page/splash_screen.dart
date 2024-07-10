import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/on_boarding.dart';
import 'package:flutter_coffee_application/Page/auth/auth_page.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import '../style/Color.dart';
import 'auth/Login.dart';

class SplashScreenPage extends ConsumerStatefulWidget {
  SplashScreenPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends ConsumerState<SplashScreenPage> {
  bool isSplash = true;
  startSplash() async {
    var duration = new Duration(milliseconds: 500);

    Timer(
      duration,
      route,
    );
  }

  Future<void> route() async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
      print("Masuk");
      setState(() {
        isSplash = false;
      });

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          pageBuilder: (context, animation, anotherAnimation) {
            return OnBoarding();
          },
        ),
      );
    } on TimeoutException {
      setState(() {
        isSplash = false;
      });

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          pageBuilder: (context, animation, anotherAnimation) {
            return AuthPage();
          },
        ),
      );
    } catch (e) {
      setState(() {
        isSplash = false;
      });
    }
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        pageBuilder: (context, animation, anotherAnimation) {
          return AuthPage();
        },
      ),
    );
  }

  Future<void> loadPage() async {
    // await ref.refresh(styleData.future);
    route();
  }

  @override
  void initState() {
    // startSplash();
    loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedOpacity(
      opacity: isSplash ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        color: primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/logo.png',
              scale: 3.5,
            ),
            16.height,
            Center(
              child: Text(
                "Coffee Shop",
                style: TextStyle(
                  color: white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            8.height,
          ],
        ),
      ),
    ));
  }
}