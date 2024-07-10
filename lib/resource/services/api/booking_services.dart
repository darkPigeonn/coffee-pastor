import 'dart:async';
import 'dart:convert';

import 'package:flutter_coffee_application/resource/const_resource.dart';
import 'package:flutter_coffee_application/resource/model/booking_model.dart';

import 'package:http/http.dart' as http;

import '../../../main.dart';

class BookingServices {
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

  Future<Map<String, dynamic>> insertReservationUser(
      Map<String, dynamic> bodys) async {
    final link = Uri.parse("${url}garum/reservations/insert");

    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'Content-Type': 'application/json',
      'partner': 'garum',
      'Authorization': 'Bearer ${sp.getString('token')}',
    };

    final response = await http.post(
      link,
      body: jsonEncode(bodys),
      headers: headers,
    );

    await sp.setString("bookingId", jsonDecode(response.body)["idReservation"]);
    if (response.statusCode == 200) {
      return {
        "code": response.statusCode,
        "message": jsonDecode(response.body)["message"],
        "idReservation": jsonDecode(response.body)["idReservation"]
      };
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map<String, dynamic>> insertReservationGuest(
      Map<String, dynamic> bodys) async {
    final link = Uri.parse("${url}garum/reservations/insert-guest");

    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'Content-Type': 'application/json',
      'partner': 'garum',
    };

    final response = await http.post(
      link,
      body: jsonEncode(bodys),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return {
        "code": response.statusCode,
        "message": jsonDecode(response.body)["message"],
        "idReservation": jsonDecode(response.body)["idReservation"]
      };
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<List<ModelBooking>> getUserBooking() async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'partner': 'garum',
      'Authorization': 'Bearer ${sp.getString('token')}',
    };
    final response = await http
        .get(
          Uri.parse('${url}garum/reservations/get-user'),
          headers: headers,
        )
        .timeout(Duration(seconds: apiWaitTime));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<ModelBooking> data =
          jsonResponse.map((e) => ModelBooking.fromJson(e)).toList();
      return data;
    } else {
      if (response.statusCode == 204) {
        return Future.error(response.statusCode);
      } else {
        throw Exception(response.reasonPhrase.toString());
      }
    }
  }

    Future<List<ModelBooking>> getApproveBooking(String date) async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'partner': 'garum',
      'Authorization': 'Bearer ${sp.getString('token')}',
    };
    final response = await http
        .get(
          Uri.parse('${url}garum/reservations/get-approved/$date'),
          headers: headers,
        )
        .timeout(Duration(seconds: apiWaitTime));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<ModelBooking> data =
          jsonResponse.map((e) => ModelBooking.fromJson(e)).toList();
      return data;
    } else {
      if (response.statusCode == 204) {
        return Future.error(response.statusCode);
      } else {
        throw Exception(response.reasonPhrase.toString());
      }
    }
  }

  Future<ModelBooking> getDetailBooking(String id) async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'partner': 'garum',
      'Authorization': 'Bearer ${sp.getString('token')}',
    };
    final response = await http
        .get(
          Uri.parse('${url}garum/reservations/get/$id'),
          headers: headers,
        )
        .timeout(Duration(seconds: apiWaitTime));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return ModelBooking.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }
}
