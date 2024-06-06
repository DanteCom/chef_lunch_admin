import 'package:flutter/material.dart';

class MyTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle? errorStyle;
  final Color? focusedColor;
  final TextInputType? keyboardType;
  final String? hasError;
  final InputBorder? errorBorder;
  final Function(String)? onTab;
  const MyTextFiled({
    super.key,
    required this.controller,
    required this.hintText,
    this.onTab,
    this.keyboardType = TextInputType.name,
    this.hasError,
    this.errorStyle,
    this.errorBorder,
    this.focusedColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        onChanged: onTab,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: errorBorder,
          errorText: hasError,
          errorStyle: errorStyle,
          hintText: hintText,
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: focusedColor ?? Colors.red.shade700,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
