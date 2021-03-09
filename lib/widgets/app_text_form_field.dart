import 'package:flutter/material.dart';


class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    this.autofocus = false,
    this.readOnly = false,
    this.onChanged,
    this.initialValue,
    this.label,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.height,
    this.hintColor,
    this.borderWidth,
    this.onTap,
    this.onSaved,
    this.focusNode,
    this.suffix,
    this.textInputAction,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.enabled =true,
    this.autovalidate = false,
  });

  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Color hintColor;
  final TextEditingController controller;
  final double borderWidth;
  final double height;
  final Function(String) validator;
  final Function onSaved;
  final Widget suffix;
  final Function onTap;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Function onFieldSubmitted;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final String label;
  final String initialValue;
  final Function onChanged;
  final bool readOnly;
  final bool autofocus;
  final bool autovalidate;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    TextFormField textFormField = TextFormField(

      cursorColor: Colors. black,
      readOnly: readOnly,
      autovalidateMode:AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      initialValue: initialValue,
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller != null ? controller : null,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      autofocus: autofocus,
      style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontWeight: FontWeight.w600,
            color: hintColor,
            height: 0.3
          ),
      validator: validator,
      onSaved: onSaved,
      onTap: onTap,
      decoration: InputDecoration(
        suffix: suffix,
        enabled: enabled,
        // helperStyle: TextStyle(),
        // filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          // borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          // borderSide: BorderSide.none
        ),
      ),
    );

    return label == null
        ? textFormField
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label),
              SizedBox(
                height: 10.0,
              ),
              textFormField
            ],
          );
  }
}
