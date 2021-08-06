import 'package:flutter/material.dart';
import 'package:general_products_web/resources/colors.dart';

class CustomInput extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  CustomInput({ Key? key, required this.hint, this.controller }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[100]
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: GPColors.hexToColor("#B3B2B3"), fontSize: 17),
        decoration: InputDecoration.collapsed(hintText: hint, hintStyle: TextStyle(color: GPColors.hexToColor("#B3B2B3"), fontSize: 17),),
      ),
    );
  }
}