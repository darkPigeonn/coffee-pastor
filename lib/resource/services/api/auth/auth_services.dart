import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_coffee_application/resource/const_resource.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../../../main.dart';

class AuthServices {
  // Google Sign in

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      if (kDebugMode) print('something went wrong: $e');
    }
  }

  Future<UserCredential?> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "Id": "628c318b0a1b551f2a8fb6ee",
        "Secret": "edc02803-82a4-4473-b5bd-888f064d7436",
        "Content-Type": "application/json",
        "partner": "garum",
      };
      final response = await http
          .post(
            Uri.parse('${url}garum/users/login-shop'),
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(Duration(seconds: apiWaitTime));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        await sp.setString("token", jsonDecode(response.body)["profileToken"]);
        print("Token: ${sp.getString('token')}");
        return data;
      } else {
        print('Error login');
        return json.decode(response.body);
      }
    } catch (e) {
      var dataError = {
        'statusCode': 401,
        'message': "Terjadi kesalahan di server"
      };
      print(dataError);
      return dataError;
    }
  }

  Future<Map<String, dynamic>> logoutData() async {
    final link = Uri.parse("${url}garum/users/logout-shop");
    Map<String, String> headers = {
      "Id": "628c318b0a1b551f2a8fb6ee",
      "Secret": "edc02803-82a4-4473-b5bd-888f064d7436",
      "Content-Type": "application/json",
      "partner": "garum",
      'Authorization': 'Bearer ${sp.getString('token')}',
    };
    final response = await http.post(
      link,
      headers: headers,
      body: jsonEncode({}),
    );
    final Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<bool> wasLoggedOut() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser == null;
  }
}
