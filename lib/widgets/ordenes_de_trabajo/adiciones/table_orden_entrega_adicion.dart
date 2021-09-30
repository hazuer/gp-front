import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catInksOEModel.dart';
import 'package:general_products_web/provider/ordenes_de_trabajo/calcularPesoProvider.dart';
import 'package:general_products_web/provider/ordenes_de_trabajo/ordenEntregaProvider.dart';
import 'package:general_products_web/provider/settings/parametros_provider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
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
  late Future params;
  late Future futureRecursos;

  @override
  void initState() {
    params =
        parametrosProvider.getAllParameters(currentUser.catPlant!.plantId!);
    // Aplicar los campos que traen los parametros
    futureRecursos = ordenEntregaProvider.getFieldsRegistros();
    // futureRecursos  = // // Este es para idRazon, idTara (que no trae nada)
    //y turno. El turno va en Create
    super.initState();
  }

  OrdenesDeTrabajoDialog dialogs = OrdenesDeTrabajoDialog();
  bool isLoading = false;
  late double pesoTotal = 0.0;
  List<double> pesos = [];
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
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Tara',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
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
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Razón',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
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
                                    child: Text(
                                      snapshot.data![index].nombreTinta ?? '',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: TextField(
                                      controller: loteControllers[index],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 13),
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
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text('Tara'),
                                  ),
                                ),
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
                                      controller: pesoControllers[index],
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
                                      snapshot.data![index].aditivo.toString(),
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: TextField(
                                      controller: razonControllers[index],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 13),
                                    ),
                                  ),
                                ),
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