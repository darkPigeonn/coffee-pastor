import 'dart:async';
import 'dart:convert';

import 'package:flutter_coffee_application/resource/model/notif_model.dart';
import 'package:flutter_coffee_application/resource/const_resource.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

class NotificationServices {
  Future<List<ModelNotif>> fetchNotification() async {
    try {
      Map<String, String> headers = {
        'Id': '6163b0c663bd513e8b3b8553',
        'Secret': '2213be40-3625-4111-9b52-e828b5d335d8',
        'partner': 'cim',
        'Authorization': 'Bearer ${sp.getString('token')}'
      };
      final link = Uri.parse("${url}imavi/notifications/get-all/garum");

      final response = await http
          .get(
            link,
            headers: headers,
          )
          .timeout(Duration(seconds: apiWaitTime));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<ModelNotif> data =
            jsonResponse.map((e) => ModelNotif.fromJson(e)).toList();
        return data;
      } else {
        if (response.statusCode == 401) {
          await sp.remove("token");
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

  Future<Map<String, dynamic>> updateNotification(String id) async {
    try {
      Map<String, String> headers = {
        'Id': '6163b0c663bd513e8b3b8553',
        'Secret': '2213be40-3625-4111-9b52-e828b5d335d8',
        'partner': 'cim',
        'Authorization': 'Bearer ${sp.getString('token')}'
      };
      final link =
          Uri.parse("${url}imavi/notifications/update?partner=garum&id=$id");

      final response = await http
          .put(
            link,
            headers: headers,
          )
          .timeout(Duration(seconds: apiWaitTime));
      if (response.statusCode == 200) {
        return {
          "statusCode": 200,
          "message": "Sukses",
        };
      } else {
        if (response.statusCode == 401) {
          await sp.remove("token");
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

  Future<int> sendNotification(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        'Id': '6163b0c663bd513e8b3b8553',
        'Secret': '2213be40-3625-4111-9b52-e828b5d335d8',
        'Content-Type': 'application/json',
        'partner': 'cim',
        'Authorization': 'Bearer ${sp.getString('token')}'
      };
      final link =
          Uri.parse("${url}imavi/notifications/create");


      final response = await http
          .post(
            link,
            headers: headers,
            body: jsonEncode(body)
          )
          .timeout(Duration(seconds: apiWaitTime));
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        if (response.statusCode == 401) {
          await sp.remove("token");
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
}
