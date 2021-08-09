import 'package:flutter/material.dart';
import 'package:general_products_web/resources/colors.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final bool isLoading;
  final VoidCallback? onPressed;
  final double? width;
  CustomButton({ Key? key, required this.title, this.onPressed, required this.isLoading, this.width }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    

    return Container(
      //padding: EdgeInsets.symmetric(vertical:12),
      width: widget.width == null? MediaQuery.of(context).size.width < 600?
       MediaQuery.of(context).size.width*.93
       : MediaQuery.of(context).size.width*.44
       : widget.width,
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
          elevation: 4,
          primary: GPColors.PrimaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        )
      ),
    );
  }
}