import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catInksOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catMachinesOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/dtDesignsOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/listOrdenesEntregaModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/registrar_recursos/registrarRecursosModel.dart';
import 'package:general_products_web/provider/ordenes_de_trabajo/calcularPesoProvider.dart';
import 'package:general_products_web/provider/ordenes_de_trabajo/guardarDatosProvider.dart';
import 'package:general_products_web/provider/ordenes_de_trabajo/ordenEntregaProvider.dart';
import 'package:general_products_web/provider/settings/parametros_provider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/ordenes_de_trabajo/ordenes_trabajo_dialog.dart';
import 'package:provider/provider.dart';

class TableEditOrdenEntrega extends StatefulWidget {
  const TableEditOrdenEntrega({Key? key}) : super(key: key);

  @override
  _TableEditOrdenEntregaState createState() => _TableEditOrdenEntregaState();
}

class _TableEditOrdenEntregaState extends State<TableEditOrdenEntrega> {
  // Actualizar modelo en el dialogo al de las ordenes de trabajo
  double pesoCalculado = 0.0;

  final currentUser = RxVariables.loginResponse.data!;

  ParametrosProvider parametrosProvider = ParametrosProvider();
  OrdenEntregaProvider ordenEntregaProvider = OrdenEntregaProvider();

  ReasonsList catReason = ReasonsList();
  List<ReasonsList> listCatReasons = [];

  late Future params;
  late Future futureRecursos;
  late Future futureTintas;

  CatMachinesOEModel catMachines = CatMachinesOEModel();
  DtDesignsOEModel catDesigns = DtDesignsOEModel();

  List<ValueKey<AppExpansionTileState>> list = [];
  List<GlobalKey<AppExpansionTileState>> listCatReasonKeys = [];
  List<GlobalKey<AppExpansionTileState>> catMachineKey = [];
  late Future futureFields;

  final orderSelected = RxVariables.orderSelected;

  // final SystemParamsOE systemParamsOE =
  //     RxVariables.gvListRecursosFields.systemParams!;

  @override
  void initState() {
    params =
        parametrosProvider.getAllParameters(currentUser.catPlant!.plantId!);
    futureRecursos = ordenEntregaProvider.getFieldsRegistros();
    futureFields = ordenEntregaProvider.getFields();
    catDesigns.idCatDiseno = orderSelected.idCatDiseno!;

    futureTintas = ordenEntregaProvider.getTintas(catDesigns.idCatDiseno!);

    super.initState();
  }

  OrdenesDeTrabajoDialog dialogs = OrdenesDeTrabajoDialog();
  bool isLoading = false;
  late double pesoTotal = 0.0;
  List<double> pesos = [];
  // final GlobalKey<AppExpansionTileState> catReason2Key = new GlobalKey();
  List<TextEditingController> loteControllers = [];
  List<TextEditingController> razonControllers = [];
  List<TextEditingController> pesoControllers = [];
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
                loteControllers.add(TextEditingController());
                razonControllers.add(TextEditingController());
                pesoControllers.add(TextEditingController());
                lecturaAutomatica.add(false);
                puedeGuardar.add(true);
                puedeImprimir.add(false);
              });

              return ListView(
                children: [
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
                                'Tinta',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          // DataColumn(
                          //   label: Expanded(
                          //     child: Text(
                          //       'Lote',
                          //       style: TextStyle(
                          //           color: Colors.white, fontSize: 13),
                          //       textAlign: TextAlign.center,
                          //     ),
                          //   ),
                          // ),
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
                          // DataColumn(
                          //   label: Expanded(
                          //     child: Text(
                          //       'Peso KG',
                          //       style: TextStyle(
                          //           color: Colors.white, fontSize: 13),
                          //       textAlign: TextAlign.center,
                          //     ),
                          //   ),
                          // ),
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
                            // loteControllers[index].text = orderSelected.lote;
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
                                    child: Text(
                                      snapshot.data![index].nombreTinta ?? '',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ),
                                // DataCell(
                                //   Align(
                                //     alignment: Alignment.center,
                                //     child: TextField(
                                //       controller: loteControllers[index],
                                //       style: TextStyle(
                                //           color: Colors.black, fontSize: 13),
                                //     ),
                                //   ),
                                // ),
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
                                // DataCell(
                                //   Align(
                                //     alignment: Alignment.center,
                                //     child: TextField(
                                //       keyboardType: TextInputType.number,
                                //       enabled:
                                //           (currentUser.catProfile!.profileId ==
                                //                   4)
                                //               ? true
                                //               : false,
                                //       style: TextStyle(
                                //         color: Colors.black,
                                //         fontSize: 13,
                                //       ),
                                //       controller: pesoControllers[index],
                                //       inputFormatters: [
                                //         FilteringTextInputFormatter.allow(
                                //             RegExp(r'^\d*\.?\d{0,2}')),
                                //         // FilteringTextInputFormatter.allow(regexp),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      snapshot.data![index].aditivo.toString(),
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ),
                                // DataCell(
                                //   Align(
                                //     alignment: Alignment.center,
                                //     // child: (catReason.idCatRazon == null)
                                //     //     ? ElevatedButton(
                                //     //         child: Icon(Icons.add),
                                //     //         onPressed: () {},
                                //     //       )
                                //     //     : ElevatedButton(
                                //     //         child: Icon(Icons.home),
                                //     //         onPressed: () {
                                //     //           showDialog(
                                //     //               context: context,
                                //     //               builder:
                                //     //                   (BuildContext context) {
                                //     //                 return AlertDialog(
                                //     //                   title: Text('Dialog'),
                                //     //                 );
                                //     //               });
                                //     //         },
                                //     //       )
                                //     // listRazones(listCatReasonKeys[index]),
                                //     child: TextField(
                                //       controller: razonControllers[index],
                                //       style: TextStyle(
                                //           color: Colors.black, fontSize: 13),
                                //     ),
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
                                            : (loteControllers[index]
                                                        .text
                                                        .isEmpty ||
                                                    pesoControllers[index]
                                                        .text
                                                        .isEmpty ||
                                                    razonControllers[index]
                                                            .text ==
                                                        '')
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
                                                        snapshot.data![index]
                                                            .idCatTinta!,
                                                        int.parse(
                                                            loteControllers[
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
                                                        pesos[index],
                                                        100, // Id cat lectura
                                                        1, // Id cat razon
                                                        '1', // Adivito tinta
                                                        0, // Aditivo
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
                                            pesoControllers[index].text =
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
}
