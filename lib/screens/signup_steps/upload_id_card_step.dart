import 'package:flutter/material.dart';

class UploadIdCardStep extends StatefulWidget {
  @override
  _UploadIdCardStepState createState() => _UploadIdCardStepState();
}

class _UploadIdCardStepState extends State<UploadIdCardStep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        color: Colors.yellow,
        child: Center(child: Text('upload id card'),),
        
      ),
    );
  }
}