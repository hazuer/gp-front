import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:general_products_web/resources/colors.dart';

class CustomInput extends StatelessWidget {
  final String hint;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool isPassword;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;

  CustomInput({
    Key? key,
    required this.hint,
    this.keyboardType,
    this.controller,
    this.onChanged,
    this.errorText,
    this.isPassword = false,
    this.enabled = true,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: TextField(
        enabled: enabled,
        keyboardType: keyboardType,
        onChanged: onChanged,
        controller: controller,
        obscureText: isPassword,
        inputFormatters: inputFormatters,
        style: TextStyle(color: GPColors.Input, fontSize: 13),
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 10, color: Colors.transparent)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.transparent)),
            labelText: hint,
            errorText: errorText),
      ),
    );
  }
}
