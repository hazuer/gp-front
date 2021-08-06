import 'package:flutter/material.dart';
import 'package:general_products_web/resources/colors.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final bool isLoading;
  final VoidCallback? onPressed;
  CustomButton({ Key? key, required this.title, this.onPressed, required this.isLoading }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    

    return Container(
      //padding: EdgeInsets.symmetric(vertical:12),
      width: MediaQuery.of(context).size.width < 600?
       MediaQuery.of(context).size.width*.93
       : MediaQuery.of(context).size.width*.44,
      child: ElevatedButton(
        child: widget.isLoading? 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 25, 
            height: 25,
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white),),
          ),
        )
        : Padding(
          padding: const EdgeInsets.symmetric(vertical:8.0),
          child: Text(
           widget.title,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
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