import 'dart:convert';
import 'package:flutter_coffee_application/resource/const_resource.dart';
import 'package:flutter_coffee_application/resource/model/store_model.dart';
import 'package:http/http.dart' as http;

class StoreServices {
  Future<List<ModelStore>> getAllStore() async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'partner': 'garum'
    };
    final response = await http
        .get(
          Uri.parse('${url}garum/stores/get'),
          headers: headers,
        )
        .timeout(Duration(seconds: apiWaitTime));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<ModelStore> data =
          jsonResponse.map((e) => ModelStore.fromJson(e)).toList();
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
