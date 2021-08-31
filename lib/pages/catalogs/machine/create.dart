import 'package:flutter/material.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/provider/catalogs/machine/machinesProvider.dart';
import 'package:general_products_web/widgets/catalogs/machine/machineDialog.dart';

import '../../../widgets/app_scaffold.dart';

class MachineCreate extends StatefulWidget {
  MachineCreate({Key? key}) : super(key: key);

  @override
  _MachineCreateState createState() => _MachineCreateState();
}

class _MachineCreateState extends State<MachineCreate> {
  late Future futureMachine;
  bool isLoading = false;
  String headerFilter = "?porPagina = 20";
  TextEditingController machineCtrl = TextEditingController();
  TextEditingController modelCtrl = TextEditingController();
  Plant catPlanta = Plant();
  MachinesProvider machinesProvider = MachinesProvider();
  MachineDialog dialogs = MachineDialog();
  final GlobalKey<AppExpansionTileState> catPlanKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> catEstatusKey = new GlobalKey();

  @override
  void initState() {
    futureMachine = machinesProvider.getAllMachines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;

    return AppScaffold(
        pageTitle: "Catálogos / Máquinas / Crear",
        backButton: true,
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xffF5F6F5),
            child: Column(
              children: <Widget>[
                Container(
                    width: double.infinity,
                    //height: MediaQuery.of(context).size.width*.8,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                                          controller: machineCtrl,
                                          hint: "* Nombre Máquina"),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      CustomInput(
                                          controller: modelCtrl,
                                          hint: "* Modelo"),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      listPlants(),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      CustomButton(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        title: 'Crear',
                                        isLoading: false,
                                        onPressed: () async {
                                          if (machineCtrl.text.isEmpty ||
                                              modelCtrl.text.isEmpty ||
                                              catPlanta.idCatPlanta == null) {
                                            dialogs.showInfoDialog(
                                                context,
                                                "¡Atención!",
                                                "Favor de validar los campos marcados con asterisco (*)");
                                          } else {
                                            await MachinesProvider()
                                                .createMachine(
                                              machineCtrl.text.trim(),
                                              modelCtrl.text.trim(),
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
                                                    "Ocurrió un error al crear la máquina : ${RxVariables.errorMessage}");
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
                                                dialogs.showInfoDialog(context,
                                                    typeAlert, message);
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
                                        MediaQuery.of(context).size.height * .7,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 20.0),
                                          Row(
                                            children: [
                                              Flexible(
                                                  child: CustomInput(
                                                      controller: machineCtrl,
                                                      hint:
                                                          "* Nombre Máquina")),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Flexible(
                                                  child: CustomInput(
                                                      controller: modelCtrl,
                                                      hint: "* Modelo")),
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
                                                  if (machineCtrl
                                                          .text.isEmpty ||
                                                      modelCtrl.text.isEmpty ||
                                                      catPlanta.idCatPlanta ==
                                                          null) {
                                                    dialogs.showInfoDialog(
                                                        context,
                                                        "¡Atención!",
                                                        "Favor de validar los campos marcados con asterisco (*)");
                                                  } else {
                                                    await MachinesProvider()
                                                        .createMachine(
                                                      machineCtrl.text.trim(),
                                                      modelCtrl.text.trim(),
                                                      catPlanta.idCatPlanta!,
                                                    )
                                                        .then((value) {
                                                      if (value == null) {
                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                        Navigator.pop(context);
                                                        dialogs.showInfoDialog(
                                                            context,
                                                            "¡Error!",
                                                            "Ocurrió un error al crear la máquina : ${RxVariables.errorMessage}");
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
              future: futureMachine,
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
