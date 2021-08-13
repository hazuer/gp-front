import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GPColors{
   static const Color DarkBackground     = Color(0xFF19202A);
   static const Color SecondaryColor     = Color(0xffffdfcd);
   static const Color PrimaryColor       = Color.fromRGBO(0, 32, 91, 1);
   static const Color AccentColor        = Color(0xffe8f4ff);
   static const Color Facebook           = Color(0xFF485A96);
   static const Color Google             = Color(0xFF4885ED);
   static const Color Twitter            = Color(0xFF00ACEE);
   static const Color Stripe             = Color(0xFF6772E5);
   static const Color BreadcrumBackgroud = Color(0xFFEDEDED);
   static const Color BreadcrumTitle     = Color(0xFF73879C);
   static const Color Input              = Color(0xFF73879C);
   //static const Color InputBorder     = Color(0xFFCECECE);

   static const LinearGradient GradientBackground = LinearGradient(
       begin: FractionalOffset.topLeft,
       end: FractionalOffset(0, 1.5),
       stops: [0.30, 0.69],
       colors: [
          GPColors.AccentColor,
          GPColors.PrimaryColor
       ],
       tileMode: TileMode.clamp);

   static Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {

     if (hexString.length == 4) {
       var r = hexString.substring(1,2) + hexString.substring(1,2);
       var g = hexString.substring(2,3) + hexString.substring(2,3);
       var b = hexString.substring(3,4) + hexString.substring(3,4);

       return Color(int.parse('0x$alphaChannel$r$g$b'));
     } else if (hexString.length == 7) {
       return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
     } else if (hexString.length == 9) {
       return Color(int.parse(hexString.replaceFirst('#', '0x')));
     }

     return GPColors.SecondaryColor;
   }
}
