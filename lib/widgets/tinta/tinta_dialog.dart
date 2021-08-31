import 'package:flutter/material.dart';
import 'package:general_products_web/models/tinta/tintasModel.dart';
import 'package:general_products_web/provider/tinta/tintasProvider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';

class TintaDialog {
  Future showInfoDialog(
      BuildContext context, String title, String detail) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
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
                            Navigator.pop(context);
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

  Future dialogChangeStatusTinta(BuildContext context,
      InkList alertDialogTintaDisable, String accion, int idCatStatus) async {
    bool isLoading = false;
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Center(
                  child: Text(
                "¿Desea $accion la tinta: ${alertDialogTintaDisable.nombreTinta}?",
                textAlign: TextAlign.center,
              )),
              content: isLoading
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      width: 30,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(),
                          CircularProgressIndicator(),
                          Container()
                        ],
                      ))
                  : Container(
                      height: 30,
                    ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width < 600
                        ? MediaQuery.of(context).size.width * .4
                        : MediaQuery.of(context).size.width * .1,
                    child: ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: GPColors.PrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width < 600
                          ? MediaQuery.of(context).size.width * .4
                          : MediaQuery.of(context).size.width * .1,
                      child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Aceptar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await TintasProvider()
                                .editarEstatusTinta(
                                    alertDialogTintaDisable.idCatTinta!,
                                    idCatStatus)
                                .then((value) {
                              //print(value.toString());
                              if (value == null) {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pop(context);
                                showInfoDialog(context, "¡Error!",
                                    "Ocurrió un error al $accion la tinta : ${RxVariables.errorMessage}");
                              } else {
                                final typeAlert =
                                    (value["result"]) ? "¡Éxito!" : "¡Error!";
                                final message = value["message"];
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pop(context);
                                showInfoDialog(context, typeAlert, message);
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 2,
                              primary: GPColors.PrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    )),
              ],
            );
          },
        );
      },
    );
  }
}
