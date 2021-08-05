import 'package:flutter/material.dart';
import 'package:general_products_web/resources/colors.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  CustomButton({ Key? key, required this.title, this.onPressed }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*.33,
      child: ElevatedButton(
        child: Text(
         widget.title,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          primary: GPColors.PrimaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        )
      ),
    );
  }
}