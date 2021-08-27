import 'package:flutter/material.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/models/status_model.dart';
import 'package:general_products_web/provider/list_paises_provider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/app_scaffold.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/widgets/table_paises.dart';

class PaisesPage extends StatefulWidget {
  @override
  _PaisesPageState createState() => _PaisesPageState();
}

class _PaisesPageState extends State<PaisesPage> {
  late Future futurePaises;
  late Future futureFields;
  bool isLoading = false;
  String path = "?porPagina=10";
  StatusModel status = StatusModel();
  final paisController = TextEditingController();
  final paisNuevoController = TextEditingController();
  ListPaisesProvider listPaisesProvider = ListPaisesProvider();
  final GlobalKey<AppExpansionTileState> catEstatusKey = new GlobalKey();

  @override
  void initState() {
    futurePaises = listPaisesProvider.listPaises();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;

    return AppScaffold(
      pageTitle: 'Catálogos / Paises',
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffF5F6F5),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 26.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xffffffff),
                      padding: EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Listado de paises',
                            style: TextStyle(
                                color: Color(0xff313945),
                                fontSize: 14.08,
                                fontWeight: FontWeight.w200),
                          ),
                          Divider(),
                          SizedBox(height: 10),
                          displayMobileLayout
                              ? ListView(
                                  shrinkWrap: true,
                                  children: [
                                    CustomButton(
                                      width: MediaQuery.of(context).size.width *
                                          .2,
                                      title: "Crear País",
                                      isLoading: false,
                                      onPressed: () async {
                                        Navigator.pushNamed(
                                            context, RouteNames.paisCreate);
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    CustomInput(
                                      controller: paisController,
                                      hint: 'Pais',
                                    ),
                                    SizedBox(height: 15),
                                    listStatus(),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomButton(
                                      width: MediaQuery.of(context).size.width *
                                          .2,
                                      title: "Buscar",
                                      isLoading: false,
                                      onPressed: () async {
                                        await applyFilter();
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    CustomButton(
                                      width: MediaQuery.of(context).size.width *
                                          .2,
                                      title: "Limpiar",
                                      isLoading: false,
                                      onPressed: () async {
                                        await clearFilters();
                                      },
                                    ),
                                    SizedBox(height: 15),
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
                                        : TablePaisesList()
                                  ],
                                )
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height * .7,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: CustomButton(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .2,
                                                title: "Crear País",
                                                isLoading: false,
                                                onPressed: () async {
                                                  Navigator.pushNamed(context,
                                                      RouteNames.paisCreate);
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
                                                    controller: paisController,
                                                    hint: "País")),
                                            SizedBox(width: 15),
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
                                            : TablePaisesList()
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
        key: catEstatusKey,
        initiallyExpanded: false,
        title: Text(
          status.estatus ?? "Estatus",
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
        children: [
          Container(
            //height: MediaQuery.of(context).size.height*.2,
            child: FutureBuilder(
              future: futurePaises,
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
    path = "?porPagina=10";
    if (paisController.text.isNotEmpty) {
      path = path + "&nombre_pais=${paisController.text.trim()}";
    }
    if (status.idCatEstatus != null) {
      path = path + "&id_cat_estatus=${status.idCatEstatus}";
    }

    print(path);
    setState(() {
      isLoading = true;
    });

    await listPaisesProvider.listPaisesWithFilters(path).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  clearFilters() async {
    setState(() {
      isLoading = true;
    });
    path = "?porPagina = 30";
    status = StatusModel();
    paisController.clear();

    await listPaisesProvider.listPaisesWithFilters(path).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }
}
