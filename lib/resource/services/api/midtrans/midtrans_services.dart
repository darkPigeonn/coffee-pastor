import 'dart:convert';
import 'package:flutter_coffee_application/resource/model/midtrans/gopay_model.dart';
import 'package:http/http.dart' as http;

class MidtransServices {
  Future<ModelGopay> requestGopay() async {
    String serverKey = 'SB-Mid-server-EFLnMafrhbu9YsOSb7Py9sLd';
    String baseUrl = 'https://api.sandbox.midtrans.com/v2/charge';

    Map<String, dynamic> params = {
      "payment_type": "gopay",
      "transaction_details": {
        "gross_amount": 20000,
        "order_id": "INV${DateTime.now().toIso8601String()}",
      },
      "gopay": {
        "enable_callback": true,
        // "callback_url": "coffeeshopapp://gopay-finish"
      }
    };

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Basic ' + base64Encode(utf8.encode('$serverKey:')),
      },
      body: jsonEncode(params),
    );

    if (response.statusCode == 200) {
      print('Transaction successful: ${response.body}');
      ModelGopay data = ModelGopay.fromJson(jsonDecode(response.body));
      return data;
    } else {
      print('Failed to create transaction: ${response.body}');
      throw Exception(response.reasonPhrase);
    }
  }

  Future<ModelGopay> requestBank(String bank) async {
    String serverKey = 'SB-Mid-server-EFLnMafrhbu9YsOSb7Py9sLd';
    String baseUrl = 'https://api.sandbox.midtrans.com/v2/charge';

    Map<String, dynamic> params = {
      "payment_type": "bank_transfer",
      "transaction_details": {
        "order_id": "order-101",
        "gross_amount": 44000,
      },
      "bank_transfer": {
        "bank": "$bank",
      }
    };

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Basic ' + base64Encode(utf8.encode('$serverKey:')),
      },
      body: jsonEncode(params),
    );

    if (response.statusCode == 200) {
      print('Transaction successful: ${response.body}');
      ModelGopay data = ModelGopay.fromJson(jsonDecode(response.body));
      return data;
    } else {
      print('Failed to create transaction: ${response.body}');
      throw Exception(response.reasonPhrase);
    }
  }
}
