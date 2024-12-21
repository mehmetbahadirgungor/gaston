import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class GenerateQRCode extends StatelessWidget {
  final String data;
  const GenerateQRCode({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
          child: Container(
            padding: EdgeInsets.all(50),
            child: PrettyQrView.data(
              // CHANGE THE DATA.
              data: data,
            ),
          ),
        ),
    );
  }
}
