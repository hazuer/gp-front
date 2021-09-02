import 'package:flutter/material.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/models/tinta/tintasModel.dart';
import 'package:general_products_web/provider/catalogs/design/designsProvider.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/provider/tinta/tintasProvider.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/catalogs/design/table_tintas.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/widgets/tara/taraDialog.dart';

import '../../../widgets/app_scaffold.dart';

class DesignCreate extends StatefulWidget {
  DesignCreate({Key? key}) : super(key: key);

  @override
  _DesignCreateState createState() => _DesignCreateState();
}

class _DesignCreateState extends State<DesignCreate> {
  late Future futureTintas;
  late Future futureTintas2;
  late Future futureFields;
  bool isLoading = false;
  String headerFilter = "?porPagina = 20";

  TextEditingController designCtrl = TextEditingController();
  TextEditingController descripcionCtrl = TextEditingController();
  TextEditingController tintasCtrl = TextEditingController();

  Plant catPlanta = Plant();
  ListUsersProvider listProvider = ListUsersProvider();

  // TarasProvider tarasProvider = TarasProvider();

  TintasProvider tintasProvider = TintasProvider();
  DesignsProvider designsProvider = DesignsProvider();

  TaraDialog dialogs = TaraDialog();
  List<InkList> tintas = [];
  InkList catTintas = InkList();
  // ListTintasModel catTintas = ListTintasModel(inkList: []);
  final GlobalKey<AppExpansionTileState> catPlantsKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> catTintasKey = new GlobalKey();
  // final GlobalKey<AppExpansionTileState> catEstatusKey = new GlobalKey();

  @override
  void initState() {
    futureTintas = tintasProvider.listTintas();
    // final idPlant = RxVariables.designSelected.idCatPlanta;
    // futureTintas2 = tintasProvider.listTintasWithFiltter(path);
    // futureTintas =
    //     tintasProvider.listTintasWithFiltter('?id_cat_planta=$idPlant');
    // futureTintas2 = designsProvider.buscarTintas(
    // RxVariables.designSelected.tintas[nombreTinta],
    // RxVariables.designSelected.idCatPlanta!);
    // RxVariables.designSelected.
    futureFields = listProvider.dataListUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;

    return AppScaffold(
        pageTitle: "Catálogos / Diseños / Crear",
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
                                          controller: designCtrl,
                                          hint: "* Nombre diseño"),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      CustomInput(
                                          controller: descripcionCtrl,
                                          hint: "* Descripción"),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      listarPlants(),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      listarTintas(),
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
                                          if (designCtrl.text.isEmpty ||
                                              descripcionCtrl.text.isEmpty ||
                                              catPlanta.idCatPlanta == null ||
                                              catTintas.idCatTinta == null) {
                                            dialogs.showInfoDialog(
                                                context,
                                                "¡Atención!",
                                                "Favor de validar los campos marcados con asterisco (*)");
                                          } else {
                                            await DesignsProvider()
                                                .createDesign(
                                              designCtrl.text.trim(),
                                              descripcionCtrl.text.trim(),
                                              catPlanta.idCatPlanta!,
                                              [catTintas.idCatTinta!],
                                            ).then((value) {
                                              if (value == null) {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                                // Navigator.pop(context);
                                                dialogs.showInfoDialog(
                                                    context,
                                                    "¡Error!",
                                                    "Ocurrió un error al crear el diseño : ${RxVariables.errorMessage}");
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 20.0),
                                          Row(
                                            children: [
                                              Flexible(
                                                  child: CustomInput(
                                                      controller: designCtrl,
                                                      hint: "* Nombre diseño")),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Flexible(
                                                  child: CustomInput(
                                                      controller:
                                                          descripcionCtrl,
                                                      hint: "* Descripción")),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Flexible(child: listarPlants()),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Flexible(child: listarTintas()),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Flexible(
                                                  child: listarTintasCheck()),
                                              SizedBox(
                                                width: 15,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20.0),
                                          CustomButton(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .2,
                                            title: 'Crear',
                                            isLoading: false,
                                            onPressed: () async {
                                              print(tintas.length);
                                              print(tintas);
                                              print(tintas.toString());
                                              if (designCtrl.text.isEmpty ||
                                                  descripcionCtrl
                                                      .text.isEmpty ||
                                                  catPlanta.idCatPlanta ==
                                                      null ||
                                                  catTintas.idCatTinta ==
                                                      null) {
                                                dialogs.showInfoDialog(
                                                    context,
                                                    "¡Atención!",
                                                    "Favor de validar los campos marcados con asterisco (*)");
                                              } else {
                                                await DesignsProvider()
                                                    .createDesign(
                                                  designCtrl.text.trim(),
                                                  descripcionCtrl.text.trim(),
                                                  catPlanta.idCatPlanta!,
                                                  [catTintas.idCatTinta!],
                                                ).then((value) {
                                                  if (value == null) {
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                    Navigator.pop(context);
                                                    dialogs.showInfoDialog(
                                                        context,
                                                        "¡Error!",
                                                        "Ocurrió un error al crear el diseño : ${RxVariables.errorMessage}");
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

  Widget listarTintas() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: AppExpansionTile(
        key: catTintasKey,
        initiallyExpanded: false,
        title: Text(
          catTintas.nombreTinta ?? "* Tinta",
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
        children: [
          Container(
            //height: MediaQuery.of(context).size.height*.2,
            child: FutureBuilder(
              future: futureTintas,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    //physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: RxVariables.gvListTinta.inkList.length,
                    // itemCount: RxVariables.listTinta.inkList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            catTintas = RxVariables.gvListTinta.inkList[index];
                            catTintasKey.currentState!.collapse();

                            // catPlanta =
                            //     RxVariables.dataFromUsers.listPlants![index];
                            // catPlanKey.currentState!.collapse();
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
                                    // catTintas.nombreTinta ?? '* Tinta',
                                    RxVariables.gvListTinta.inkList[index]
                                        .nombreTinta!,
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

  Widget listarPlants() {
    // futureTintas = plants.
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: AppExpansionTile(
        key: catPlantsKey,
        initiallyExpanded: false,
        title: Text(
          catPlanta.nombrePlanta ?? "* Planta",
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
        children: [
          Container(
            //height: MediaQuery.of(context).size.height*.2,
            child: FutureBuilder(
              future: futureFields,
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
                            catPlantsKey.currentState!.collapse();
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

  bool valor1 = false;
  bool valor2 = false;
  bool valor3 = false;
  Widget listarTintasCheck() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: AppExpansionTile(
        initiallyExpanded: false,
        title: Text(
          catTintas.nombreTinta ?? "* Tinta",
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
        children: [
          Container(
            child: FutureBuilder(
              future: futureFields,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  bool valorIndividual = false;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: RxVariables.gvListTinta.inkList.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(valorIndividual);
                      return CheckboxListTile(
                        title: Text(
                            RxVariables.gvListTinta.inkList[index].nombreTinta!,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 13)),
                        value: valorIndividual,
                        onChanged: (value) {
                          setState(() {
                            valorIndividual = value!;
                            print(valorIndividual);
                            if (valorIndividual) {
                              tintas
                                  .add(RxVariables.gvListTinta.inkList[index]);
                            }
                          });
                        },
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          // CheckboxListTile(
          //   title: Text('Jona1'),
          //   value: valor1,
          //   onChanged: (value) {
          //     setState(() {
          //       valor1 = value!;
          //     });
          //   },
          // ),
          // CheckboxListTile(
          //   title: Text('Jona2'),
          //   value: valor2,
          //   onChanged: (value) {
          //     setState(() {
          //       valor2 = value!;
          //     });
          //   },
          // ),
          // CheckboxListTile(
          //   title: Text('Jona3'),
          //   value: valor3,
          //   onChanged: (value) {
          //     setState(() {
          //       valor3 = value!;
          //     });
          //   },
          // ),
        ],
      ),
    );
  }

  Widget listarTintas2() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: AppExpansionTile(
        key: catTintasKey,
        initiallyExpanded: false,
        title: Text(
          catTintas.nombreTinta ?? "* Tinta",
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
        children: [
          Container(
            //height: MediaQuery.of(context).size.height*.2,
            child: FutureBuilder(
              future: futureTintas,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    //physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: RxVariables.gvListTinta.inkList.length,
                    // itemCount: RxVariables.listTinta.inkList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            catTintas = RxVariables.gvListTinta.inkList[index];
                            catTintasKey.currentState!.collapse();

                            // catPlanta =
                            //     RxVariables.dataFromUsers.listPlants![index];
                            // catPlanKey.currentState!.collapse();
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            tintas.add(RxVariables.gvListTinta.inkList[index]);
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
                                    // catTintas.nombreTinta ?? '* Tinta',
                                    RxVariables.gvListTinta.inkList[index]
                                        .nombreTinta!,
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

  // Widget listStatus() {
  //   return Container(
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
  //     child: AppExpansionTile(
  //       key: catEstatusKey,
  //       initiallyExpanded: false,
  //       title: Text(
  //         catEstatus.estatus ?? "Estatus",
  //         style: TextStyle(color: Colors.black54, fontSize: 13),
  //       ),
  //       children: [
  //         Container(
  //           //height: MediaQuery.of(context).size.height*.2,
  //           child: FutureBuilder(
  //             future: futureTara,
  //             builder: (BuildContext context, AsyncSnapshot snapshot) {
  //               if (snapshot.hasData) {
  //                 return ListView.builder(
  //                   //physics: NeverScrollableScrollPhysics(),
  //                   shrinkWrap: true,
  //                   itemCount: RxVariables.dataFromUsers.listStatus!.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return GestureDetector(
  //                       onTap: () {
  //                         setState(() {
  //                           catEstatus =
  //                               RxVariables.dataFromUsers.listStatus![index];
  //                           catEstatusKey.currentState!.collapse();
  //                         });
  //                       },
  //                       child: Container(
  //                         color: Colors.grey[100],
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Padding(
  //                               padding: EdgeInsets.all(12),
  //                               child: Text(
  //                                   RxVariables.dataFromUsers.listStatus![index]
  //                                       .estatus!,
  //                                   style: TextStyle(
  //                                       color: Colors.black54, fontSize: 13)),
  //                             ),
  //                             Container(
  //                               width: double.infinity,
  //                               height: .5,
  //                               color: Colors.grey[300],
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                 );
  //               } else {
  //                 return CircularProgressIndicator();
  //               }
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
