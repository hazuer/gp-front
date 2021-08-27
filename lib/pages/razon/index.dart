import 'package:flutter/material.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/models/status_model.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/provider/razon/razonesProvider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/app_scaffold.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/widgets/razon/table_razon.dart';

class RazonesIndex extends StatefulWidget {
  const RazonesIndex({Key? key}) : super(key: key);

  @override
  _RazonesIndexState createState() => _RazonesIndexState();
}

class _RazonesIndexState extends State<RazonesIndex> {
  late Future futureRazones;
  late Future futureFields;
  bool isLoading = false;

  String pathFilter = "?porPagina=20";
  TextEditingController razonCtrl = TextEditingController();
  Plant plant = Plant();
  StatusModel status = StatusModel();

  ListUsersProvider listProvider = ListUsersProvider();
  RazonesProvider razonesProvider = RazonesProvider();

  final GlobalKey<AppExpansionTileState> plantsKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> statusKey = new GlobalKey();

  @override
  void initState() {
    futureRazones = razonesProvider.listRazones();
    futureFields = listProvider.dataListUser();
    // futureFields = razonesProvider.getAllRazones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;

    return AppScaffold(
      pageTitle: 'Catálogos / Razones',
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffF5F6F5),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                //height: MediaQuery.of(context).size.width*.8,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xffffffff),
                      padding: EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'Listado de razones',
                            style: TextStyle(
                                color: Color(0xff313945),
                                fontSize: 13.00,
                                fontWeight: FontWeight.w200),
                          ),
                          Divider(),
                          SizedBox(height: 10.0),
                          displayMobileLayout
                              ? ListView(
                                  shrinkWrap: true,
                                  children: [
                                    CustomButton(
                                      width: MediaQuery.of(context).size.width *
                                          .2,
                                      title: "Crear razón",
                                      isLoading: false,
                                      onPressed: () async {
                                        Navigator.pushNamed(
                                            context, RouteNames.razonStore);
                                      },
                                    ),
                                    SizedBox(height: 20.0),
                                    CustomInput(
                                        hint: 'Razón', controller: razonCtrl),
                                    SizedBox(height: 15),
                                    listPlants(),
                                    SizedBox(height: 15),
                                    listStatus(),
                                    SizedBox(height: 15.0),
                                    CustomButton(
                                      width: MediaQuery.of(context).size.width *
                                          .2,
                                      title: "Buscar",
                                      isLoading: false,
                                      onPressed: () async {
                                        await _applyFilter();
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomButton(
                                      width: MediaQuery.of(context).size.width *
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
                                            margin: EdgeInsets.only(top: 50),
                                            width: 44,
                                            height: 44,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      GPColors.PrimaryColor),
                                            ),
                                          )
                                        : TableRazonList(),
                                    // : TableClienteList(),
                                  ],
                                )
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomButton(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .2,
                                          title: "Crear razón",
                                          isLoading: false,
                                          onPressed: () async {
                                            Navigator.pushNamed(
                                                context, RouteNames.razonStore);
                                          },
                                        ),
                                        SizedBox(height: 20.0),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: CustomInput(
                                                  hint: 'Razón',
                                                  controller: razonCtrl),
                                            ),
                                            SizedBox(width: 15.0),
                                            Flexible(child: listPlants()),
                                            SizedBox(width: 15.0),
                                            Flexible(child: listStatus()),
                                            SizedBox(width: 15.0),
                                            IconButton(
                                              tooltip: 'Buscar',
                                              onPressed: () async {
                                                await _applyFilter();
                                              },
                                              icon: Icon(Icons.filter_alt),
                                            ),
                                            IconButton(
                                              tooltip: 'Limpiar',
                                              onPressed: () async {
                                                await clearFilters();
                                              },
                                              icon: Icon(Icons.clear),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.0),
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
                                            : TableRazonList(),
                                        // : TableClienteList(),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listPlants() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: AppExpansionTile(
        key: plantsKey,
        initiallyExpanded: false,
        title: Text(
          plant.nombrePlanta ?? "Planta",
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
                            plant =
                                RxVariables.dataFromUsers.listPlants![index];
                            plantsKey.currentState!.collapse();
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

  Widget listStatus() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: AppExpansionTile(
        key: statusKey,
        initiallyExpanded: false,
        title: Text(
          status.estatus ?? "Estatus",
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
                    itemCount: RxVariables.dataFromUsers.listStatus!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            status =
                                RxVariables.dataFromUsers.listStatus![index];
                            statusKey.currentState!.collapse();
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

  _applyFilter() async {
    pathFilter = "?porPagina=10";
    if (razonCtrl.text.isNotEmpty) {
      pathFilter = pathFilter + "&razon=${razonCtrl.text.trim()}";
    }
    if (plant.idCatPlanta != null) {
      pathFilter = pathFilter + "&id_cat_planta=${plant.idCatPlanta}";
    }
    if (status.idCatEstatus != null) {
      pathFilter = pathFilter + "&id_cat_estatus=${status.idCatEstatus}";
    }

    print(pathFilter);
    setState(() {
      isLoading = true;
    });
    await razonesProvider.listRazonesWithFiltter(pathFilter).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  clearFilters() async {
    setState(() {
      isLoading = true;
    });
    pathFilter = "?porPagina=30";
    plant = Plant();
    status = StatusModel();
    razonCtrl.clear();

    await razonesProvider.listRazonesWithFiltter(pathFilter).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }
}
