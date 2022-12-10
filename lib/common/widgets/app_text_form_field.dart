import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final FormFieldValidator? validator;
  final String hintText;
  final Color? color;
  final bool autoFocus;
  final TextInputType? keyboardType;

  const AppTextFormField({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.validator,
    required this.hintText,
    this.color,
    this.keyboardType,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autoFocus,
      keyboardType: keyboardType,
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontSize: 18,
      ),
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: InputBorder.none,
        hintText: hintText,
      ),
    );
  }
}
