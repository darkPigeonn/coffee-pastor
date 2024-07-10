import 'dart:async';
import 'dart:convert';

import 'package:flutter_coffee_application/resource/const_resource.dart';
import 'package:flutter_coffee_application/resource/model/quote_model.dart';

import 'package:http/http.dart' as http;

import '../../../main.dart';

class QuoteServices {
  Future<Map<String, dynamic>> addQuote(String title, String slug,
      String description, List<String> images, String author) async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'Content-Type': 'application/json',
      'partner': 'garum',
      'Authorization': 'Bearer ${sp.getString('token')}',
    };
    Map<String, dynamic> data = {
      "title": title,
      "slug": slug,
      "description": description,
      "images": images,
      "author": author,
    };

    var bodys = jsonEncode(data);
    final response = await http.post(
      Uri.parse('${url}garum/quotes/create'),
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

  Future<List<ModelQuote>> getQuotes() async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'partner': 'garum'
    };
    final response = await http
        .get(
          Uri.parse('${url}garum/quotes/get'),
          headers: headers,
        )
        .timeout(Duration(seconds: apiWaitTime));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<ModelQuote> data =
          jsonResponse.map((e) => ModelQuote.fromJson(e)).toList();
      return data;
    } else {
      if (response.statusCode == 204) {
        return Future.error(response.statusCode);
      } else {
        throw Exception(response.reasonPhrase.toString());
      }
    }
  }

  Future<ModelQuote> getTodayQuote() async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'partner': 'garum',
      'Authorization': 'Bearer ${sp.getString('token')}'
    };
    final response = await http
        .get(
          Uri.parse('${url}garum/quotes/get-today'),
          headers: headers,
        )
        .timeout(Duration(seconds: apiWaitTime));

    if (response.statusCode == 200) {
      ModelQuote data = ModelQuote.fromJson(jsonDecode(response.body));
      return data;
    } else {
      if (response.statusCode == 204) {
        return Future.error(response.statusCode);
      } else {
        throw Exception(response.reasonPhrase.toString());
      }
    }
  }

  Future<Map<String, dynamic>> removeQuote(String promoId) async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'Content-Type': 'application/json',
      'partner': 'garum',
      'Authorization': 'Bearer ${sp.getString('token')}',
    };

    final response = await http.delete(
      Uri.parse('${url}garum/quotes/delete/$promoId'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return {
        "statusCode": 200,
        "message": "Produk berhasil dihapus",
      };
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map<String, dynamic>> updateQuote(String promoId, String title,
      String slug, String description, List<String> images) async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'Content-Type': 'application/json',
      'partner': 'garum',
      'Authorization': 'Bearer ${sp.getString('token')}',
    };
    Map<String, dynamic> data = {
      "title": title,
      "slug": slug,
      "description": description,
      "images": images,
    };

    var bodys = jsonEncode(data);
    final response = await http.put(
      Uri.parse('${url}garum/quotes/update/$promoId'),
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
}
