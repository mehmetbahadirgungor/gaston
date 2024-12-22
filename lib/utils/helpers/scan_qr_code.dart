import 'package:flutter/material.dart';
import 'package:gaston/common/widgets/appbar/appbar.dart';
import 'package:gaston/features/shop/controllers/product/order_controller.dart';
import 'package:gaston/features/shop/models/order_model.dart';
import 'package:get/get.dart';
import 'package:gaston/utils/popups/dialogs.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key, required this.order, required this.orderController});

  final OrderModel order;
  final OrderController orderController;

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  late final MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('QR Code', style: Theme.of(context).textTheme.headlineSmall), showBackArrow: true,),
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) {
          controller.start();

          // Code to execute when a QR code is detected
          final String qrCode = capture.barcodes.first.rawValue ?? 'Invalid QR code';
          
          // QR code validation
          bool isCorrectQRCode = qrCode == widget.order.qrCode;

          if (isCorrectQRCode) {
            widget.orderController.completeOrder(widget.order);
            Get.back();
          } else {
            // If the QR code is invalid, show a dialog
            TDialogs.defaultDialog(
              context: context,
              title: 'Invalid QR Code',
              content: 'Please scan the correct QR code again.',
              confirmText: 'Retry',
              onConfirm: () {
                Get.back();
                Get.back();
              }
            );
            // Return back page
            controller.dispose();
          }
        },
      ),
    );
  }
}
