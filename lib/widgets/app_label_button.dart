import 'package:flutter/material.dart';


class AppLabelButton extends StatelessWidget {
  const AppLabelButton({
    this.onPressed,
    this.text,
    this.textColor,
    this.bgColor,
    this.textStyle = const TextStyle(
        fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w300),
  });

  final VoidCallback onPressed;
  final String text;
  final TextStyle textStyle;
  final Color textColor;
  final Color bgColor;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: onPressed,
        color: bgColor,
        minWidth: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.06,
        child: Text(text,style: TextStyle(color:textColor),),
        
      
      ),
    );
  }
}
