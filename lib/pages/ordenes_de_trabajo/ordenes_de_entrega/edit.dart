import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:general_products_web/app/auth/login.dart';
import 'package:general_products_web/models/catalogs/design/designsModel.dart';
import 'package:general_products_web/models/catalogs/machine/catMachineModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catMachinesOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catStatusOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/createOrdenesEntregaModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/dtDesignsOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/registrar_recursos/registrarRecursosModel.dart';
import 'package:general_products_web/models/status_model.dart';
import 'package:general_products_web/provider/catalogs/design/designsProvider.dart';
import 'package:general_products_web/provider/catalogs/machine/machinesProvider.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/provider/ordenes_de_trabajo/guardarDatosProvider.dart';
import 'package:general_products_web/provider/ordenes_de_trabajo/ordenEntregaProvider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/app_scaffold.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/widgets/ordenes_de_trabajo/ordenes_de_entrega/table_edit_orden_entrega.dart';
import 'package:general_products_web/widgets/ordenes_de_trabajo/ordenes_de_entrega/table_nueva_orden_entrega.dart';
import 'package:general_products_web/widgets/ordenes_de_trabajo/ordenes_trabajo_dialog.dart';
import 'package:provider/provider.dart';

class OrdenesEntregaEdit extends StatefulWidget {
  @override
  _OrdenesEntregaEditState createState() => _OrdenesEntregaEditState();
}

class _OrdenesEntregaEditState extends State<OrdenesEntregaEdit> {
  late Future futureFields;
  late Future futureRecursos;
  late Future futureTintas;
  bool isLoading = false;
  double pesoTotal = 0.0;

  OrdenesDeTrabajoDialog dialogs = OrdenesDeTrabajoDialog();

  CatStatusOEModel catEstatus = CatStatusOEModel();
  CatMachinesOEModel catMachines = CatMachinesOEModel();
  OrdenEntregaProvider ordenEntregaProvider = OrdenEntregaProvider();
  DtDesignsOEModel catDesigns = DtDesignsOEModel();
  ShiftsList catTurno = ShiftsList();

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
  final GlobalKey<AppExpansionTileState> catTurnoKey = new GlobalKey();

  final currentUser = RxVariables.loginResponse.data!;
  final orderSelected = RxVariables.orderSelected;

  List<List<dynamic>> listFields = [];
  List<Tinta> listaLeida = [];

  @override
  void initState() {
    futureFields = ordenEntregaProvider.getFields();
    futureRecursos = ordenEntregaProvider.getFieldsRegistros();
    ordenFabicacionCtrl.text = orderSelected.ordenTrabajoOf!;
    folioCtrl.text = '${orderSelected.folioEntrega!}';
    operadorCtrl.text =
        '${currentUser.user!.name!} ${currentUser.user!.lastName}';
    clienteCtrl.text = orderSelected.nombreCliente ?? '';
    catEstatus.idCatEstatusOt = 3;
    catDesigns.idCatDiseno = orderSelected.idCatDiseno!;
    // futureFields = RxVariables..gvTintaSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final datosProvider = Provider.of<GuardarDatos>(context);
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
                                          enabled: false,
                                          controller: ordenFabicacionCtrl,
                                          hint: "Orden de Fabricación"),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          enabled: false,
                                          controller: folioCtrl,
                                          hint: "Folio"),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          enabled: false,
                                          controller: operadorCtrl,
                                          hint: "Operador Responsable"),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          enabled: false,
                                          controller: clienteCtrl,
                                          hint: "Cliente"),
                                      // SizedBox(height: 15),
                                      // listStatus(),
                                      SizedBox(height: 15),
                                      listMachines(),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          controller: cantidadProgramadaCtrl,
                                          hint: "Cantidad Programada"),
                                      SizedBox(height: 15),
                                      listTurnos(),
                                      SizedBox(height: 15),
                                      listDesigns(),
                                      SizedBox(height: 15),
                                      CustomInput(
                                          controller: lineaCtrl, hint: "Linea"),
                                      SizedBox(height: 15),
                                      CustomButton(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        title: 'Crear',
                                        isLoading: false,
                                        onPressed: () async {
                                          listaLeida =
                                              datosProvider.listaDeTintas;
                                          if (ordenFabicacionCtrl.text.isEmpty ||
                                              catEstatus.idCatEstatusOt ==
                                                  null ||
                                              catMachines.idCatMaquina ==
                                                  null ||
                                              cantidadProgramadaCtrl
                                                  .text.isEmpty ||
                                              catDesigns.idCatDiseno == null) {
                                            dialogs.showInfoDialog(
                                                context,
                                                "¡Atención!",
                                                "Favor de validar los campos marcados con asterisco (*)");
                                          } else {
                                            await ordenEntregaProvider
                                                .editOrdenEntrega(
                                                    orderSelected
                                                        .idOrdenTrabajo!,
                                                    // int linea y turno
                                                    ordenFabicacionCtrl.text
                                                        .trim(),
                                                    catMachines.idCatMaquina!,
                                                    catDesigns.idCatDiseno!,
                                                    int.parse(
                                                        cantidadProgramadaCtrl
                                                            .text
                                                            .trim()),
                                                    catTurno.idCatTurno ?? null,
                                                    1,
                                                    listaLeida)
                                                .then((value) {
                                              if (value == null) {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                                Navigator.pop(context);
                                                dialogs.showInfoDialog(
                                                    context,
                                                    "¡Error!",
                                                    "Ocurrió un error al crear la orden de entrega : ${RxVariables.errorMessage}");
                                              } else {
                                                final typeAlert =
                                                    (value["result"])
                                                        ? "¡Éxito!"
                                                        : "¡Error!";
                                                final message =
                                                    value["message"];
                                                setState(() {
                                                  isLoading = false;
                                                });
                                                Navigator.pop(context);
                                                dialogs.showInfoDialog(context,
                                                    typeAlert, message);
                                                //Navigator.pushReplacementNamed(context, RouteNames.clienteIndex);
                                              }
                                            });
                                          }
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
                                                  enabled: false,
                                                  controller:
                                                      ordenFabicacionCtrl,
                                                  hint: 'Orden de fabricación',
                                                ),
                                              ),
                                              SizedBox(width: 15),
                                              Flexible(
                                                child: CustomInput(
                                                  enabled: false,
                                                  controller: folioCtrl,
                                                  hint: 'Folio',
                                                ),
                                              ),
                                              SizedBox(width: 15),
                                              Flexible(
                                                child: CustomInput(
                                                  enabled: false,
                                                  controller: operadorCtrl,
                                                  hint: 'Operador Responsable',
                                                ),
                                              ),
                                              SizedBox(width: 15),
                                              Flexible(
                                                child: CustomInput(
                                                  enabled: false,
                                                  controller: clienteCtrl,
                                                  hint: 'Cliente',
                                                ),
                                                // listCliente(),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              // Flexible(child: listStatus()),
                                              // SizedBox(width: 15),
                                              Flexible(child: listMachines()),
                                              SizedBox(width: 15),
                                              Flexible(
                                                child: CustomInput(
                                                  controller:
                                                      cantidadProgramadaCtrl,
                                                  hint: 'Cantidad Programada',
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          Row(
                                            children: [
                                              Flexible(child: listTurnos()),
                                              SizedBox(width: 15),
                                              Flexible(child: listDesigns()),
                                              SizedBox(width: 15),
                                              Flexible(
                                                child: CustomInput(
                                                  controller: lineaCtrl,
                                                  hint: 'Linea',
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          CustomButton(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .2,
                                            title: 'Crear',
                                            isLoading: false,
                                            onPressed: () async {
                                              listaLeida =
                                                  datosProvider.listaDeTintas;
                                              if (ordenFabicacionCtrl.text.isEmpty ||
                                                  catEstatus.idCatEstatusOt ==
                                                      null ||
                                                  catMachines.idCatMaquina ==
                                                      null ||
                                                  cantidadProgramadaCtrl
                                                      .text.isEmpty ||
                                                  catDesigns.idCatDiseno ==
                                                      null) {
                                                dialogs.showInfoDialog(
                                                    context,
                                                    "¡Atención!",
                                                    "Favor de validar los campos marcados con asterisco (*)");
                                              } else {
                                                await ordenEntregaProvider
                                                    .editOrdenEntrega(
                                                        orderSelected
                                                            .idOrdenTrabajo!,
                                                        // int linea y turno
                                                        ordenFabicacionCtrl.text
                                                            .trim(),
                                                        catMachines
                                                            .idCatMaquina!,
                                                        catDesigns.idCatDiseno!,
                                                        int.parse(
                                                            cantidadProgramadaCtrl
                                                                .text
                                                                .trim()),
                                                        catTurno.idCatTurno ??
                                                            null,
                                                        1,
                                                        listaLeida)
                                                    .then((value) {
                                                  if (value == null) {
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                    Navigator.pop(context);
                                                    dialogs.showInfoDialog(
                                                        context,
                                                        "¡Error!",
                                                        "Ocurrió un error al crear la orden de entrega : ${RxVariables.errorMessage}");
                                                  } else {
                                                    final typeAlert =
                                                        (value["result"])
                                                            ? "¡Éxito!"
                                                            : "¡Error!";
                                                    final message =
                                                        value["message"];
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                    Navigator.pop(context);
                                                    dialogs.showInfoDialog(
                                                        context,
                                                        typeAlert,
                                                        message);
                                                    //Navigator.pushReplacementNamed(context, RouteNames.clienteIndex);
                                                  }
                                                });
                                              }
                                            },
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

  Widget listTurnos() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: AppExpansionTile(
        key: catTurnoKey,
        initiallyExpanded: false,
        title: Text(
          catTurno.turno ?? '* Turno',
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
        children: [
          Container(
            //height: MediaQuery.of(context).size.height*.2,
            child: FutureBuilder(
              future: futureRecursos,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    //physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        RxVariables.gvListRecursosFields.shiftsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            catTurno = RxVariables
                                .gvListRecursosFields.shiftsList[index];
                            catTurnoKey.currentState!.collapse();
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
                                    RxVariables.gvListRecursosFields
                                        .shiftsList[index].turno!,
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
          catEstatus.estatusOt = 'Modificado',
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
                        RxVariables.gvListCatalogsFields.statusOwList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            catEstatus = RxVariables
                                .gvListCatalogsFields.statusOwList[index];
                            // RxVariables.dataFromUsers.listStatus![index];
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
                                    RxVariables.gvListCatalogsFields
                                        .statusOwList[index].estatusOt!,
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
          catDesigns.nombreDiseno ?? orderSelected.nombreDiseno!,
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
                            futureTintas = ordenEntregaProvider
                                .getTintas(catDesigns.idCatDiseno!);
                            catDesignKey.currentState!.collapse();

                            // final list =
                            //     RxVariables.gvListCatalogsFields.designsList.;
                            // print(list);

                            // listFields = RxVariables.listInksOEModel.inksList;
                            // print(listFields);
                            futureTintas.asStream().forEach((element) {
                              // listFields.add(element['inksList']);
                              listFields.add(element['inksList']);
                              // print(element['inksList']);
                              // print(listFields);
                            });
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
}
