import 'dart:async';
import 'dart:convert';

import 'package:flutter_coffee_application/resource/const_resource.dart';
import 'package:flutter_coffee_application/resource/model/testimoni_model.dart';

import 'package:http/http.dart' as http;

import '../../../main.dart';

class TestimoniServices {
  Future<Map<String, dynamic>> createTestimoniUser(
    String isiTestimoni,
    double rating,
  ) async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'Content-Type': 'application/json',
      'partner': 'garum',
      'Authorization': 'Bearer ${sp.getString('token')}',
    };
    Map<String, dynamic> data = {
      "isiTestimoni": isiTestimoni,
      "rating": rating,
    };

    var bodys = jsonEncode(data);
    final response = await http.post(
      Uri.parse('${url}garum/testimonials/insert'),
      body: bodys,
      headers: headers,
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

  Future<Map<String, dynamic>> createTestimoniGuest(
    String isiTestimoni,
    double rating,
  ) async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'Content-Type': 'application/json',
      'partner': 'garum',
      'Authorization': 'Bearer ${sp.getString('token')}',
    };
    Map<String, dynamic> data = {
      "isiTestimoni": isiTestimoni,
      "rating": rating,
    };

    var bodys = jsonEncode(data);
    final response = await http.post(
      Uri.parse('${url}garum/testimonials/insert-guest'),
      body: bodys,
      headers: headers,
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

  Future<List<ModelTestimoni>> getActiveTestimonis() async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'partner': 'garum'
    };
    final response = await http
        .get(
          Uri.parse('${url}garum/testimonials/get-published'),
          headers: headers,
        )
        .timeout(Duration(seconds: apiWaitTime));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<ModelTestimoni> data =
          jsonResponse.map((e) => ModelTestimoni.fromJson(e)).toList();
      return data;
    } else {
      if (response.statusCode == 204) {
        return Future.error(response.statusCode);
      } else {
        throw Exception(response.reasonPhrase.toString());
      }
    }
  }

    Future<ModelTestimoni> getDetailTestimoni(String id) async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'partner': 'garum',
      'Authorization': 'Bearer ${sp.getString('token')}',
    };
    final response = await http
        .get(
          Uri.parse('${url}garum/testimonials/get/$id'),
          headers: headers,
        )
        .timeout(Duration(seconds: apiWaitTime));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return ModelTestimoni.fromJson(result);
    } else {
      if (response.statusCode == 204) {
        return Future.error(response.statusCode);
      } else {
        throw Exception(response.reasonPhrase.toString());
      }
    }
  }
}
