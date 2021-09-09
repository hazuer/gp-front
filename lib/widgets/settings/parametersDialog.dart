import 'package:flutter/material.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/provider/settings/parametros_provider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/models/tara/catTaraModel.dart';
import 'package:general_products_web/provider/tara/tarasProvider.dart';

class SettingsDialog {
  Future showInfoDialog(
      BuildContext context, String title, String detail) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            title,
            textAlign: TextAlign.center,
          )),
          content: SingleChildScrollView(
            child: Center(
                child: Column(
              children: [
                Text(
                  detail,
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width < 600
                          ? MediaQuery.of(context).size.width * .5
                          : MediaQuery.of(context).size.width * .3,
                      child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Aceptar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, RouteNames.settings);
                            // Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 2,
                              primary: GPColors.PrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    )),
              ],
            )),
          ),
        );
      },
    );
  }
}
