import 'dart:async';
import 'dart:convert';

import 'package:flutter_coffee_application/resource/model/user_model.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';
import '../../const_resource.dart';

class profileServices {
  Future<ModelUser> fetchProfile() async {
    try {
      final link = Uri.parse("${url}garum/users/profile");
      Map<String, String> headers = {
        "Id": "628c318b0a1b551f2a8fb6ee",
        "Secret": "edc02803-82a4-4473-b5bd-888f064d7436",
        "partner": "garum",
        'Authorization': 'Bearer ${sp.getString('token')}'
      };

      final response = await http
          .get(
            Uri.parse('${url}garum/users/profile'),
            headers: headers,
          )
          .timeout(Duration(seconds: apiWaitTime));
      if (response.statusCode == 200) {
        ModelUser data = ModelUser.fromJson(jsonDecode(response.body));
        await sp.setString("_id", data.id);
        return data;
      } else {
        if (response.statusCode == 401 &&
            jsonDecode(response.body)["message"] ==
                "Authorization token expired") {
          await sp.remove("token");
          return Future.error(response.statusCode.toString());
        }
        throw Exception(response.statusCode);
      }
    } on TimeoutException {
      // await sp.remove("token");
      rethrow;
    } catch (e) {
      // await sp.remove("token");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    final link = Uri.parse("${url}garum/users/edit-profile-shop");

    Map<String, String> headers = {
      "Id": "628c318b0a1b551f2a8fb6ee",
      "Secret": "edc02803-82a4-4473-b5bd-888f064d7436",
      "partner": "garum",
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${sp.getString('token')}'
    };

    Map<String, dynamic> dataBody = {
      "name": data["fullName"],
      "address": data["address"],
      "dob": data["dob"],
      "gender": data["gender"],
      "phoneNumber": data["phoneNumber"]
    };
    final response = await http.post(
      link,
      headers: headers,
      body: jsonEncode(dataBody),
    );
    if (response.statusCode == 200) {
      return {
        "statusCode": 200,
        "message": "Sukses",
      };
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map<String, dynamic>> updateProfileProfile(Map<String, dynamic> imagePath) async {
    final link = Uri.parse("${url}garum/users/update-profile-picture");

    Map<String, String> headers = {
      "Id": "628c318b0a1b551f2a8fb6ee",
      "Secret": "edc02803-82a4-4473-b5bd-888f064d7436",
      "partner": "garum",
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${sp.getString('token')}'
    };

    final response = await http.post(
      link,
      headers: headers,
      body: jsonEncode(imagePath),
    );
    if (response.statusCode == 200) {
      return {
        "statusCode": 200,
        "message": "Sukses",
      };
    } else {
      return jsonDecode(response.body);
    }
  }
}
