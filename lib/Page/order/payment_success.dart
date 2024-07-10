import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/auth/auth_page.dart';
import 'package:flutter_coffee_application/Page/home.dart';
import 'package:flutter_coffee_application/sqlite_services/delete_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../style/color.dart';

class PaymentSuccess extends ConsumerStatefulWidget {
  const PaymentSuccess({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends ConsumerState<PaymentSuccess> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Alert(
        context: context,
        type: AlertType.success,
        title: "Pembayaran Berhasil",
        desc: "Selamat pembayaran Anda berhasil",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () async {
              await clearTable('carts');
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, anotherAnimation) {
                    return AuthPage();
                  },
                ),
              );
            },
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
