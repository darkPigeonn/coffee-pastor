// import 'dart:async';

// import 'package:flutter_coffee_application/resource/model/order_model.dart';

// import 'package:http/http.dart' as http;

// class OrderServices {
//   final List<Map<String, dynamic>> body = [
//     {
//       "order_id": "123456",
//       "user_id": "789",
//       "order_date": "2024-03-19 11:58:13.605727",
//       "total_amount": "40000",
//       "items": [
//         {"_id": "1234", "quantity": 1, "subtotal": 10000},
//         {"_id": "1234", "quantity": 1, "subtotal": 10000},
//         {"_id": "1234", "quantity": 3, "subtotal": 10000}
//       ]
//     },
//     {
//       "order_id": "789012",
//       "user_id": "456",
//       "order_date": "2024-03-19 15:58:13.605727",
//       "total_amount": "30000",
//       "items": [
//         {"_id": "1234", "quantity": 2, "subtotal": 10000},
//         {"_id": "1234", "quantity": 3, "subtotal": 10000},
//         {"_id": "1234", "quantity": 2, "subtotal": 10000}
//       ]
//     }
//   ];
//   final List<Map<String, dynamic>> body2 = [
//     {
//       "order_id": "123456",
//       "user_id": "789",
//       "order_date": "2024-03-19 15:58:13.605727",
//       "total_amount": "40000",
//       "items": [
//         {"_id": "1234", "quantity": 1, "subtotal": 10000},
//         {"_id": "1234", "quantity": 1, "subtotal": 10000},
//         {"_id": "1234", "quantity": 3, "subtotal": 10000}
//       ]
//     },
//     {
//       "order_id": "789012",
//       "user_id": "456",
//       "order_date": "2024-03-19 15:58:13.605727",
//       "total_amount": "30000",
//       "items": [
//         {"_id": "1234", "quantity": 2, "subtotal": 10000},
//         {"_id": "1234", "quantity": 3, "subtotal": 10000},
//         {"_id": "1234", "quantity": 2, "subtotal": 10000}
//       ]
//     },
//     {
//       "order_id": "123456",
//       "user_id": "789",
//       "order_date": "2024-03-19 15:58:13.605727",
//       "total_amount": "40000",
//       "items": [
//         {"_id": "1234", "quantity": 1, "subtotal": 10000},
//         {"_id": "1234", "quantity": 1, "subtotal": 10000},
//         {"_id": "1234", "quantity": 3, "subtotal": 10000}
//       ]
//     },
//     {
//       "order_id": "789012",
//       "user_id": "456",
//       "order_date": "2024-03-19 15:58:13.605727",
//       "total_amount": "30000",
//       "items": [
//         {"_id": "1234", "quantity": 2, "subtotal": 10000},
//         {"_id": "1234", "quantity": 3, "subtotal": 10000},
//         {"_id": "1234", "quantity": 2, "subtotal": 10000}
//       ]
//     },
//     {
//       "order_id": "123456",
//       "user_id": "789",
//       "order_date": "2024-03-19 15:58:13.605727",
//       "total_amount": "40000",
//       "items": [
//         {"_id": "1234", "quantity": 1, "subtotal": 10000},
//         {"_id": "1234", "quantity": 1, "subtotal": 10000},
//         {"_id": "1234", "quantity": 3, "subtotal": 10000},
//       ]
//     },
//     {
//       "order_id": "789012",
//       "user_id": "456",
//       "order_date": "2024-03-19 12:58:13.605727",
//       "total_amount": "30000",
//       "items": [
//         {"_id": "1234", "quantity": 2, "subtotal": 10000},
//         {"_id": "1234", "quantity": 3, "subtotal": 10000},
//         {"_id": "1234", "quantity": 2, "subtotal": 10000},
//         {"_id": "1234", "quantity": 2, "subtotal": 10000},
//         {"_id": "1234", "quantity": 3, "subtotal": 10000},
//         {"_id": "1234", "quantity": 2, "subtotal": 10000},
//         {"_id": "1234", "quantity": 2, "subtotal": 10000},
//         {"_id": "1234", "quantity": 3, "subtotal": 10000},
//         {"_id": "1234", "quantity": 2, "subtotal": 10000}
//       ]
//     }
//   ];

//   Future<List<ModelOrder>> getTodayOrder() async {
//     // Map<String, String> headers = {
//     //   'Id': '619c3c2e29baa215519da64d',
//     //   'Secret': '360039ed-79a6-4853-8304-c7b21e166f5f',
//     //   'partner': 'keuskupanSby'
//     // };
//     // final response = await http
//     //     .get(
//     //       Uri.parse('https://api.imavi.org/imavi/articles/get-all'),
//     //       headers: headers,
//     //     )
//     //     .timeout(Duration(seconds: apiWaitTime));

//     // if (response.statusCode == 200) {
//     //   print(response.body);
//     //   final List result = jsonDecode(response.body);
//     //   return result.map(((e) => MenuModel.fromJson(e))).toList();
//     // } else {
//     //   throw Exception(response.reasonPhrase);
//     // }
//     try {
//       List<ModelOrder> result =
//           body.map((e) => ModelOrder.fromJson(e)).toList();
//       return result;
//     } catch (e) {
//       print("Error in getTodayOrder(): $e");
//       rethrow;
//     }
//   }

//   Future<List<ModelOrder>> getAllOrder() async {
//     // Map<String, String> headers = {
//     //   'Id': '619c3c2e29baa215519da64d',
//     //   'Secret': '360039ed-79a6-4853-8304-c7b21e166f5f',
//     //   'partner': 'keuskupanSby'
//     // };
//     // final response = await http
//     //     .get(
//     //       Uri.parse('https://api.imavi.org/imavi/articles/get-all'),
//     //       headers: headers,
//     //     )
//     //     .timeout(Duration(seconds: apiWaitTime));

//     // if (response.statusCode == 200) {
//     //   print(response.body);
//     //   final List result = jsonDecode(response.body);
//     //   return result.map(((e) => MenuModel.fromJson(e))).toList();
//     // } else {
//     //   throw Exception(response.reasonPhrase);
//     // }
//     try {
//       List<ModelOrder> result =
//           body2.map((e) => ModelOrder.fromJson(e)).toList();
//       return result;
//     } catch (e) {
//       print("Error in getAllOrder(): $e");
//       rethrow;
//     }
//   }

//   Future<List<ModelOrder>> getUserOrder() async {
//     // Map<String, String> headers = {
//     //   'Id': '619c3c2e29baa215519da64d',
//     //   'Secret': '360039ed-79a6-4853-8304-c7b21e166f5f',
//     //   'partner': 'keuskupanSby'
//     // };
//     // final response = await http
//     //     .get(
//     //       Uri.parse('https://api.imavi.org/imavi/articles/get-all'),
//     //       headers: headers,
//     //     )
//     //     .timeout(Duration(seconds: apiWaitTime));

//     // if (response.statusCode == 200) {
//     //   print(response.body);
//     //   final List result = jsonDecode(response.body);
//     //   return result.map(((e) => MenuModel.fromJson(e))).toList();
//     // } else {
//     //   throw Exception(response.reasonPhrase);
//     // }
//     try {
//       List<ModelOrder> result =
//           body2.map((e) => ModelOrder.fromJson(e)).toList();
//       return result;
//     } catch (e) {
//       print("Error in getUserOrder(): $e");
//       rethrow;
//     }
//   }

  
// }
