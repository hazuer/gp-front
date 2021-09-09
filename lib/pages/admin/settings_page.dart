import 'package:flutter/material.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/models/settings/ParametrosModel.dart';
import 'package:general_products_web/provider/catalogs/plant/plantsProvider.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/provider/settings/parametros_provider.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/widgets/settings/parametersDialog.dart';

import '../../widgets/app_scaffold.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final currentUser = RxVariables.loginResponse.data!;

  bool isLoading = false;
  late Future futureFields;
  late Future futureParams;

  Plant catPlanta = Plant();

  PlantsProvider plantsProvider = PlantsProvider();
  ParametrosProvider parametrosProvider = ParametrosProvider();
  SettingsDialog dialogs = SettingsDialog();
  ListUsersProvider usersProvider = ListUsersProvider();

  TextEditingController variacionAceptadaCtrl = TextEditingController();
  TextEditingController variacionMaximaCtrl = TextEditingController();
  final GlobalKey<AppExpansionTileState> catPlanKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> catParamsKey = new GlobalKey();

  late bool campoLote;
  late bool cantidadProgramada;
  late bool utilizarTara;
  late bool campoLinea;
  late bool habilitarTurno;
  late bool utilizaFiltro;
  late bool utilizaPH;
  late bool mideViscocidad;
  late int viscocidad;

  @override
  void initState() {
    futureFields = usersProvider.dataListUser();
    variacionAceptadaCtrl.text =
        '${RxVariables.initialParameters['systemParams']['porcentaje_variacion_aceptado']}';
    variacionMaximaCtrl.text =
        '${RxVariables.initialParameters['systemParams']['variacion_maxima']}';
    campoLote =
        (RxVariables.initialParameters['systemParams']['campo_lote'] == 1)
            ? true
            : false;
    cantidadProgramada = (RxVariables.initialParameters['systemParams']
                ['campo_cantidad_programada'] ==
            1)
        ? true
        : false;
    utilizarTara =
        (RxVariables.initialParameters['systemParams']['utiliza_tara'] == 1)
            ? true
            : false;
    campoLinea =
        (RxVariables.initialParameters['systemParams']['campo_linea'] == 1)
            ? true
            : false;
    habilitarTurno =
        (RxVariables.initialParameters['systemParams']['requiere_turno'] == 1)
            ? true
            : false;
    utilizaPH =
        (RxVariables.initialParameters['systemParams']['utiliza_ph'] == 1)
            ? true
            : false;
    mideViscocidad =
        (RxVariables.initialParameters['systemParams']['mide_viscosidad'] == 1)
            ? true
            : false;

    utilizaFiltro =
        (RxVariables.initialParameters['systemParams']['utiliza_filtro'] == 1)
            ? true
            : false;
    catPlanta.idCatPlanta =
        RxVariables.initialParameters['systemParams']['id_cat_planta'];
    catPlanta.nombrePlanta = currentUser.catPlant!.plantName;
    print(catPlanta.idCatPlanta);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;

    return AppScaffold(
      pageTitle: 'Configuración / Parámetros del Sistema',
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffF5F6F5),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Column(children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xffffffff),
                    padding:
                        EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Habilitar / Deshabilitar Parámetros del Sistema',
                          style: TextStyle(
                              color: Color(0xff313945),
                              fontSize: 14.08,
                              fontWeight: FontWeight.w200),
                        ),
                        Divider(),
                        SizedBox(height: 10.0),
                        displayMobileLayout
                            ? ListView(
                                shrinkWrap: true,
                                children: [
                                  Row(
                                    children: [
                                      Text('Habilitar Campo Lote'),
                                      Switch(
                                        value: campoLote,
                                        onChanged: (value) {
                                          setState(() {
                                            campoLote = value;
                                          });
                                        },
                                      ),
                                      Expanded(child: SizedBox()),
                                      Text('Cantidad Programada'),
                                      Switch(
                                        value: cantidadProgramada,
                                        onChanged: (value) {
                                          setState(() {
                                            cantidadProgramada = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Utiliza Tara'),
                                      Switch(
                                        value: utilizarTara,
                                        onChanged: (value) {
                                          setState(() {
                                            utilizarTara = value;
                                          });
                                        },
                                      ),
                                      Expanded(child: SizedBox()),
                                      Text('Habilitar Campo Linea'),
                                      Switch(
                                        value: campoLinea,
                                        onChanged: (value) {
                                          setState(() {
                                            campoLinea = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Habilitar Turno'),
                                      Switch(
                                        value: habilitarTurno,
                                        onChanged: (value) {
                                          setState(() {
                                            habilitarTurno = value;
                                          });
                                        },
                                      ),
                                      Expanded(child: SizedBox()),
                                      Text('Utiliza Filtro'),
                                      Switch(
                                        value: utilizaFiltro,
                                        onChanged: (value) {
                                          setState(() {
                                            utilizaFiltro = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Habilitar Campo PH'),
                                      Switch(
                                        value: utilizaPH,
                                        onChanged: (value) {
                                          setState(() {
                                            utilizaPH = value;
                                          });
                                        },
                                      ),
                                      Expanded(child: SizedBox()),
                                      Text('Medir Viscocidad'),
                                      Switch(
                                        value: mideViscocidad,
                                        onChanged: (value) {
                                          setState(() {
                                            mideViscocidad = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Variación Aceptada'),
                                      SizedBox(width: 10),
                                      Flexible(
                                        child: CustomInput(
                                            keyboardType: TextInputType.number,
                                            hint: 'Variacón aceptada %',
                                            controller: variacionAceptadaCtrl),
                                      ),
                                      SizedBox(width: 10),
                                      Text('Variación Máxima'),
                                      SizedBox(width: 10),
                                      Flexible(
                                        child: CustomInput(
                                            keyboardType: TextInputType.number,
                                            hint: 'Variacón máxima %',
                                            controller: variacionMaximaCtrl),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  listPlants(),
                                  SizedBox(height: 15),
                                  CustomButton(
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    title: 'Salir',
                                    isLoading: false,
                                    onPressed: () =>
                                        Navigator.pushReplacementNamed(
                                            context, RouteNames.paisesIndex),
                                  ),
                                  SizedBox(height: 15),
                                  CustomButton(
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    title: 'Guardar',
                                    isLoading: false,
                                    onPressed: () async {
                                      await parametrosProvider
                                          .changeParameters(
                                              catPlanta.idCatPlanta!,
                                              campoLote,
                                              cantidadProgramada,
                                              utilizarTara,
                                              campoLinea,
                                              habilitarTurno,
                                              int.parse(variacionAceptadaCtrl
                                                  .text
                                                  .trim()),
                                              int.parse(variacionMaximaCtrl.text
                                                  .trim()),
                                              utilizaPH,
                                              mideViscocidad,
                                              utilizaFiltro)
                                          .then(
                                        (value) {
                                          if (value == null) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            dialogs.showInfoDialog(
                                                context,
                                                "¡Error!",
                                                "Ocurrió un error al modificar los parametros");
                                          } else {
                                            final typeAlert = (value["result"])
                                                ? "¡Éxito!"
                                                : "¡Error!";
                                            final message = value["message"];
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Navigator.pop(context);
                                            dialogs.showInfoDialog(
                                                context, typeAlert, message);
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ],
                              )
                            : Container(
                                height: MediaQuery.of(context).size.height * .7,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(child: SizedBox()),
                                          Text('Habilitar Campo Lote'),
                                          Switch(
                                            value: campoLote,
                                            onChanged: (value) {
                                              setState(() {
                                                campoLote = value;
                                              });
                                            },
                                          ),
                                          SizedBox(width: 15),
                                          Text('Cantidad Programada'),
                                          Switch(
                                            value: cantidadProgramada,
                                            onChanged: (value) {
                                              setState(() {
                                                cantidadProgramada = value;
                                              });
                                            },
                                          ),
                                          SizedBox(width: 15),
                                          Text('Utiliza Tara'),
                                          Switch(
                                            value: utilizarTara,
                                            onChanged: (value) {
                                              setState(() {
                                                utilizarTara = value;
                                              });
                                            },
                                          ),
                                          Expanded(child: SizedBox()),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Expanded(child: SizedBox()),
                                          Text('Habilitar Campo Linea'),
                                          Switch(
                                            value: campoLinea,
                                            onChanged: (value) {
                                              setState(() {
                                                campoLinea = value;
                                              });
                                            },
                                          ),
                                          Text('Habilitar Turno'),
                                          Switch(
                                            value: habilitarTurno,
                                            onChanged: (value) {
                                              setState(() {
                                                habilitarTurno = value;
                                              });
                                            },
                                          ),
                                          SizedBox(width: 15),
                                          Text('Habilitar Campo PH'),
                                          Switch(
                                            value: utilizaPH,
                                            onChanged: (value) {
                                              setState(() {
                                                utilizaPH = value;
                                              });
                                            },
                                          ),
                                          Expanded(child: SizedBox()),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Expanded(child: SizedBox()),
                                          Text('Medir Viscocidad'),
                                          Switch(
                                            value: mideViscocidad,
                                            onChanged: (value) {
                                              setState(() {
                                                mideViscocidad = value;
                                              });
                                            },
                                          ),
                                          SizedBox(width: 15),
                                          Text('Utiliza Filtro'),
                                          Switch(
                                            value: utilizaFiltro,
                                            onChanged: (value) {
                                              setState(() {
                                                utilizaFiltro = value;
                                              });
                                            },
                                          ),
                                          Expanded(child: SizedBox()),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Expanded(child: SizedBox()),
                                          Text('Variación Aceptada'),
                                          SizedBox(width: 10),
                                          Flexible(
                                            child: CustomInput(
                                                keyboardType:
                                                    TextInputType.number,
                                                hint: 'Variación aceptada %',
                                                controller:
                                                    variacionAceptadaCtrl),
                                          ),
                                          SizedBox(width: 10),
                                          Text('Variación Máxima'),
                                          SizedBox(width: 10),
                                          Flexible(
                                            child: CustomInput(
                                                keyboardType:
                                                    TextInputType.number,
                                                hint: 'Variación máxima %',
                                                controller:
                                                    variacionMaximaCtrl),
                                          ),
                                          Expanded(child: SizedBox()),
                                        ],
                                      ),
                                      SizedBox(height: 30),
                                      Row(
                                        children: [
                                          Expanded(child: SizedBox()),
                                          Flexible(child: listPlants()),
                                          Expanded(child: SizedBox()),
                                        ],
                                      ),
                                      SizedBox(height: 30),
                                      Row(
                                        children: [
                                          Expanded(child: SizedBox()),
                                          CustomButton(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .2,
                                            title: 'Salir',
                                            isLoading: false,
                                            onPressed: () =>
                                                Navigator.pushReplacementNamed(
                                                    context,
                                                    RouteNames.paisesIndex),
                                          ),
                                          SizedBox(width: 15),
                                          CustomButton(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .2,
                                            title: 'Guardar',
                                            isLoading: false,
                                            onPressed: () async {
                                              await parametrosProvider
                                                  .changeParameters(
                                                      catPlanta.idCatPlanta!,
                                                      campoLote,
                                                      cantidadProgramada,
                                                      utilizarTara,
                                                      campoLinea,
                                                      habilitarTurno,
                                                      int.parse(
                                                          variacionMaximaCtrl
                                                              .text
                                                              .trim()),
                                                      int.parse(
                                                          variacionAceptadaCtrl
                                                              .text
                                                              .trim()),
                                                      utilizaPH,
                                                      mideViscocidad,
                                                      utilizaFiltro)
                                                  .then(
                                                (value) {
                                                  if (value == null) {
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                    dialogs.showInfoDialog(
                                                        context,
                                                        "¡Error!",
                                                        "Ocurrió un error al modificar los parametros");
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
                                                    // Navigator.pop(context);
                                                    dialogs.showInfoDialog(
                                                        context,
                                                        typeAlert,
                                                        message);
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                          Expanded(child: SizedBox()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  )
                ]),
              )
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
        key: catPlanKey,
        initiallyExpanded: false,
        title: Text(
          // RxVariables.dataFromUsers.listPlants.where((element) => element.idCatPlanta == catPlanta.idCatPlanta),
          catPlanta.nombrePlanta ?? 'Planta',
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
                            catPlanta =
                                RxVariables.dataFromUsers.listPlants![index];
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
}
