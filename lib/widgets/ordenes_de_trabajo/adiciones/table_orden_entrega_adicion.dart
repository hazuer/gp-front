import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catInksOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catMachinesOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/registrar_recursos/registrarRecursosModel.dart';
import 'package:general_products_web/provider/ordenes_de_trabajo/calcularPesoProvider.dart';
import 'package:general_products_web/provider/ordenes_de_trabajo/guardarDatosProvider.dart';
import 'package:general_products_web/provider/ordenes_de_trabajo/ordenEntregaProvider.dart';
import 'package:general_products_web/provider/settings/parametros_provider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/ordenes_de_trabajo/ordenes_trabajo_dialog.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class TableOrdenEntregaAdiciones extends StatefulWidget {
  const TableOrdenEntregaAdiciones({
    Key? key,
  }) : super(key: key);

  @override
  _TableOrdenEntregaAdicionesState createState() =>
      _TableOrdenEntregaAdicionesState();
}

class _TableOrdenEntregaAdicionesState
    extends State<TableOrdenEntregaAdiciones> {
  double pesoCalculado = 0.0;

  final currentUser = RxVariables.loginResponse.data!;

  ParametrosProvider parametrosProvider = ParametrosProvider();
  OrdenEntregaProvider ordenEntregaProvider = OrdenEntregaProvider();

  ReasonsList catReason = ReasonsList();
  List<ReasonsList> listCatReasons = [];

  late Future params;
  late Future futureRecursos;

  CatMachinesOEModel catMachines = CatMachinesOEModel();

  List<ValueKey<AppExpansionTileState>> list = [];
  List<GlobalKey<AppExpansionTileState>> listCatReasonKeys = [];
  List<GlobalKey<AppExpansionTileState>> catMachineKey = [];
  late Future futureFields;

  // final SystemParamsOE systemParamsOE =
  //     RxVariables.gvListRecursosFields.systemParams!;

  @override
  void initState() {
    params =
        parametrosProvider.getAllParameters(currentUser.catPlant!.plantId!);
    futureRecursos = ordenEntregaProvider.getFieldsRegistros();
    futureFields = ordenEntregaProvider.getFields();

    super.initState();
  }

  OrdenesDeTrabajoDialog dialogs = OrdenesDeTrabajoDialog();
  bool isLoading = false;
  late double pesoTotal = 0.0;
  List<double> pesos = [];
  // final GlobalKey<AppExpansionTileState> catReason2Key = new GlobalKey();
  List<TextEditingController> lotesController = [];
  List<TextEditingController> pesosController = [];
  List<TextEditingController> aditivosController = [];
  List<bool> lecturaAutomatica = [];

  List<bool> puedeGuardar = [];
  List<bool> puedeImprimir = [];

  final regexp = RegExp(r'^[0-9]+\.?([0-9]+)?$');

  @override
  Widget build(BuildContext context) {
    final pesoTotalService = Provider.of<CalcularPeso>(context);
    final datosProvider = Provider.of<GuardarDatos>(context);

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .5,
      child: StreamBuilder(
        stream: rxVariables.listInksStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<InksList>> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(GPColors.PrimaryColor),
                    )));
          }
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Text(
                "No hay registros por mostrar",
                style: TextStyle(color: GPColors.PrimaryColor, fontSize: 18),
                textAlign: TextAlign.center,
              );
            } else {
              snapshot.data!.forEach((element) {
                pesos.add(0);
                catMachineKey.add(GlobalKey<AppExpansionTileState>());
                listCatReasonKeys.add(GlobalKey<AppExpansionTileState>());
                listCatReasons.add(ReasonsList());
                lotesController.add(TextEditingController());
                pesosController.add(TextEditingController());
                aditivosController.add(TextEditingController());
                (currentUser.catProfile!.profileId != 4)
                    ? lecturaAutomatica.add(true)
                    : lecturaAutomatica.add(false);
                puedeGuardar.add(true);
                puedeImprimir.add(false);
              });

              return ListView(
                children: [
                  // Row(
                  //   children: [
                  //     Expanded(child: SizedBox()),
                  //     CustomButton(
                  //       title: 'Crear',
                  //       width: MediaQuery.of(context).size.width * .4,
                  //       isLoading: false,
                  //       onPressed: () {},
                  //     ),
                  //     Expanded(child: SizedBox()),
                  //   ],
                  // ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    scrollDirection: MediaQuery.of(context).size.width < 1100
                        ? Axis.horizontal
                        : Axis.vertical,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        sortAscending: true,
                        columnSpacing: 30,
                        horizontalMargin: 0,
                        headingRowColor:
                            MaterialStateColor.resolveWith((states) {
                          return GPColors.PrimaryColor;
                        }),
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Aditivo',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Lote',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Código GP',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Código Cliente',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          // Deshabilitado temporalmente, debe listar taras cuando
                          // Esten disponibles.
                          // No hay acceso a los parametros para determinarlo
                          // DataColumn(
                          //   label: Expanded(
                          //     child: Text(
                          //       'Tara',
                          //       style: TextStyle(
                          //           color: Colors.white, fontSize: 13),
                          //       textAlign: TextAlign.center,
                          //     ),
                          //   ),
                          // ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Peso KG',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Aditivo\nRelacionado a',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          // DataColumn(
                          //   label: Expanded(
                          //     child: Text(
                          //       'Razón',
                          //       style: TextStyle(
                          //           color: Colors.white, fontSize: 13),
                          //       textAlign: TextAlign.center,
                          //     ),
                          //   ),
                          // ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Lectura M/A',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Opciones',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                        rows: List.generate(
                          snapshot.data!.length,
                          (index) {
                            return DataRow(
                              color: MaterialStateColor.resolveWith((states) {
                                return index % 2 == 0
                                    ? GPColors.PrimaryColor.withOpacity(0.06)
                                    : Colors.white;
                              }),
                              cells: <DataCell>[
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: TextField(
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                      ),
                                      controller: aditivosController[index],
                                    ),
                                    // child: Text(
                                    //   snapshot.data![index].nombreTinta ?? '',
                                    //   style: TextStyle(fontSize: 13),
                                    // ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: TextField(
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                      ),
                                      controller: lotesController[index],
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      snapshot.data![index].codigoGp ?? '',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      snapshot.data![index].codigoCliente ?? '',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ),
                                // Deshabilitado temporalmente, debe listar taras cuando
                                // Esten disponibles.
                                // No hay acceso a los parametros para determinarlo
                                // DataCell(
                                //   Align(
                                //     alignment: Alignment.center,
                                //     child: Text('Tara'),
                                //   ),
                                // ),
                                // DataCell(
                                //   Align(
                                //     alignment: Alignment.center,
                                //     // child: Text('Tara'),
                                //     child: (RxVariables.initialParameters[
                                //                     'systemParams']
                                //                 ['utiliza_tara'] ==
                                //             1)
                                //         ? Text(
                                //             'Listar tara, \nsi está disponible',
                                //             style: TextStyle(fontSize: 13),
                                //           )
                                //         : Container(),
                                //   ),
                                // ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: TextField(
                                      onChanged: (value) {
                                        lecturaAutomatica[index] = false;
                                        // List<double> peso = [];
                                        pesos[index] = double.parse(
                                            pesosController[index].text);
                                        pesoTotalService.calcularPeso(pesos);
                                        setState(() {});
                                      },
                                      keyboardType: TextInputType.number,
                                      enabled:
                                          (currentUser.catProfile!.profileId ==
                                                  4)
                                              ? true
                                              : false,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                      ),
                                      controller: pesosController[index],
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d*\.?\d{0,2}')),
                                        // FilteringTextInputFormatter.allow(regexp),
                                      ],
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      snapshot.data![index].nombreTinta ?? '',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ),
                                // DataCell(
                                //   Align(
                                //     alignment: Alignment.center,
                                //     child: (listCatReasons[index].idCatRazon !=
                                //             null)
                                //         ? GestureDetector(
                                //             child: Text(
                                //                 '${listCatReasons[index].razon}'),
                                //             onTap: () {
                                //               showDialog(
                                //                   context: context,
                                //                   builder:
                                //                       (BuildContext context) {
                                //                     return AlertDialog(
                                //                       title: Text('Dialog'),
                                //                       content: Container(
                                //                         padding: EdgeInsets
                                //                             .symmetric(
                                //                                 vertical: 10),
                                //                         width: 500,
                                //                         child: razones(
                                //                             listCatReasons[
                                //                                 index]),
                                //                       ),
                                //                     );
                                //                   });
                                //             },
                                //           )
                                //         : IconButton(
                                //             icon: Icon(Icons.add_circle_sharp,
                                //                 color: GPColors.PrimaryColor),
                                //             onPressed: () {
                                //               showDialog(
                                //                   context: context,
                                //                   builder:
                                //                       (BuildContext context) {
                                //                     return AlertDialog(
                                //                       title: Text('Razones'),
                                //                       content: Container(
                                //                         padding: EdgeInsets
                                //                             .symmetric(
                                //                                 vertical: 10),
                                //                         width: 500,
                                //                         child: razones(
                                //                             listCatReasons[
                                //                                 index]),
                                //                       ),
                                //                     );
                                //                   });
                                //             },
                                //           ),
                                //   ),
                                // ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child:
                                        (currentUser.catProfile!.profileId == 4)
                                            ? Text(
                                                lecturaAutomatica[index]
                                                    ? 'Automático'
                                                    : 'Manual',
                                                style: TextStyle(fontSize: 13),
                                              )
                                            : Text(
                                                'Automático',
                                                style: TextStyle(fontSize: 13),
                                              ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        // Aquí se realizan validaciónes para leer los campos de cada tinta
                                        // Como se cargan a la lista de uno por uno, es necesario validar para que
                                        // No se cargue dos veces el mismo registro
                                        (puedeGuardar[index] == false)
                                            ? IconButton(
                                                tooltip: 'Guardar',
                                                onPressed: null,
                                                icon: Icon(Icons.save,
                                                    size: 18,
                                                    color: Colors.black26),
                                              )
                                            : (aditivosController[index]
                                                        .text
                                                        .isEmpty ||
                                                    lotesController[index]
                                                        .text
                                                        .isEmpty ||
                                                    pesosController[index]
                                                        .text
                                                        .isEmpty)
                                                ? IconButton(
                                                    tooltip: 'Guardar',
                                                    onPressed: null,
                                                    icon: Icon(Icons.save,
                                                        size: 18,
                                                        color: Colors.black26),
                                                  )
                                                : IconButton(
                                                    tooltip: 'Guardar',
                                                    onPressed: () {
                                                      // Aquí se realiza la obtención de los campos de esa tinta en particular
                                                      // Se hace la carga de tinta de una por una para ir agregandola a la lista
                                                      // de tintas
                                                      datosProvider
                                                          .obtenerDatosComoCampos(
                                                        1, // Id del aditivo, se cambia en cuanto exista
                                                        // el dato, no existen adiciones actualmente
                                                        // snapshot.data![index]
                                                        //     .idCatTinta!,
                                                        int.parse(
                                                            lotesController[
                                                                    index]
                                                                .text
                                                                .trim()),
                                                        1, //Id cat tara -> pte implementar
                                                        false,
                                                        false,
                                                        false,
                                                        // (systemParamsOE
                                                        //             .utilizaPh ==
                                                        //         0)
                                                        //     ? false
                                                        //     : true, // Utiliza ph
                                                        // (systemParamsOE
                                                        //             .mideViscosidad ==
                                                        //         0)
                                                        //     ? false
                                                        //     : true, // Mide viscocidad
                                                        // (systemParamsOE
                                                        //             .utilizaFiltro ==
                                                        //         0)
                                                        //     ? false
                                                        //     : true, // UtilizaFiltro
                                                        double.parse(
                                                            pesosController[
                                                                    index]
                                                                .text),
                                                        // pesos[index],
                                                        // Id cat lectura
                                                        (lecturaAutomatica[
                                                                    index] ==
                                                                true)
                                                            ? 2
                                                            : 1,
                                                        1, // id_cat_razon
                                                        snapshot.data![index]
                                                                .nombreTinta ??
                                                            '',
                                                        // '1', // Adivito tinta
                                                        snapshot.data![index]
                                                            .idCatTinta!, // Aditivo
                                                        // 2, // Porcentaje de variación
                                                        // 100, // Peso individual GP
                                                      );

                                                      puedeGuardar[index] =
                                                          false;
                                                      puedeImprimir[index] =
                                                          true;
                                                      setState(() {});
                                                    },
                                                    icon: Icon(Icons.save,
                                                        size: 18,
                                                        color: GPColors
                                                            .PrimaryColor),
                                                  ),
                                        (puedeImprimir[index] == false)
                                            ? IconButton(
                                                tooltip: 'Imprimir',
                                                onPressed: null,
                                                icon: Icon(Icons.print,
                                                    size: 18,
                                                    color: Colors.black26),
                                              )
                                            : IconButton(
                                                tooltip: 'Imprimir',
                                                onPressed: () {
                                                  // Aquí irá la funcionalidad para imprimir
                                                  puedeImprimir[index] = false;

                                                  setState(() {});
                                                },
                                                icon: Icon(Icons.print,
                                                    size: 18,
                                                    color:
                                                        GPColors.PrimaryColor),
                                              ),
                                        IconButton(
                                          tooltip: 'Leer',
                                          onPressed: () {
                                            // Esta es una simulación de la obtencion de los pesos en la báscula
                                            lecturaAutomatica[index] = true;
                                            pesos[index] =
                                                Random.secure().nextDouble() *
                                                    10;
                                            pesosController[index].text =
                                                pesos[index].toString();

                                            pesoTotalService
                                                .calcularPeso(pesos);
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.bluetooth,
                                              size: 18,
                                              color: GPColors.PrimaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          } else {
            return Text('Seleccione un diseño para mostrar la tabla');
          }
        },
      ),
    );
  }

  // Widget razones(ReasonsList razon) {
  //   return Container(
  //     //height: MediaQuery.of(context).size.height*.2,
  //     child: FutureBuilder(
  //       future: futureRecursos,
  //       builder: (BuildContext context, AsyncSnapshot snapshot) {
  //         if (snapshot.hasData) {
  //           return ListView.builder(
  //             //physics: NeverScrollableScrollPhysics(),
  //             shrinkWrap: true,
  //             itemCount: RxVariables.gvListRecursosFields.reasonsList.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               return GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     catReason =
  //                         RxVariables.gvListRecursosFields.reasonsList[index];
  //                     razon.idCatRazon = catReason.idCatRazon;
  //                     razon.razon = catReason.razon;
  //                     // catMachineKey[index].currentState!.collapse();
  //                   });
  //                   print('Click');
  //                   Navigator.pop(context);
  //                 },
  //                 child: Container(
  //                   color: Colors.grey[100],
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Padding(
  //                         padding: EdgeInsets.all(12),
  //                         child: Text(
  //                             RxVariables.gvListRecursosFields
  //                                 .reasonsList[index].razon!,
  //                             style: TextStyle(
  //                                 color: Colors.black54, fontSize: 13)),
  //                       ),
  //                       Container(
  //                         width: double.infinity,
  //                         height: .5,
  //                         color: Colors.grey[300],
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           );
  //         } else {
  //           return CircularProgressIndicator();
  //         }
  //       },
  //     ),
  //   );
  // }

  Widget listAritives(ReasonsList razon) {
    return Container(
      //height: MediaQuery.of(context).size.height*.2,
      child: FutureBuilder(
        future: futureRecursos,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              //physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: RxVariables.gvListRecursosFields.reasonsList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      catReason =
                          RxVariables.gvListRecursosFields.reasonsList[index];
                      razon.idCatRazon = catReason.idCatRazon;
                      razon.razon = catReason.razon;
                      // catMachineKey[index].currentState!.collapse();
                    });
                    // print('Click');
                    Navigator.pop(context);
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
                                  .reasonsList[index].razon!,
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
    );
  }

  Widget listMachines(GlobalKey<AppExpansionTileState> key) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: AppExpansionTile(
        key: key,
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
                            key.currentState!.collapse();
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
}
