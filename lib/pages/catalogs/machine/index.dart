import 'package:flutter/material.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/models/status_model.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/provider/catalogs/machine/machinesProvider.dart';
import 'package:general_products_web/widgets/catalogs/machine/tblMachine.dart';

import '../../../widgets/app_scaffold.dart';

class MachineIndex extends StatefulWidget {
  MachineIndex({Key? key}) : super(key: key);

  @override
  _MachineIndexState createState() => _MachineIndexState();
}

class _MachineIndexState extends State<MachineIndex> {
  late Future futureMachine;
  bool isLoading                                       = false;
  String headerFilter                                  = "?porPagina = 20";
  TextEditingController maquinaCtrl                       = TextEditingController();
  TextEditingController modelodCtrl                  = TextEditingController();
  Plant catPlanta                                      = Plant();
  StatusModel catEstatus                               = StatusModel();
  MachinesProvider machinesProvider                    = MachinesProvider();
  final GlobalKey<AppExpansionTileState> catPlanKey    = new GlobalKey();
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
      pageTitle: "Catálogos / Máquinas",
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
                        Text('Listado de Máquinas', style:
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
                            CustomButton(
                              width: MediaQuery.of(context).size.width *.2,
                              title: "Crear Máquina",
                              isLoading: false,
                              onPressed: () async {
                                Navigator.pushNamed(context, RouteNames.machineCreate);
                              },
                            ),
                            SizedBox(height: 15,),
                            CustomInput(controller: maquinaCtrl, hint: "Nombre Máquina"),
                            SizedBox(height: 15,),
                            CustomInput(controller: modelodCtrl,hint: "Modelo"),
                            SizedBox(height: 15,),
                            listPlants(),
                            SizedBox(height: 15,),
                            listStatus(),
                            SizedBox(height: 15,),
                            CustomButton(
                              width: MediaQuery.of(context).size.width * .2,
                              title: "Buscar",
                              isLoading: false,
                              onPressed: () async {
                                await applyFilter();
                              },
                            ),
                            SizedBox(height: 15,),
                            CustomButton(
                              width: MediaQuery.of(context).size.width * .2,
                              title: "Limpiar",
                              isLoading: false,
                              onPressed: () async {
                                await clearFilters();
                              },
                            ),
                            SizedBox(height: 30,),
                            isLoading ? 
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              width: 44,
                              height: 44,
                              child: CircularProgressIndicator(
                                valueColor:AlwaysStoppedAnimation<Color>(GPColors.PrimaryColor),
                              ),
                            )
                            : 
                            TableMachineList()
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
                                Row(
                                  children: [
                                    Flexible(
                                      child:CustomButton(
                                        width: MediaQuery.of(context).size.width *.2,
                                        title: "Crear Máquina",
                                        isLoading: false,
                                        onPressed: () async {
                                          Navigator.pushNamed(context,
                                            RouteNames.machineCreate);
                                        },
                                      ),
                                    ),
                                  ]
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    Flexible(
                                      child: CustomInput(
                                        controller:maquinaCtrl,
                                        hint: "Nombre Máquina"
                                      )
                                    ),
                                    SizedBox(width: 15,),
                                    Flexible(
                                      child: CustomInput(
                                        controller:modelodCtrl,
                                        hint: "Modelo"
                                      )
                                    ),
                                    SizedBox(width: 15,),
                                    Flexible(child: listPlants()),
                                    SizedBox(width: 15,),
                                    Flexible(child: listStatus()),
                                    SizedBox(width: 15,),
                                    IconButton(  
                                      tooltip: "Buscar",
                                      onPressed: () async {
                                        await applyFilter();
                                      },
                                      icon: Icon(Icons.filter_alt),
                                    ),
                                    IconButton(
                                      tooltip: "Limpiar",
                                      onPressed: () async {
                                        await clearFilters();
                                      },
                                      icon: Icon(Icons.clear),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30,),
                                isLoading ?
                                Container(
                                  margin:EdgeInsets.only(top: 50),
                                  width: 44,
                                  height:44,
                                  child:CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(GPColors.PrimaryColor),),
                                )
                                : 
                                TableMachineList()
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
              future: futureMachine,
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
    if (maquinaCtrl.text.isNotEmpty) {
      headerFilter = headerFilter + "&nombre_maquina=${maquinaCtrl.text.trim()}";
    }
    if (modelodCtrl.text.isNotEmpty) {
      headerFilter = headerFilter + "&modelo=${modelodCtrl.text.trim()}";
    }

    if (catPlanta.idCatPlanta != null) {
      headerFilter = headerFilter + "&id_cat_planta=${catPlanta.idCatPlanta}";
    }

    if (catEstatus.idCatEstatus != null) {
      headerFilter = headerFilter + "&id_cat_estatus=${catEstatus.idCatEstatus}";
    }

    setState(() {
      isLoading = true;
    });
    await machinesProvider.headerFilterMachine(headerFilter).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  clearFilters() async {
    setState(() {
      isLoading = true;
    });
    headerFilter = "?porPagina = 30";
    catPlanta    = Plant();
    catEstatus   = StatusModel();
    maquinaCtrl.clear();
    modelodCtrl.clear();

    await machinesProvider.headerFilterMachine(headerFilter).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }
}
