import 'package:flutter/material.dart';
import 'package:general_products_web/app/auth/login.dart';
import 'package:general_products_web/models/status_model.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/provider/catalogs/plant/plantsProvider.dart';
import 'package:general_products_web/widgets/catalogs/plant/tblPlant.dart';
import 'package:general_products_web/models/catalogs/plant/catPaisModel.dart';

import '../../../widgets/app_scaffold.dart';

class PlantIndex extends StatefulWidget {
  PlantIndex({Key? key}) : super(key: key);

  @override
  _PlantIndexState createState() => _PlantIndexState();
}

class _PlantIndexState extends State<PlantIndex> {
  late Future futurePlant;
  late Future futurecatPais;
  bool isLoading = false;
  String headerFilter = "?porPagina = 20";
  TextEditingController plantCtrl = TextEditingController();
  CatPaisModel catPais = CatPaisModel();
  StatusModel catEstatus = StatusModel();
  PlantsProvider plantsProvider = PlantsProvider();
  final GlobalKey<AppExpansionTileState> catPaisKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> catEstatusKey = new GlobalKey();

  final currentUser = RxVariables.loginResponse.data!;

  @override
  void initState() {
    futurePlant = plantsProvider.getAllPlants();
    futurecatPais = plantsProvider.getAllPais();
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
          pageTitle: "Cat??logos / Plantas",
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
                                'Listado de Plantas',
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
                                        CustomButton(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .2,
                                          title: "Crear Planta",
                                          isLoading: false,
                                          onPressed: () async {
                                            Navigator.pushNamed(context,
                                                RouteNames.plantsCreate);
                                          },
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        CustomInput(
                                            controller: plantCtrl,
                                            hint: "Nombre Planta"),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        listPais(),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        listStatus(),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        CustomButton(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .2,
                                          title: "Buscar",
                                          isLoading: false,
                                          onPressed: () async {
                                            await applyFilter();
                                          },
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        CustomButton(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .2,
                                          title: "Limpiar",
                                          isLoading: false,
                                          onPressed: () async {
                                            await clearFilters();
                                          },
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        isLoading
                                            ? Container(
                                                margin:
                                                    EdgeInsets.only(top: 50),
                                                width: 44,
                                                height: 44,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          GPColors
                                                              .PrimaryColor),
                                                ),
                                              )
                                            : TablePlantList()
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
                                            Row(children: [
                                              Flexible(
                                                child: CustomButton(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .2,
                                                  title: "Crear Planta",
                                                  isLoading: false,
                                                  onPressed: () async {
                                                    Navigator.pushNamed(
                                                        context,
                                                        RouteNames
                                                            .plantsCreate);
                                                  },
                                                ),
                                              ),
                                            ]),
                                            SizedBox(height: 20.0),
                                            Row(
                                              children: [
                                                Flexible(
                                                    child: CustomInput(
                                                        controller: plantCtrl,
                                                        hint: "Nombre Planta")),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Flexible(child: listPais()),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Flexible(child: listStatus()),
                                                SizedBox(
                                                  width: 15,
                                                ),
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
                                            SizedBox(
                                              height: 30,
                                            ),
                                            isLoading
                                                ? Container(
                                                    margin: EdgeInsets.only(
                                                        top: 50),
                                                    width: 44,
                                                    height: 44,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              GPColors
                                                                  .PrimaryColor),
                                                    ),
                                                  )
                                                : TablePlantList()
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

  Widget listPais() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: AppExpansionTile(
        key: catPaisKey,
        initiallyExpanded: false,
        title: Text(
          catPais.nombrePais ?? "Pa??s",
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
        children: [
          Container(
            //height: MediaQuery.of(context).size.height*.2,
            child: FutureBuilder(
              future: futurePlant,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    //physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: RxVariables.gvListCatPais.listCountries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            catPais =
                                RxVariables.gvListCatPais.listCountries[index];
                            catPaisKey.currentState!.collapse();
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
                                    RxVariables.gvListCatPais
                                        .listCountries[index].nombrePais!,
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

  Widget listStatus() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
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
              future: futurePlant,
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
                            catEstatus =
                                RxVariables.dataFromUsers.listStatus![index];
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
                                    RxVariables.dataFromUsers.listStatus![index]
                                        .estatus!,
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

  applyFilter() async {
    headerFilter = "?porPagina=20";
    if (plantCtrl.text.isNotEmpty) {
      headerFilter = headerFilter + "&nombre_planta=${plantCtrl.text.trim()}";
    }

    if (catPais.idCatPais != null) {
      headerFilter = headerFilter + "&id_cat_pais=${catPais.idCatPais}";
    }

    if (catEstatus.idCatEstatus != null) {
      headerFilter =
          headerFilter + "&id_cat_estatus=${catEstatus.idCatEstatus}";
    }

    setState(() {
      isLoading = true;
    });
    await plantsProvider.headerFilterPlant(headerFilter).then((value) {
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
    catPais = CatPaisModel();
    catEstatus = StatusModel();
    plantCtrl.clear();

    await plantsProvider.headerFilterPlant(headerFilter).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }
}
