import 'package:flutter/material.dart';
import 'package:general_products_web/resources/colors.dart';

class GeneralDialog{
   Future showInfoDialog(BuildContext context, String title, String detail) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(title),
        content: SingleChildScrollView(
          child:  Text(detail, style: TextStyle(color: Colors.black, fontSize: 17),),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:48.0),
            child: Container(
              width: MediaQuery.of(context).size.width < 600?
               MediaQuery.of(context).size.width*.5
               : MediaQuery.of(context).size.width*.3,
              child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0),
                  child: Text(
                   "Aceptar",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
                onPressed: (){Navigator.pop(context);},
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  primary: GPColors.PrimaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                )
              ),
            )
          ),
        ],
      );
    },
  );
}
}