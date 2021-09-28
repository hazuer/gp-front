import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catInksOEModel.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/ordenes_de_trabajo/ordenes_trabajo_dialog.dart';

class TableOERecepcionMovil extends StatefulWidget {
  const TableOERecepcionMovil({Key? key}) : super(key: key);

  @override
  _TableOERecepcionMovilState createState() => _TableOERecepcionMovilState();
}

class _TableOERecepcionMovilState extends State<TableOERecepcionMovil> {
  List<TextEditingController> pesoControllers = [];
  List<double> pesos = [];
  List<bool> lecturaAutomatica = [];
  List<bool> puedeGuardar = [];
  List<bool> puedeImprimir = [];

  // Actualizar modelo en el dialogo al de las ordenes de trabajo
  OrdenesDeTrabajoDialog dialogs = OrdenesDeTrabajoDialog();
  final currentUser = RxVariables.loginResponse.data!;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
              return SingleChildScrollView(
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
                    headingRowColor: MaterialStateColor.resolveWith((states) {
                      return GPColors.PrimaryColor;
                    }),
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Tinta',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Código Cliente',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Peso KG',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Báscula',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                    rows: List.generate(snapshot.data!.length, (index) {
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
                                child: Text(
                                  snapshot.data![index].codigoCliente ?? '',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  enabled:
                                      (currentUser.catProfile!.profileId == 4)
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
                                child: Row(
                                  children: [
                                    // Aquí hay opciónes ya que en la logica
                                    // que yo desarrollé, se guardan registro por
                                    // registro, pero solo viene el peso en las HU
                                    // se puede cambiar si se hizo de otra manera
                                    (puedeGuardar[index] == false)
                                        ? IconButton(
                                            tooltip: 'Guardar',
                                            onPressed: null,
                                            icon: Icon(Icons.save,
                                                size: 18,
                                                color: Colors.black26),
                                          )
                                        : (pesoControllers[index].text.isEmpty)
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
                                                  // Procedimiento para guardar la data

                                                  puedeGuardar[index] = false;
                                                  puedeImprimir[index] = true;
                                                  setState(() {});
                                                },
                                                icon: Icon(Icons.save,
                                                    size: 18,
                                                    color:
                                                        GPColors.PrimaryColor),
                                              ),
                                    IconButton(
                                      tooltip: 'Leer',
                                      onPressed: () {
                                        lecturaAutomatica[index] = true;
                                        pesos[index] =
                                            Random.secure().nextDouble() * 10;
                                        pesoControllers[index].text =
                                            pesos[index].toString();

                                        // pesoTotalService.calcularPeso(pesos);
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
                          ]);
                    }),
                  ),
                ),
              );
            }
          } else {
            return Center(
                child: Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(GPColors.PrimaryColor),
                    )));
          }
        },
      ),
    );
  }
}
