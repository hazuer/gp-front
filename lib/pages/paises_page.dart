import 'package:flutter/material.dart';
import 'package:general_products_web/models/status_model.dart';
import 'package:general_products_web/provider/list_paises_provider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/widgets/app_scaffold.dart';
import 'package:general_products_web/widgets/custom_button.dart';
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

  @override
  void initState() {
    futurePaises = listPaisesProvider.listPaises();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;

    return AppScaffold(
      pageTitle: 'Paises / Listado de paises',
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
                          displayMobileLayout
                              ? Column(children: [
                                  Container(
                                      child: Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .8,
                                        child: CustomInput(
                                          controller: paisNuevoController,
                                          hint: '* Pais',
                                        ),
                                      ),
                                      SizedBox(height: 25),
                                      CustomButton(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .8,
                                        title: 'Nuevo',
                                        isLoading: false,
                                        onPressed: () async {
                                          await listPaisesProvider.crearPais(
                                            paisNuevoController.text.trim(),
                                          );
                                          paisNuevoController.clear();
                                          FocusScope.of(context).unfocus();
                                        },
                                      ),
                                    ],
                                  )),
                                  Container(
                                    // height: MediaQuery.of(context).size.height * .7,
                                    height:
                                        MediaQuery.of(context).size.height * .2,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .5,
                                          child: CustomInput(
                                            controller: paisController,
                                            hint: '* Pais',
                                          ),
                                        ),
                                        SizedBox(width: 25),
                                        IconButton(
                                          onPressed: () async {
                                            await _applyFilter();
                                            paisController.clear();
                                            FocusScope.of(context).unfocus();
                                          },
                                          icon: Icon(Icons.filter_alt),
                                        ),
                                        SizedBox(width: 25),
                                        IconButton(
                                          onPressed: () {
                                            // await clearFilters();
                                          },
                                          icon: Icon(Icons.clear),
                                        ),
                                      ],
                                    ),
                                  ),
                                ])
                              : Column(children: [
                                  Container(
                                      child: Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        child: CustomInput(
                                          controller: paisNuevoController,
                                          hint: '* Pais',
                                        ),
                                      ),
                                      SizedBox(width: 25),
                                      CustomButton(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        title: 'Nuevo',
                                        isLoading: false,
                                        onPressed: () async {
                                          await listPaisesProvider.crearPais(
                                            paisNuevoController.text.trim(),
                                          );
                                          paisNuevoController.clear();
                                          FocusScope.of(context).unfocus();
                                        },
                                      ),
                                    ],
                                  )),
                                  Container(
                                    // height: MediaQuery.of(context).size.height * .7,
                                    height:
                                        MediaQuery.of(context).size.height * .1,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .2,
                                          child: CustomInput(
                                            controller: paisController,
                                            hint: '* Pais',
                                          ),
                                        ),
                                        SizedBox(width: 25),
                                        IconButton(
                                          onPressed: () async {
                                            await _applyFilter();
                                            paisController.clear();
                                            FocusScope.of(context).unfocus();
                                          },
                                          icon: Icon(Icons.filter_alt),
                                        ),
                                        SizedBox(width: 25),
                                        IconButton(
                                          onPressed: () {
                                            // await clearFilters();
                                          },
                                          icon: Icon(Icons.clear),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          SizedBox(height: 20.0),
                          isLoading
                              ? Container(
                                  margin: EdgeInsets.only(top: 50),
                                  width: 44,
                                  height: 44,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        GPColors.PrimaryColor),
                                  ),
                                )
                              : TablePaisesList(),
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

  _applyFilter() async {
    path = "?porPagina=10";
    if (paisController.text.isNotEmpty) {
      path = path + "&nombre_pais=${paisController.text.trim()}";
    }
    // if (status.idCatEstatus != null) {
    //   path = path + "&id_cat_estatus=${status.idCatEstatus}";
    // }

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
}
