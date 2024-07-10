import 'dart:async';
import 'dart:convert';

import 'package:flutter_coffee_application/resource/const_resource.dart';
import 'package:flutter_coffee_application/resource/model/resources_model.dart';

import 'package:http/http.dart' as http;

class ResourceServices {
  Future<List<ModelResources1>> getKalenderLiturgi() async {
    Map<String, String> headers = {
      'Id': '619c3c2e29baa215519da64d',
      'Secret': '360039ed-79a6-4853-8304-c7b21e166f5f',
      'partner': 'keuskupanSby'
    };
    final response = await http
        .get(
          Uri.parse('https://api.imavi.org/imavi/news/get-all'),
          headers: headers,
        )
        .timeout(Duration(seconds: apiWaitTime));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map(((e) => ModelResources1.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }

  Future<List<ModelResources1>> fetchFeaturedArtikel() async {
    try {
      final link = Uri.parse("${url}imavi/articles/featured");

      Map<String, String> headers = {
        "Id": "6147f10d33abc530a445fe84",
        "Secret": "88022467-0b5c-4e61-8933-000cd884aaa8",
        "Partner": "imavi",
      };
      final response = await http
          .get(
            link,
            headers: headers,
          )
          .timeout(Duration(seconds: apiWaitTime));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<ModelResources1> data =
            jsonResponse.map((e) => ModelResources1.fromJson(e)).toList();
        return data;
      } else {
        if (response.statusCode == 204) {
          return Future.error(response.statusCode);
        }
        throw Exception('Failed to load data');
      }
    } on TimeoutException {
      throw Exception("Waktu Habis");
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<List<ModelResources1>> fetchAllArtikel() async {
    try {
      final link = Uri.parse("${url}imavi/articles/get-all");

      Map<String, String> headers = {
        "Id": "6147f10d33abc530a445fe84",
        "Secret": "88022467-0b5c-4e61-8933-000cd884aaa8",
        "Partner": "imavi",
      };

      final response = await http
          .get(
            link,
            headers: headers,
          )
          .timeout(Duration(seconds: apiWaitTime));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<ModelResources1> data =
            jsonResponse.map((e) => ModelResources1.fromJson(e)).toList();
        return data;
      } else {
        if (response.statusCode == 204) {
          return Future.error(response.statusCode);
        }
        throw Exception('Failed to load data');
      }
    } on TimeoutException {
      throw Exception("Waktu Habis");
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<ModelResources1?> fetchDetailArtikel(String id) async {
    try {
      final link = Uri.parse("${url}imavi/articles/view/$id");

      Map<String, String> headers = apiImavi;

      final response = await http
          .get(
            link,
            headers: headers,
          )
          .timeout(Duration(seconds: apiWaitTime));

      if (response.statusCode == 200) {
        ModelResources1 data =
            ModelResources1.fromJson(jsonDecode(response.body));
        return data;
      } else {
        if (response.statusCode == 204) {
          return Future.error(response.statusCode);
        }
        throw Exception('Failed to load data');
      }
    } on TimeoutException {
      throw Exception("Waktu Habis");
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<AgendaModel> getTodayAgenda(String date) async {
    Map<String, String> headers = apiImavi;
    print(date);
    final response = await http
        .get(
          Uri.parse('${url}imavi/agendas/get-by-date/$date'),
          headers: headers,
        )
        .timeout(Duration(seconds: apiWaitTime));
    if (response.statusCode == 200) {
      AgendaModel result = AgendaModel.fromJson(jsonDecode(response.body));
      return result;
    } else {
      if (response.statusCode == 204) {
        // throw Exception(response.statusCode);
        return Future.error(response.statusCode);
      } else {
        throw Exception(response.reasonPhrase.toString());
      }
    }
  }

  Future getAgendas() async {
    Map<String, String> headers = apiImavi;
    final response = await http
        .get(
          Uri.parse('${url}imavi/agendas/get-all'),
          headers: headers,
        )
        .timeout(Duration(seconds: apiWaitTime));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result;
    } else {
      if (response.statusCode == 204) {
        return Future.error(response.statusCode.toString());
      }
      throw Exception(response.reasonPhrase.toString());
    }
  }
}
