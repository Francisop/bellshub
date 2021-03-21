import 'package:bellshub/screens/coming_soon.dart';
import 'package:flutter/material.dart';

class QrCode extends StatefulWidget {
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ComingSoon(),
    );
  }
}
