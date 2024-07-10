import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/Button.dart';
import 'package:flutter_coffee_application/resource/provider/cart_provider.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePayment extends ConsumerStatefulWidget {
  const ChangePayment({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChangePaymentState();
}

class _ChangePaymentState extends ConsumerState<ChangePayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          "Pilih Pembayaran",
          style: h1(color: primary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Metode Pembayaran",
                style: h2(),
              ),
              RadioButtonIcon(
                title: "Cash",
                subtitle: "Bayar di kasir",
                groupValue: ref.watch(paymentMethod.notifier).state == "cash",
                icon: Icons.money,
                onChanged: (bool? value) {
                  setState(() {
                    ref.read(paymentMethod.notifier).update((state) => "cash");
                  });
                  Navigator.pop(context);
                },
                value: true,
              ),
              RadioButtonIcon(
                title: "QRIS",
                subtitle: "Bayar di kasir",
                groupValue: ref.watch(paymentMethod.notifier).state == "QRIS",
                icon: Icons.qr_code_2,
                onChanged: (bool? value) {
                  setState(() {
                    ref.read(paymentMethod.notifier).update((state) => "QRIS");
                  });
                  Navigator.pop(context);
                },
                value: true,
              ),
              RadioButton(
                title: "Gopay",
                subtitle: "Langsung ambil barang di kasir",
                groupValue: ref.watch(paymentMethod.notifier).state == "gopay",
                image: "assets/logo/gopay.png",
                onChanged: (bool? value) {
                  setState(() {
                    ref.read(paymentMethod.notifier).update((state) => "gopay");
                  });
                  Navigator.pop(context);
                },
                value: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
