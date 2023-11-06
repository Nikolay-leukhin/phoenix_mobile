import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/wallet/bloc/promo_code/promo_code_cubit.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MainQrScreen extends StatefulWidget {
  final Function onFound;

  const MainQrScreen({Key? key, required this.onFound}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainQrScreenState();
}

class _MainQrScreenState extends State<MainQrScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned.fill(
                child: QRView(
              key: qrKey,
              overlay: QrScannerOverlayShape(
                borderColor: AppColors.primary,
                borderRadius: 10,
                borderLength: 50,
                borderWidth: 5,
              ),
              onQRViewCreated: (controller) {
                controller.scannedDataStream.listen((data) {
                  this.controller = controller;
                  controller.stopCamera();
                  log("QR CODE ${data.code.toString()}");
                  widget.onFound(data);
                  context.pop();
                });
              },
            )),
            Positioned(
                top: 20,
                left: 20,
                child: InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.centerRight,
                      decoration: const BoxDecoration(
                          color: AppColors.primary, shape: BoxShape.circle),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
