import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../Utils/themeManager.dart';


class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({Key? key}) : super(key: key);



  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  bool flash = false;

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
    check();
  }

  check() async {
    flash = (await controller?.getFlashStatus())!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    controller?.resumeCamera();
    return Scaffold(
      body: Stack(
        children: <Widget>[
           Positioned(child: _buildQrView(context)),
          Positioned(
              child: SafeArea(
                child: Align(
            alignment: Alignment.topCenter,
            child: Container(
                height: 60,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    InkWell(
                        onTap: () async {
                          await controller?.flipCamera();
                          setState(() {});
                        },
                        child: const Icon(Icons.cameraswitch_rounded)),
                    const Spacer(),
                    InkWell(
                        onTap: () async {
                          await controller?.toggleFlash();
                          check();
                        },
                        child: Icon(!flash ? Icons.flash_on : Icons.flash_off)),
                  ],
                ),
            ),
          ),
              )),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = MediaQuery.of(context).size.width;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: CustomColor.blue,
          borderRadius: 5,
          borderLength: 20,
          borderWidth: 5,
          cutOutSize: scanArea / 1.5),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );

  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      controller.dispose();
      Navigator.of(context).pop(scanData.code);
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
