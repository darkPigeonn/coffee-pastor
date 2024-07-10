import 'dart:convert';
import 'package:flutter_coffee_application/main.dart';
import 'package:http/http.dart' as http;

import '../../const_resource.dart';
import '../../model/comment_model.dart';

class CommentServices {
  final List<Map<String, dynamic>> body = [
    {
      "_id": "123456",
      "name": "Ryan David",
      "image":
          "https://cdn.imavi.org/coffeeProfilePhoto/profilePhoto-66456181b453d606c682f693-0.jpg",
      "comment": "Mantap promonya",
    },
    {
      "_id": "123456",
      "name": "Ryan David",
      "image":
          "https://cdn.imavi.org/coffeeProfilePhoto/profilePhoto-66456181b453d606c682f693-0.jpg",
      "comment": "Mantap promonya",
    },
    {
      "_id": "123456",
      "name": "Ryan David",
      "image":
          "https://cdn.imavi.org/coffeeProfilePhoto/profilePhoto-66456181b453d606c682f693-0.jpg",
      "comment": "Mantap promonya",
    },
    {
      "_id": "123456",
      "name": "Ryan David",
      "image":
          "https://cdn.imavi.org/coffeeProfilePhoto/profilePhoto-66456181b453d606c682f693-0.jpg",
      "comment": "Mantap promonya",
    },
    {
      "_id": "123456",
      "name": "Ryan David",
      "image":
          "https://cdn.imavi.org/coffeeProfilePhoto/profilePhoto-66456181b453d606c682f693-0.jpg",
      "comment": "Mantap promonya",
    },
    {
      "_id": "123456",
      "name": "Ryan David",
      "image":
          "https://cdn.imavi.org/coffeeProfilePhoto/profilePhoto-66456181b453d606c682f693-0.jpg",
      "comment": "Mantap promonya",
    },
  ];
  Future<List<ModelComment>> getCommentPromo(String promoId) async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'partner': 'garum',
      'Authorization': 'Bearer ${sp.getString('token')}'
    };
    final response = await http
        .get(
          Uri.parse('${url}garum/comments/get/$promoId'),
          headers: headers,
        )
        .timeout(Duration(seconds: apiWaitTime));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<ModelComment> data =
          jsonResponse.map((e) => ModelComment.fromJson(e)).toList();
      return data;
    } else {
      if (response.statusCode == 204) {
        return Future.error(response.statusCode);
      } else {
        throw Exception(response.reasonPhrase.toString());
      }
    }
  }

  Future<Map<String, dynamic>> createComment(
      String comment, String promoId) async {
    Map<String, String> headers = {
      'Id': '628c318b0a1b551f2a8fb6ee',
      'Secret': 'edc02803-82a4-4473-b5bd-888f064d7436',
      'Content-Type': 'application/json',
      'partner': 'garum',
      'Authorization': 'Bearer ${sp.getString('token')}'
    };
    Map<String, dynamic> data = {'comment': comment};
    var bodys = jsonEncode(data);
    final response = await http
        .post(
          Uri.parse('${url}garum/comments/create/$promoId'),
          headers: headers,
          body: bodys,
        )
        .timeout(Duration(seconds: apiWaitTime));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
