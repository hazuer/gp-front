import 'package:flutter/material.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catInksOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/listOrdenesEntregaModel.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/ordenes_de_trabajo/ordenes_trabajo_dialog.dart';

class TableNuevaOrdenEntrega extends StatefulWidget {
  const TableNuevaOrdenEntrega({Key? key}) : super(key: key);

  @override
  _TableNuevaOrdenEntregaState createState() => _TableNuevaOrdenEntregaState();
}

class _TableNuevaOrdenEntregaState extends State<TableNuevaOrdenEntrega> {
  // Actualizar modelo en el dialogo al de las ordenes de trabajo
  OrdenesDeTrabajoDialog dialogs = OrdenesDeTrabajoDialog();
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
                            'Lote',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Código GP',
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
                            'Tara',
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
                            'Aditivo\nRelacionado a',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Razón',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Lectura M/A',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Opciones',
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
                                  'Lote (capturable)',
                                  style: TextStyle(fontSize: 13),
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
                            DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Listar tara, \nsi está disponible',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  // Se puede manejar un text field bloqueado,
                                  // leer el dato de la báscula y agregarlo al
                                  // controller.text, o bien, una variable, mismo
                                  // funcionamiento
                                  'Se lee de la bascula',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Aditivo relacionado a...',
                                  // snapshot.data![index].aditivo ?? '',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Razón (capturable)',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  // Puede ser un textfield en donde se actualice
                                  // el controller.text si se lee, pero permita
                                  //la modificación manual
                                  'Dato automático\no manual',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    IconButton(
                                      tooltip: 'Imprimir',
                                      onPressed: () {},
                                      icon: Icon(Icons.print,
                                          size: 18,
                                          color: GPColors.PrimaryColor),
                                    ),
                                    IconButton(
                                      tooltip: 'Leer',
                                      onPressed: () {},
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
            return Text('Seleccione un diseño para mostrar la tabla');
            // return Center(
            //     child: Container(
            //         width: 50,
            //         height: 50,
            //         child: CircularProgressIndicator(
            //           valueColor:
            //               AlwaysStoppedAnimation<Color>(GPColors.PrimaryColor),
            //         )));
          }
        },
      ),
    );
  }
}
