// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_coffee_application/resource/provider/auth/auth_provider.dart';
import 'package:flutter_coffee_application/resource/services/api/auth/auth_services.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:nb_utils/nb_utils.dart';

class ScanQr extends ConsumerStatefulWidget {
  const ScanQr({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScanQrState();
}

class _ScanQrState extends ConsumerState<ScanQr> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  void signUserOut() async {
    await AuthServices().signOut();
    ref.watch(isLogin.notifier).update((state) => false);
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              _buildQrView(context),
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Align(
                  child: Text(
                    "Scan kode QR untuk menambah point",
                    style: h3(color: white),
                  ),
                ),
              ),
              Positioned(
                  bottom: 40,
                  right: 20,
                  child: InkWell(
                    onTap: signUserOut,
                    child: CircleAvatar(
                      backgroundColor: white,
                      radius: 30,
                      child: Icon(
                        Icons.exit_to_app_sharp,
                        color: primary,
                        size: 30,
                      ),
                    ),
                  )),
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () async {
                    await controller?.toggleFlash();
                    setState(() {});
                  },
                  child: CircleAvatar(
                    backgroundColor: white,
                    radius: 30,
                    child: Icon(
                      Icons.flashlight_on,
                      color: primary,
                      size: 30,
                    ),
                  ),
                ),
              ),
              result != null
                  ? Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Text(
                          'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}'),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
