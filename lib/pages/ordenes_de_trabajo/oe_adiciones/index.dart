import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/services.dart';
import 'package:general_products_web/app/auth/login.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/models/catalogs/design/designsModel.dart';
import 'package:general_products_web/models/catalogs/machine/catMachineModel.dart';
import 'package:general_products_web/models/status_model.dart';
import 'package:general_products_web/provider/catalogs/design/designsProvider.dart';
import 'package:general_products_web/provider/catalogs/machine/machinesProvider.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/provider/ordenes_de_trabajo/ordenEntregaProvider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/app_scaffold.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/widgets/ordenes_de_trabajo/adiciones/table_orden_entrega_adicion.dart';

class OrdenesEntregaAdicionesIndex extends StatefulWidget {
  @override
  _OrdenesEntregaAdicionesIndexState createState() =>
      _OrdenesEntregaAdicionesIndexState();
}

class _OrdenesEntregaAdicionesIndexState
    extends State<OrdenesEntregaAdicionesIndex> {
  late Future futureOrdenEntrega;
  late Future futureMachines;
  late Future futureDesigns;
  // late Future futureTaras;
  bool isLoading = false;
  String headerFilter = '?porPagina = 20';
  StatusModel catEstatus = StatusModel();

  OrdenEntregaProvider ordenEntregaProvider = OrdenEntregaProvider();
  // TarasProvider tarasProvider = TarasProvider();
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
  TextEditingController estatusCtrl = TextEditingController();
  TextEditingController pesoTotalCtrl = TextEditingController();
  TextEditingController turnoCtrl = TextEditingController();
  TextEditingController lineaCtrl = TextEditingController();
  TextEditingController cantidadProgramadaCtrl = TextEditingController();

  final GlobalKey<AppExpansionTileState> catOrdenEntregaKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> catEstatusKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> catMachineKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> catDesignKey = new GlobalKey();

  final currentUser = RxVariables.loginResponse.data!;

  @override
  void initState() {
    futureOrdenEntrega = ordenEntregaProvider.getOrdenesDeEntrega();
    futureMachines = machinesProvider.getAllMachines();
    futureDesigns = designsProvider.getAllDesigns();
    catEstatus.estatus = 'Nuevo';
    catEstatus.idCatEstatus = 1;
    estatusCtrl.text = 'Nuevo';
    // futureTaras = tarasProvider.getAllTaras();
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
        pageTitle: 'Orden de fabricación / Ordenes de entrega / Adiciones',
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
                              'Listado de Ordenes de Entrega',
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
                                        title: "Crear Orden de entrega",
                                        isLoading: false,
                                        onPressed: () async {
                                          Navigator.pushNamed(
                                              context, RouteNames.oeCreate);
                                        },
                                      ),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          controller: ordenFabicacionCtrl,
                                          hint: "* Orden de Fabricación"),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Text(
                                            '* Fecha de Creación',
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
                                      SizedBox(height: 15),
                                      CustomInput(
                                          controller: operadorCtrl,
                                          hint: "* Operador Responsable"),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          controller: clienteCtrl,
                                          hint: "* Cliente"),
                                      SizedBox(height: 15),
                                      listStatus(),
                                      SizedBox(height: 15),
                                      listMachines(),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          controller: lineaCtrl, hint: 'Linea'),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          controller: turnoCtrl, hint: 'Turno'),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d*\.?\d{0,2}'),
                                            ),
                                          ],
                                          // FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                          enabled: false,
                                          controller: pesoTotalCtrl,
                                          hint: "Peso Total"),
                                      CustomInput(
                                          controller: cantidadProgramadaCtrl,
                                          hint: '* Candidad programada'),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Text(
                                            '* Fecha de Cierre',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13),
                                          ),
                                          SizedBox(width: 10),
                                          Flexible(
                                            child:
                                                selectDateTime(fechaCierreCtrl),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      listDesigns(),
                                      SizedBox(height: 15),
                                      CustomButton(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        title: 'Crear',
                                        isLoading: false,
                                        onPressed: () async {},
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
                                          : TableOrdenEntregaAdiciones(),
                                      // TableTaraList()
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
                                                  title:
                                                      "Crear Orden de Entrega",
                                                  isLoading: false,
                                                  onPressed: () async {
                                                    Navigator.pushNamed(context,
                                                        RouteNames.oeCreate);
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
                                                hint: '* Orden de fabricación',
                                              )),
                                              SizedBox(width: 15),
                                              Flexible(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '* Fecha de Creación',
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
                                              SizedBox(width: 15),
                                              SizedBox(width: 15),
                                              Flexible(
                                                  child: CustomInput(
                                                controller: operadorCtrl,
                                                hint: '* Operador Responsable',
                                              )),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: CustomInput(
                                                  controller: clienteCtrl,
                                                  hint: '* Cliente',
                                                ),
                                              ),
                                              SizedBox(width: 15),
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
                                                  controller: lineaCtrl,
                                                  hint: 'Linea',
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: CustomInput(
                                                  controller: turnoCtrl,
                                                  hint: 'Turno',
                                                ),
                                              ),
                                              SizedBox(width: 15),
                                              Flexible(
                                                child: CustomInput(
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              r'^\d*\.?\d{0,2}')),
                                                    ],
                                                    // FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                                    enabled: false,
                                                    controller: pesoTotalCtrl,
                                                    hint: "Peso Total"),
                                              ),
                                              SizedBox(width: 15),
                                              Flexible(child: listDesigns()),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: CustomInput(
                                                  controller:
                                                      cantidadProgramadaCtrl,
                                                  hint: '* Cantidad programada',
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Flexible(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '* Fecha de Cierre',
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
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          CustomButton(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .2,
                                            title: 'Crear',
                                            isLoading: false,
                                            onPressed: () async {},
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
                                              : TableOrdenEntregaAdiciones(),
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
          catMachines.nombreMaquina ?? '* Maquina',
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
          catDesigns.nombreDiseno ?? '* Diseño',
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
