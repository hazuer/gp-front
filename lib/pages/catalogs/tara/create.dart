import 'package:flutter/material.dart';
import 'package:general_products_web/app/auth/login.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/widgets/inputFloat_custom.dart';
import 'package:general_products_web/provider/catalogs/tara/tarasProvider.dart';
import 'package:general_products_web/widgets/catalogs/tara/taraDialog.dart';

import '../../../widgets/app_scaffold.dart';

class TaraCreate extends StatefulWidget {
  TaraCreate({Key? key}) : super(key: key);

  @override
  _TaraCreateState createState() => _TaraCreateState();
}

class _TaraCreateState extends State<TaraCreate> {
  late Future futureTara;
  bool isLoading = false;
  String headerFilter = "?porPagina = 20";
  TextEditingController taraCtrl = TextEditingController();
  TextEditingController capacidadCtrl = TextEditingController();
  Plant catPlanta = Plant();
  TarasProvider tarasProvider = TarasProvider();
  TaraDialog dialogs = TaraDialog();
  final GlobalKey<AppExpansionTileState> catPlanKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> catEstatusKey = new GlobalKey();

  final currentUser = RxVariables.loginResponse.data!;

  @override
  void initState() {
    futureTara = tarasProvider.getAllTaras();
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
          pageTitle: "Catálogos / Taras / Crear",
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
                                            controller: taraCtrl,
                                            hint: "* Tara"),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        CustomInputFloat(
                                            controller: capacidadCtrl,
                                            hint: "* Peso Tara Kg"),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        listPlants(),
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
                                            if (taraCtrl.text.isEmpty ||
                                                capacidadCtrl.text.isEmpty ||
                                                catPlanta.idCatPlanta == null) {
                                              dialogs.showInfoDialog(
                                                  context,
                                                  "¡Atención!",
                                                  "Favor de validar los campos marcados con asterisco (*)");
                                            } else {
                                              await TarasProvider()
                                                  .createTara(
                                                taraCtrl.text.trim(),
                                                capacidadCtrl.text.trim(),
                                                catPlanta.idCatPlanta!,
                                              )
                                                  .then((value) {
                                                if (value == null) {
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                  dialogs.showInfoDialog(
                                                      context,
                                                      "¡Error!",
                                                      "Ocurrió un error al crear la tara : ${RxVariables.errorMessage}");
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
                                                  //Navigator.pushReplacementNamed(context, RouteNames.clienteIndex);
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
                                                        controller: taraCtrl,
                                                        hint: "* Tara")),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Flexible(
                                                    child: CustomInputFloat(
                                                        controller:
                                                            capacidadCtrl,
                                                        hint:
                                                            "* Peso Tara Kg")),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Flexible(child: listPlants()),
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
                                                    if (taraCtrl.text.isEmpty ||
                                                        capacidadCtrl
                                                            .text.isEmpty ||
                                                        catPlanta.idCatPlanta ==
                                                            null) {
                                                      dialogs.showInfoDialog(
                                                          context,
                                                          "¡Atención!",
                                                          "Favor de validar los campos marcados con asterisco (*)");
                                                    } else {
                                                      await TarasProvider()
                                                          .createTara(
                                                        taraCtrl.text.trim(),
                                                        capacidadCtrl.text
                                                            .trim(),
                                                        catPlanta.idCatPlanta!,
                                                      )
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
                                                              "Ocurrió un error al crear la tara : ${RxVariables.errorMessage}");
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
                                                          //Navigator.pushReplacementNamed(context, RouteNames.clienteIndex);
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

  Widget listPlants() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: AppExpansionTile(
        key: catPlanKey,
        initiallyExpanded: false,
        title: Text(
          catPlanta.nombrePlanta ?? "* Planta",
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
        children: [
          Container(
            //height: MediaQuery.of(context).size.height*.2,
            child: FutureBuilder(
              future: futureTara,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    //physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: RxVariables.dataFromUsers.listPlants!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            catPlanta =
                                RxVariables.dataFromUsers.listPlants![index];
                            catPlanKey.currentState!.collapse();
                          });
                        },
                        child: Container(
                          color: Colors.grey[100],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                    RxVariables.dataFromUsers.listPlants![index]
                                        .nombrePlanta!,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13)),
                              ),
                              Container(
                                width: double.infinity,
                                height: .5,
                                color: Colors.grey[300],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
