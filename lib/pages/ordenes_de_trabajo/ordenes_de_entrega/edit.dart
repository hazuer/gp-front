import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:general_products_web/app/auth/login.dart';
import 'package:general_products_web/models/catalogs/design/designsModel.dart';
import 'package:general_products_web/models/catalogs/machine/catMachineModel.dart';
import 'package:general_products_web/models/status_model.dart';
import 'package:general_products_web/provider/catalogs/design/designsProvider.dart';
import 'package:general_products_web/provider/catalogs/machine/machinesProvider.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/app_scaffold.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/widgets/ordenes_de_trabajo/ordenes_de_entrega/table_edit_orden_entrega.dart';
import 'package:general_products_web/widgets/ordenes_de_trabajo/ordenes_de_entrega/table_nueva_orden_entrega.dart';

class OrdenesEntregaEdit extends StatefulWidget {
  @override
  _OrdenesEntregaEditState createState() => _OrdenesEntregaEditState();
}

class _OrdenesEntregaEditState extends State<OrdenesEntregaEdit> {
  late Future futureMachines;
  late Future futureDesigns;
  late Future futureFields;
  bool isLoading = false;
  double pesoTotal = 0.0;

  StatusModel catEstatus = StatusModel();

  MachinesProvider machinesProvider = MachinesProvider();
  CatMachineModel catMachines = CatMachineModel();

  DesignsProvider designsProvider = DesignsProvider();
  DesignsList catDesigns = DesignsList();

  TextEditingController ordenFabicacionCtrl = TextEditingController();
  TextEditingController folioCtrl = TextEditingController();
  TextEditingController fechaCreacionCtrl = TextEditingController();
  TextEditingController fechaCierreCtrl = TextEditingController();
  TextEditingController operadorCtrl = TextEditingController();
  TextEditingController clienteCtrl = TextEditingController();
  TextEditingController tintaCtrl = TextEditingController();
  TextEditingController lineaCtrl = TextEditingController();
  TextEditingController turnoCtrl = TextEditingController();
  TextEditingController tintasCtrl = TextEditingController();
  TextEditingController pesoTotalCtrl = TextEditingController();
  TextEditingController cantidadProgramadaCtrl = TextEditingController();

  final GlobalKey<AppExpansionTileState> catEstatusKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> catMachineKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> catDesignKey = new GlobalKey();

  final currentUser = RxVariables.loginResponse.data!;

  @override
  void initState() {
    futureMachines = machinesProvider.getAllMachines();
    futureDesigns = designsProvider.getAllDesigns();
    // futureFields = RxVariables..gvTintaSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;

    if (currentUser.catProfile!.profileId != 2 &&
        currentUser.catProfile!.profileId != 4) {
      ListUsersProvider().logOut();

      return LoginPage();
    } else {
      return AppScaffold(
        pageTitle: 'Orden de fabricación / Ordenes de entrega / Editar',
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
                              'Editar Orden de Entrega',
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
                                      CustomInput(
                                          controller: ordenFabicacionCtrl,
                                          hint: "Orden de Fabricación"),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          controller: folioCtrl, hint: "Folio"),
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
                                              child: selectDateTime(
                                                  fechaCreacionCtrl)),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          controller: operadorCtrl,
                                          hint: "Operador Responsable"),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          controller: clienteCtrl,
                                          hint: "Cliente"),
                                      SizedBox(height: 15),
                                      listStatus(),
                                      SizedBox(height: 15),
                                      listMachines(),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          controller: tintasCtrl,
                                          hint: 'Tintas'),
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
                                          Flexible(
                                              child: selectDateTime(
                                                  fechaCierreCtrl)),
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
                                          // await applyFilter();
                                        },
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      CustomButton(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        title: "Limpiar",
                                        isLoading: false,
                                        onPressed: () async {
                                          // await clearFilters();
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
                                          : TableEditOrdenEntrega(),
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
                                                  child: CustomInput(
                                                controller: ordenFabicacionCtrl,
                                                hint: 'Orden de fabricación',
                                              )),
                                              SizedBox(width: 15),
                                              Flexible(
                                                  child: CustomInput(
                                                controller: folioCtrl,
                                                hint: 'Folio',
                                              )),
                                              SizedBox(width: 15),
                                              Flexible(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Fecha de Creación',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 13),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Flexible(
                                                      child: selectDateTime(
                                                          fechaCreacionCtrl),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Flexible(
                                                  child: CustomInput(
                                                controller: operadorCtrl,
                                                hint: 'Operador Responsable',
                                              )),
                                              SizedBox(width: 15),
                                              Flexible(
                                                child: CustomInput(
                                                  controller: clienteCtrl,
                                                  hint: 'Cliente',
                                                ),
                                                // listCliente(),
                                              ),
                                              SizedBox(width: 15),
                                              Flexible(child: listStatus()),
                                              SizedBox(width: 15),
                                              Flexible(child: listMachines()),
                                              SizedBox(width: 15),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: CustomInput(
                                                  controller: tintasCtrl,
                                                  hint: 'Tintas',
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          Row(
                                            children: [
                                              Flexible(child: listDesigns()),
                                              SizedBox(width: 15),
                                              Flexible(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Fecha de Cierre',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 13),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Flexible(
                                                      child: selectDateTime(
                                                          fechaCierreCtrl),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 15),
                                              IconButton(
                                                tooltip: "Buscar",
                                                onPressed: () async {
                                                  // await applyFilter();
                                                },
                                                icon: Icon(Icons.filter_alt),
                                              ),
                                              IconButton(
                                                tooltip: "Limpiar",
                                                onPressed: () async {
                                                  // await clearFilters();
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
                                              : TableEditOrdenEntrega(),
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

  DateTimePicker selectDateTime(TextEditingController controller) {
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
        controller.text = val!;
        // print(val);
      },
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
              future: futureMachines,
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
              future: futureMachines,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    //physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: RxVariables.gvListMachines.machinesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            catMachines =
                                RxVariables.gvListMachines.machinesList[index];
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
                                    RxVariables.gvListMachines
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
              future: futureDesigns,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    //physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: RxVariables.listDesign.designsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            catDesigns =
                                RxVariables.listDesign.designsList[index];
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
                                    RxVariables.listDesign.designsList[index]
                                        .nombreDiseno!,
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
