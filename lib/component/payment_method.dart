// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/order/change_payment.dart';
import 'package:flutter_coffee_application/component/Icon.dart';
import 'package:flutter_coffee_application/resource/provider/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../style/typhography.dart';

class PaymentMethod extends ConsumerStatefulWidget {
  const PaymentMethod({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends ConsumerState<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(paymentMethod) == "cash"
        ? ListTile(
            leading: CircleIcon(
              icon: Icons.money,
            ),
            title: Text(
              "Cash",
              style: h3(),
            ),
            trailing: Icon(Icons.navigate_next),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangePayment(),
              ),
            ),
          )
        : ref.watch(paymentMethod.notifier).state == "QRIS"
            ? ListTile(
                leading: CircleIcon(
                  icon: Icons.qr_code_2,
                ),
                title: Text(
                  "QRIS",
                  style: h3(),
                ),
                trailing: Icon(Icons.navigate_next),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePayment(),
                  ),
                ),
              )
            : ref.watch(paymentMethod.notifier).state == "mbca"
                ? ListTile(
                    leading: CircleIcon(
                      icon: Icons.money,
                    ),
                    title: Text(
                      "M-BCA",
                      style: h3(),
                    ),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePayment(),
                      ),
                    ),
                  )
                : ListTile(
                    leading: CircleLogo(
                      image: 'assets/logo/gopay.png',
                    ),
                    title: Text(
                      "Gopay",
                      style: h3(),
                    ),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePayment(),
                      ),
                    ),
                  );
  }
}
