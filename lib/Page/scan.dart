// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_coffee_application/main.dart';
import 'package:flutter_coffee_application/resource/model/store_model.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatelessWidget {
  const QRCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Tunjukkan QRMu",
                style: h1(),
              ),
              SizedBox(height: 16),
              Flexible(
                child: Text(
                  "Tunjukkan QR Code ini ke kasir untuk mendapatkan point",
                  style: body1(),
                  maxLines: 3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Divider(),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    color: primary),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      color: white,
                    ),
                    child: QrImageView(
                      data: sp.getString('_id') ?? "1234",
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
