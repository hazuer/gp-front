import 'package:flutter/material.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/models/status_model.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
//import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/provider/tara/tarasProvider.dart';
import 'package:general_products_web/widgets/tara/tblTara.dart';

import '../../../widgets/app_scaffold.dart';

class TaraCreate extends StatefulWidget {
  TaraCreate({Key? key}) : super(key: key);

  @override
  _TaraCreateState createState() => _TaraCreateState();
}

class _TaraCreateState extends State<TaraCreate> {
  //late Future fUser;
  late Future futureTara;
  bool isLoading                                       = false;
  String headerFilter                                  = "?porPagina = 20";
  TextEditingController taraCtrl                       = TextEditingController();
  TextEditingController capacidadCtrl                  = TextEditingController();
  Plant catPlanta                                      = Plant();
  StatusModel catEstatus                               = StatusModel();
  TarasProvider tarasProvider                          = TarasProvider();
  final GlobalKey<AppExpansionTileState> catPlanKey    = new GlobalKey();
  final GlobalKey<AppExpansionTileState> catEstatusKey = new GlobalKey();

  @override
  void initState() {
    futureTara = tarasProvider.getAllTaras();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;

    return AppScaffold(
      pageTitle: "Catálogos / Taras / Crear",
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffF5F6F5),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                //height: MediaQuery.of(context).size.width*.8,
                margin:EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child:Column(children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xffffffff),
                    padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text('Crear', style:
                          TextStyle(
                            color: Color(0xff313945),
                            fontSize: 13.00,
                            fontWeight: FontWeight.w200
                          ),
                        ),
                        Divider(),
                        SizedBox(height: 10),
                        // __ __
                        //|  \  \ ___  _ _
                        //|     |/ . \| | |
                        //|_|_|_|\___/|__/
                        displayMobileLayout ? 
                        ListView(
                          shrinkWrap: true,
                          children: [
                            SizedBox(height: 15,),
                            CustomInput(controller: taraCtrl, hint: "Tara"),
                            SizedBox(height: 15,),
                            CustomInput(controller: capacidadCtrl,hint: "Capacidad"),
                            SizedBox(height: 15,),
                            listPlants(),
                            SizedBox(height: 15,),
                            listStatus(),
                            SizedBox(height: 30,),
                          ],
                        )
                        // _ _ _       _
                        //| | | | ___ | |_
                        //| | | |/ ._>| . \
                        //|__/_/ \___.|___/
                        : 
                        Container(
                          height:MediaQuery.of(context).size.height * .7,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    Flexible(
                                      child: CustomInput(
                                        controller:taraCtrl,
                                        hint: "Tara"
                                      )
                                    ),
                                    SizedBox(width: 15,),
                                    Flexible(
                                      child: CustomInput(
                                        controller:capacidadCtrl,
                                        hint: "Capacidad"
                                      )
                                    ),
                                    SizedBox(width: 15,),
                                    Flexible(child: listPlants()),
                                    SizedBox(width: 15,),
                                    Flexible(child: listStatus()),
                                    SizedBox(width: 15,),
                                  ],
                                ),
                                SizedBox(height: 30,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ])
              )
            ],
          ),
        ),
      )
    );
  }

  Widget listPlants() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: AppExpansionTile(
        key: catPlanKey,
        initiallyExpanded: false,
        title: Text(
          catPlanta.nombrePlanta ?? "Planta",
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
                            catPlanta = RxVariables.dataFromUsers.listPlants![index];
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
                                  RxVariables.dataFromUsers.listPlants![index].nombrePlanta!,
                                  style: TextStyle(color: Colors.black54, fontSize: 13)
                                ),
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

  Widget listStatus() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: AppExpansionTile(
        key: catEstatusKey,
        initiallyExpanded: false,
        title: Text(
          catEstatus.estatus ?? "Estatus",
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
                    itemCount: RxVariables.dataFromUsers.listStatus!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            catEstatus = RxVariables.dataFromUsers.listStatus![index];
                            catEstatusKey.currentState!.collapse();
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
                                    RxVariables.dataFromUsers.listStatus![index].estatus!,
                                    style: TextStyle(color: Colors.black54, fontSize: 13
                                  )
                                ),
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

  applyFilter() async {
    headerFilter = "?porPagina=20";
    if (taraCtrl.text.isNotEmpty) {
      headerFilter = headerFilter + "&nombre_tara=${taraCtrl.text.trim()}";
    }
    if (capacidadCtrl.text.isNotEmpty) {
      headerFilter = headerFilter + "&capacidad=${capacidadCtrl.text.trim()}";
    }

    if (catPlanta.idCatPlanta != null) {
      headerFilter = headerFilter + "&id_cat_planta=${catPlanta.idCatPlanta}";
    }

    if (catEstatus.idCatEstatus != null) {
      headerFilter = headerFilter + "&id_cat_estatus=${catEstatus.idCatEstatus}";
    }

    //print(headerFilter);
    setState(() {
      isLoading = true;
    });
    //await tarasProvider.headerFilterTara(headerFilter).then((value) {
      //setState(() {
        //isLoading = false;
      //});
    //});
  }

  clearFilters() async {
    setState(() {
      isLoading = true;
    });
    headerFilter = "?porPagina = 30";
    catPlanta    = Plant();
    catEstatus   = StatusModel();
    taraCtrl.clear();
    capacidadCtrl.clear();

    //await tarasProvider.headerFilterTara(headerFilter).then((value) {
      //setState(() {
        //isLoading = false;
      //});
    //});
  }
}
