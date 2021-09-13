import 'package:flutter/material.dart';
import 'package:general_products_web/app/auth/login.dart';
import 'package:general_products_web/provider/catalogs/pais/paisProvider.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/widgets/catalogs/pais/paisDialog.dart';

import '../../../widgets/app_scaffold.dart';

class PaisCreate extends StatefulWidget {
  PaisCreate({Key? key}) : super(key: key);

  @override
  _PaisCreateState createState() => _PaisCreateState();
}

class _PaisCreateState extends State<PaisCreate> {
  bool isLoading = false;
  TextEditingController paisCtrl = TextEditingController();
  PaisDialog dialogs = PaisDialog();

  final currentUser = RxVariables.loginResponse.data!;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;

    if (currentUser.catProfile!.profileId != 1) {
      ListUsersProvider().logOut();

      return LoginPage();
    } else {
      return AppScaffold(
          pageTitle: "Catálogos / Países / Crear",
          backButton: true,
          body: SingleChildScrollView(
            child: Container(
              color: Color(0xffF5F6F5),
              child: Column(
                children: <Widget>[
                  Container(
                      width: double.infinity,
                      //height: MediaQuery.of(context).size.width*.8,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Column(children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Color(0xffffffff),
                          padding: EdgeInsets.symmetric(
                              vertical: 30.0, horizontal: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Crear',
                                style: TextStyle(
                                    color: Color(0xff313945),
                                    fontSize: 13.00,
                                    fontWeight: FontWeight.w200),
                              ),
                              Divider(),
                              SizedBox(height: 10),
                              // __ __
                              //|  \  \ ___  _ _
                              //|     |/ . \| | |
                              //|_|_|_|\___/|__/
                              displayMobileLayout
                                  ? ListView(
                                      shrinkWrap: true,
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        CustomInput(
                                            controller: paisCtrl,
                                            hint: "* Nombre País"),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        CustomButton(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .2,
                                          title: 'Crear',
                                          isLoading: false,
                                          onPressed: () async {
                                            if (paisCtrl.text.isEmpty) {
                                              dialogs.showInfoDialog(
                                                  context,
                                                  "¡Atención!",
                                                  "Favor de validar los campos marcados con asterisco (*)");
                                            } else {
                                              await ListPaisesProvider()
                                                  .crearPais(
                                                      paisCtrl.text.trim())
                                                  .then((value) {
                                                if (value == null) {
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                  // Navigator.pop(context);
                                                  dialogs
                                                      .showInfoDialog(
                                                          context,
                                                          "¡Error!",
                                                          "Ocurrió un error al crear el pais : ${RxVariables.errorMessage}")
                                                      .then((value) =>
                                                          Navigator.pop(
                                                              context));
                                                } else {
                                                  final typeAlert =
                                                      (value["result"])
                                                          ? "¡Éxito!"
                                                          : "¡Error!";
                                                  final message =
                                                      value["message"];
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                  Navigator.pop(context);
                                                  dialogs.showInfoDialog(
                                                      context,
                                                      typeAlert,
                                                      message);
                                                }
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    )
                                  // _ _ _       _
                                  //| | | | ___ | |_
                                  //| | | |/ ._>| . \
                                  //|__/_/ \___.|___/
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .7,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(height: 20.0),
                                            Row(
                                              children: [
                                                Flexible(
                                                    child: CustomInput(
                                                        controller: paisCtrl,
                                                        hint: "* Nombre País")),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Flexible(
                                                    child: CustomButton(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .2,
                                                  title: 'Crear',
                                                  isLoading: false,
                                                  onPressed: () async {
                                                    if (paisCtrl.text.isEmpty) {
                                                      dialogs.showInfoDialog(
                                                          context,
                                                          "¡Atención!",
                                                          "Favor de validar los campos marcados con asterisco (*)");
                                                    } else {
                                                      await ListPaisesProvider()
                                                          .crearPais(paisCtrl
                                                              .text
                                                              .trim())
                                                          .then((value) {
                                                        if (value == null) {
                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                          dialogs.showInfoDialog(
                                                              context,
                                                              "¡Error!",
                                                              "Ocurrió un error al crear el pais : ${RxVariables.errorMessage}");
                                                        } else {
                                                          final typeAlert =
                                                              (value["result"])
                                                                  ? "¡Éxito!"
                                                                  : "¡Error!";
                                                          final message =
                                                              value["message"];
                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                          dialogs
                                                              .showInfoDialog(
                                                                  context,
                                                                  typeAlert,
                                                                  message);
                                                        }
                                                      });
                                                    }
                                                  },
                                                )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        )
                      ]))
                ],
              ),
            ),
          ));
    }
  }
}
