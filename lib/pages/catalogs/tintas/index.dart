import 'package:flutter/material.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/models/status_model.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/provider/catalogs/tinta/tintasProvider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/app_scaffold.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/widgets/catalogs/tinta/table_tinta.dart';

class TintasIndex extends StatefulWidget {
  @override
  _TintasIndexState createState() => _TintasIndexState();
}

class _TintasIndexState extends State<TintasIndex> {
  late Future futureTintas;
  late Future futureFields;
  bool isLoading = false;
  String pathFilter = "?porPagina=10";
  StatusModel status = StatusModel();
  TintasProvider tintasProvider = TintasProvider();
  ListUsersProvider listProvider = ListUsersProvider();

  TextEditingController tintaCtrl = TextEditingController();
  TextEditingController codigoGpCtrl = TextEditingController();
  TextEditingController codigoSapCtrl = TextEditingController();

  final GlobalKey<AppExpansionTileState> tintaKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> statusKey = new GlobalKey();

  @override
  void initState() {
    futureTintas = tintasProvider.listTintas();
    futureFields = listProvider.dataListUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;

    return AppScaffold(
      pageTitle: 'Catálogos / Tintas',
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
                            'Listado de Tintas',
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
                                      title: "Crear Tinta",
                                      isLoading: false,
                                      onPressed: () async {
                                        Navigator.pushNamed(
                                            context, RouteNames.tintaStore);
                                      },
                                    ),
                                    SizedBox(height: 20.0),
                                    CustomButton(
                                      width: MediaQuery.of(context).size.width *
                                          .2,
                                      title: "Importar Tinta",
                                      isLoading: false,
                                      onPressed: () async {
                                        Navigator.pushNamed(
                                            context, RouteNames.tintaImport);
                                      },
                                    ),
                                    SizedBox(height: 20.0),
                                    CustomInput(
                                        hint: 'Tinta', controller: tintaCtrl),
                                    SizedBox(height: 15),
                                    CustomInput(
                                        hint: 'Código GP',
                                        controller: codigoGpCtrl),
                                    SizedBox(height: 15),
                                    CustomInput(
                                        hint: 'Código Cliente',
                                        controller: codigoSapCtrl),
                                    SizedBox(height: 15),
                                    listStatus(),
                                    SizedBox(height: 10),
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
                                        await _clearFilters();
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
                                        : TableTintaList(),
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
                                        Row(
                                          children: [
                                            Flexible(
                                              child: CustomButton(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .2,
                                                title: "Crear Tinta",
                                                isLoading: false,
                                                onPressed: () async {
                                                  Navigator.pushNamed(context,
                                                      RouteNames.tintaStore);
                                                },
                                              ),
                                            ),
                                            SizedBox(width: 20.0),
                                            Flexible(
                                              child: CustomButton(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .2,
                                                title: "Importar Tinta",
                                                isLoading: false,
                                                onPressed: () async {
                                                  Navigator.pushNamed(context,
                                                      RouteNames.tintaImport);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.0),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: CustomInput(
                                                  hint: 'Tinta',
                                                  controller: tintaCtrl),
                                            ),
                                            SizedBox(width: 15.0),
                                            Flexible(
                                              child: CustomInput(
                                                  hint: 'Código GP',
                                                  controller: codigoGpCtrl),
                                            ),
                                            SizedBox(width: 15.0),
                                            Flexible(
                                              child: CustomInput(
                                                  hint: 'Código Cliente',
                                                  controller: codigoSapCtrl),
                                            ),
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
                                                await _clearFilters();
                                              },
                                              icon: Icon(Icons.clear),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.0),
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
                                            : TableTintaList(),
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
    if (tintaCtrl.text.isNotEmpty) {
      pathFilter = pathFilter + "&nombre_tinta=${tintaCtrl.text.trim()}";
    }
    if (codigoGpCtrl.text.isNotEmpty) {
      pathFilter = pathFilter + "&codigo_gp=${codigoGpCtrl.text.trim()}";
    }
    if (codigoSapCtrl.text.isNotEmpty) {
      pathFilter = pathFilter + "&codigo_cliente=${codigoSapCtrl.text.trim()}";
    }
    if (status.idCatEstatus != null) {
      pathFilter = pathFilter + "&id_cat_estatus=${status.idCatEstatus}";
    }

    setState(() {
      isLoading = true;
    });
    await tintasProvider.listTintasWithFiltter(pathFilter).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  _clearFilters() async {
    setState(() {
      isLoading = true;
      // futureFields = tintasProvider.listTintas();
      // isLoading = false;
    });
    pathFilter = "?porPagina=10";
    status = StatusModel();
    tintaCtrl.clear();
    codigoGpCtrl.clear();
    codigoSapCtrl.clear();
    await tintasProvider.listTintasWithFiltter(pathFilter).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }
}
