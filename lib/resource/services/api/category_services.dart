import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../const_resource.dart';
import '../../model/category_model.dart';

class CategoryServices {
  Future<List<ModelCategory>> getAllCategory() async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'partner': 'garum'
    };
    final response = await http
        .get(
          Uri.parse('${url}garum/products/get-category'),
          headers: headers,
        )
        .timeout(Duration(seconds: apiWaitTime));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<ModelCategory> data =
          jsonResponse.map((e) => ModelCategory.fromJson(e)).toList();
      return data;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
