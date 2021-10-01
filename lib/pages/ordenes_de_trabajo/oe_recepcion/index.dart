import 'package:flutter/material.dart';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:general_products_web/app/auth/login.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catCustomersOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/dtDesignsOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catMachinesOEModel.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/provider/ordenes_de_trabajo/ordenEntregaProvider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/app_scaffold.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/widgets/ordenes_de_trabajo/recepcion/table_list_orden_entrega_recepcion.dart';

class OrdenesEntregaRecepcionIndex extends StatefulWidget {
  @override
  _OrdenesEntregaRecepcionIndexState createState() =>
      _OrdenesEntregaRecepcionIndexState();
}

class _OrdenesEntregaRecepcionIndexState
    extends State<OrdenesEntregaRecepcionIndex> {
  late Future futureOrdenEntrega;
  late Future futureFields;
  bool isLoading = false;
  String headerFilter = '?porPagina = 20';

  OrdenEntregaProvider ordenEntregaProvider = OrdenEntregaProvider();

  CatCustomersOEModel catCliente = CatCustomersOEModel();
  CatMachinesOEModel catMachines = CatMachinesOEModel();
  DtDesignsOEModel catDesigns = DtDesignsOEModel();

  TextEditingController ordenFabicacionCtrl = TextEditingController();
  TextEditingController fechaCreacionCtrl = TextEditingController();
  TextEditingController operadorCtrl = TextEditingController();
  TextEditingController tintasCtrl = TextEditingController();
  TextEditingController fechaCierreCtrl = TextEditingController();
  TextEditingController estatusCtrl = TextEditingController();

  final GlobalKey<AppExpansionTileState> catOrdenEntregaKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> catClienteKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> catMachineKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> catDesignKey = new GlobalKey();

  final currentUser = RxVariables.loginResponse.data!;

  @override
  void initState() {
    estatusCtrl.text = 'Nuevo';
    // futureOrdenEntrega = ordenEntregaProvider.getOrdenesDeEntregaRecepcion();
    // Aqui hay que modificar para que sea getFieldsRecepción en cuanto
    // esten listos los campos correspondientes
    futureFields = ordenEntregaProvider.getFields();
    // fechaCreacion = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;

    if (currentUser.catProfile!.profileId != 3 &&
        currentUser.catProfile!.profileId != 6) {
      ListUsersProvider().logOut();

      return LoginPage();
    } else {
      return AppScaffold(
        pageTitle:
            'Orden de fabricación / Ordenes de entrega / Recepción / Listado',
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
                              'Listado de Ordenes de Entrega para Recepción',
                              style: TextStyle(
                                  color: Color(0xff313945),
                                  fontSize: 13.00,
                                  fontWeight: FontWeight.w200),
                            ),
                            Divider(),
                            SizedBox(height: 10),
                            displayMobileLayout
                                ? ListView(
                                    shrinkWrap: true,
                                    children: [
                                      CustomButton(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        title: "Leer QR",
                                        isLoading: false,
                                        onPressed: () async {
                                          // Navigator.pushNamed(
                                          //     context, RouteNames.oeCreate);
                                        },
                                      ),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          controller: ordenFabicacionCtrl,
                                          hint: "Orden de Fabricación"),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Text(
                                            'Fecha de Creación',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13),
                                          ),
                                          SizedBox(width: 10),
                                          Flexible(
                                              child: selectInitialDateTime()),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          controller: operadorCtrl,
                                          hint: "Operador Responsable"),
                                      // SizedBox(height: 15),
                                      // CustomInput(hint: "Cliente"),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          enabled: false,
                                          controller: estatusCtrl,
                                          hint: "Estatus"),
                                      SizedBox(height: 15),
                                      listMachines(),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          controller: tintasCtrl,
                                          hint: "Tintas"),
                                      SizedBox(height: 15),
                                      listDesigns(),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Text(
                                            'Fecha de Cierre',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13),
                                          ),
                                          SizedBox(width: 10),
                                          Flexible(child: selectEndDateTime()),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      CustomButton(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        title: "Buscar",
                                        isLoading: false,
                                        onPressed: () async {
                                          await applyFilter();
                                        },
                                      ),
                                      SizedBox(height: 15),
                                      CustomButton(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        title: "Limpiar",
                                        isLoading: false,
                                        onPressed: () async {
                                          await clearFilters();
                                        },
                                      ),
                                      SizedBox(height: 30),
                                      isLoading
                                          ? Container(
                                              margin: EdgeInsets.only(top: 50),
                                              width: 44,
                                              height: 44,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        GPColors.PrimaryColor),
                                              ),
                                            )
                                          // : TableListOERecepcion(),
                                          : Container(),
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
                                                  title: "Nuevo",
                                                  isLoading: false,
                                                  onPressed: () async {
                                                    // Navigator.pushNamed(context,
                                                    //     RouteNames.oeCreate);
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
                                                controller: ordenFabicacionCtrl,
                                                hint: 'Orden de fabricación',
                                              )),
                                              SizedBox(width: 15),
                                              Flexible(
                                                child: Text('Fecha de Creación',
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 13,
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              Flexible(
                                                child: selectInitialDateTime(),
                                              ),
                                              SizedBox(width: 15),
                                              Flexible(
                                                  child: CustomInput(
                                                controller: operadorCtrl,
                                                hint: 'Operador Responsable',
                                              )),
                                              // SizedBox(width: 15),
                                              // Flexible(
                                              //   child: CustomInput(
                                              //     // controller: clienteCtrl,
                                              //     hint: 'Cliente',
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              // Flexible(
                                              //   child: CustomInput(
                                              //     // controller: clienteCtrl,
                                              //     hint: 'Cliente',
                                              //   ),
                                              // ),
                                              // SizedBox(width: 15),
                                              // Flexible(child: listStatus()),
                                              Flexible(
                                                child: CustomInput(
                                                  enabled: false,
                                                  controller: estatusCtrl,
                                                  hint: 'Estatus',
                                                ),
                                              ),
                                              SizedBox(width: 15),
                                              Flexible(child: listMachines()),
                                              SizedBox(width: 15),
                                              Flexible(
                                                child: CustomInput(
                                                  // controller: tintaCtrl,
                                                  hint: 'Tinta',
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Flexible(child: listDesigns()),
                                              SizedBox(width: 10),
                                              Flexible(
                                                child: Text('Fecha de Creación',
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 13,
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              Flexible(
                                                child: selectEndDateTime(),
                                              ),
                                              SizedBox(width: 15),
                                              // Flexible(
                                              //   child: CustomInput(
                                              //     controller: fechaCierreCtrl,
                                              //     hint: 'Fecha Cierre OE',
                                              //   ),
                                              // ),
                                              // SizedBox(width: 15),
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
                                          SizedBox(height: 30),
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
                                              // : TableListOERecepcion(),
                                              : Container(),
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
  }

  DateTimePicker selectInitialDateTime() {
    return DateTimePicker(
      type: DateTimePickerType.dateTimeSeparate,
      dateMask: 'd MMM, yyyy',
      initialValue: DateTime.now().toString(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      icon: Icon(Icons.event),
      dateLabelText: 'Fecha',
      timeLabelText: 'Hora',
      selectableDayPredicate: (date) {
        // Deshabilita fines de semana
        // if (date.weekday == 6 ||
        //     date.weekday == 7) {
        //   return false;
        // }

        return true;
      },
      // onChanged: (val) => print(val),
      validator: (val) {
        // print(val);
        return null;
      },
      onSaved: (val) {
        fechaCreacionCtrl.text = val!;
        // print(val);
      },
    );
  }

  DateTimePicker selectEndDateTime() {
    return DateTimePicker(
      type: DateTimePickerType.dateTimeSeparate,
      dateMask: 'd MMM, yyyy',
      initialValue: DateTime.now().toString(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      icon: Icon(Icons.event),
      dateLabelText: 'Fecha',
      timeLabelText: 'Hora',
      selectableDayPredicate: (date) {
        // Deshabilita fines de semana
        // if (date.weekday == 6 ||
        //     date.weekday == 7) {
        //   return false;
        // }

        return true;
      },
      // onChanged: (val) => print(val),
      validator: (val) {
        // print(val);
        return null;
      },
      onSaved: (val) {
        fechaCierreCtrl.text = val!;
        // print(val);
      },
    );
  }

  Widget listMachines() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: AppExpansionTile(
        key: catMachineKey,
        initiallyExpanded: false,
        title: Text(
          catMachines.nombreMaquina ?? 'Maquina',
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
                    itemCount:
                        RxVariables.gvListCatalogsFields.machinesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            catMachines = RxVariables
                                .gvListCatalogsFields.machinesList[index];
                            catMachineKey.currentState!.collapse();
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
                                    RxVariables.gvListCatalogsFields
                                        .machinesList[index].nombreMaquina!,
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

  Widget listDesigns() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: AppExpansionTile(
        key: catDesignKey,
        initiallyExpanded: false,
        title: Text(
          catDesigns.nombreDiseno ?? 'Diseño',
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
                    itemCount:
                        RxVariables.gvListCatalogsFields.designsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            catDesigns = RxVariables
                                .gvListCatalogsFields.designsList[index];
                            catDesignKey.currentState!.collapse();
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
                                    RxVariables.gvListCatalogsFields
                                        .designsList[index].nombreDiseno!,
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
    headerFilter = '?porPagina=20';

    if (ordenFabicacionCtrl.text.isNotEmpty) {
      headerFilter =
          headerFilter + "&orden_trabajo_of=${ordenFabicacionCtrl.text.trim()}";
    }
    if (fechaCreacionCtrl.text.isNotEmpty) {
      headerFilter =
          headerFilter + "&fecha_inicio=${fechaCreacionCtrl.text.trim()}";
    }
    if (fechaCierreCtrl.text.isNotEmpty) {
      headerFilter = headerFilter + "&fecha_fin=${fechaCierreCtrl.text.trim()}";
    }
    if (tintasCtrl.text.isNotEmpty) {
      headerFilter = headerFilter + "&nombre_tinta=${tintasCtrl.text.trim()}";
    }
    if (catMachines.idCatMaquina != null) {
      headerFilter =
          headerFilter + "&id_cat_maquina=${catMachines.idCatMaquina}";
    }
    if (catDesigns.idCatDiseno != null) {
      headerFilter = headerFilter + "&id_cat_diseno=${catDesigns.idCatDiseno}";
    }
    if (operadorCtrl.text.isNotEmpty) {
      headerFilter = headerFilter +
          "&nombre_operador_responsable=${operadorCtrl.text.trim()}";
    }

    // setState(() {
    //   isLoading = true;
    // });
    // await ordenEntregaProvider
    //     .getOrdenesDeEntregaRecepcionWithFilters(headerFilter)
    //     .then((value) {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
  }

  clearFilters() async {
    setState(() {
      isLoading = false;
    });
    headerFilter = '?porPagina = 100';
    ordenFabicacionCtrl.clear();
    fechaCreacionCtrl.clear();
    fechaCierreCtrl.clear();
    operadorCtrl.clear();
    tintasCtrl.clear();
    catDesigns = DtDesignsOEModel();
    catMachines = CatMachinesOEModel();

    // setState(() {
    //   isLoading = true;
    // });
    // await ordenEntregaProvider
    //     .getOrdenesDeEntregaRecepcionWithFilters(headerFilter)
    //     .then((value) {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
  }
}
