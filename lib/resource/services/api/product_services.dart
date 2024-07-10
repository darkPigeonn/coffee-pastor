import 'dart:async';
import 'dart:convert';

import 'package:flutter_coffee_application/resource/model/product_model.dart';

import 'package:http/http.dart' as http;

import '../../const_resource.dart';

class ProductServices {
  Future<List<ModelProduct>> getAllProduct() async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'partner': 'garum'
    };
    final response = await http
        .get(
          Uri.parse('${url}imavi/articles/get-all'),
          headers: headers,
        )
        .timeout(Duration(seconds: apiWaitTime));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<ModelProduct> data =
          jsonResponse.map((e) => ModelProduct.fromJson(e)).toList();
      return data;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<ModelProduct>> getProductCategory(String category) async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'partner': 'garum'
    };
    final response = await http
        .get(
          Uri.parse('${url}garum/products/get/$category'),
          headers: headers,
        )
        .timeout(Duration(seconds: apiWaitTime));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<ModelProduct> data =
          jsonResponse.map((e) => ModelProduct.fromJson(e)).toList();
      return data;
    } else {
      if (response.statusCode == 204) {
        return Future.error(response.statusCode);
      } else {
        throw Exception(response.reasonPhrase.toString());
      }
    }
  }
}
