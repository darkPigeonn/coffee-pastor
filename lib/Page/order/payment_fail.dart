import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/home.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PaymentFail extends ConsumerStatefulWidget {
  const PaymentFail({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentFailState();
}

class _PaymentFailState extends ConsumerState<PaymentFail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Alert(
        context: context,
        type: AlertType.success,
        title: "Pembayaran Gagal",
        desc: "Maaf pembayaran Anda gagal",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () => Navigator.pop(context),
            color: primary,
          ),
        ],
      ).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
