import 'package:bellshub/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class BasicInfo extends StatefulWidget {
  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
        ]),
      ),
    ));
  }
}
