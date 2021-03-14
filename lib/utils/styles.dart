import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Text('dummys'),
  );
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 17.0);
}

TextStyle mediumTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17.0);
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.indigo,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.indigo),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.indigo),
      ));
}
