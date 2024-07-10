import 'dart:convert';

import 'package:flutter_coffee_application/resource/const_resource.dart';
import 'package:flutter_coffee_application/resource/model/tentang_model.dart';
import 'package:http/http.dart' as http;

class TentangServices {
  Future<ModelTentang> getContent() async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'partner': 'garum'
    };
    final response = await http
        .get(
          Uri.parse('${url}garum/stores/get-detail/032.021'),
          headers: headers,
        )
        .timeout(Duration(seconds: apiWaitTime));
    if (response.statusCode == 200) {
      ModelTentang data = ModelTentang.fromJson(jsonDecode(response.body));
      return data;
    } else {
      if (response.statusCode == 204) {
        return Future.error(response.statusCode);
      } else {
        throw Exception(response.reasonPhrase.toString());
      }
    }
  }

  Future<Paroki> getDetailParoki(String ParokiId) async {
    Map<String, String> headers = {
      'Id': '6147f10d33abc530a445fe84',
      'Secret': '88022467-0b5c-4e61-8933-000cd884aaa8',
      'partner': 'imavi'
    };

    final response = await http
        .get(
          Uri.parse('${url}imavi/parokis/view/$ParokiId'),
          headers: headers,
        )
        .timeout(Duration(seconds: apiWaitTime));
    if (response.statusCode == 200) {
      Paroki result = Paroki.fromJson(jsonDecode(response.body));
      return result;
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }
}
