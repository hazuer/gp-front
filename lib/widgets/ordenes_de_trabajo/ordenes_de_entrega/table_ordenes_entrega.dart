import 'package:flutter/material.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/listOrdenesEntregaModel.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/ordenes_de_trabajo/ordenes_trabajo_dialog.dart';

class TableOrdenesEntrega extends StatefulWidget {
  const TableOrdenesEntrega({Key? key}) : super(key: key);

  @override
  _TableOrdenesEntregaState createState() => _TableOrdenesEntregaState();
}

class _TableOrdenesEntregaState extends State<TableOrdenesEntrega> {
  // Actualizar modelo en el dialogo al de las ordenes de trabajo
  OrdenesDeTrabajoDialog dialogs = OrdenesDeTrabajoDialog();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .5,
      child: StreamBuilder(
        stream: rxVariables.listOrdersStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<DeliveryOrdersList>> snapshot) {
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
                            'Orden de\nFabricaci??n',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Fecha',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Op. Responsable',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Cliente',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Estatus',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'M??quina',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Dise??o',
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
                                  snapshot.data![index].ordenTrabajoOf ?? '',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  snapshot.data![index].fechaCreacion!
                                      .toIso8601String(),
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  snapshot.data![index]
                                          .nombreOperadorResponsable ??
                                      '',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  snapshot.data![index].nombreCliente ?? '',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  snapshot.data![index].estatusOt ?? '',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  snapshot.data![index].nombreMaquina ?? '',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  snapshot.data![index].nombreDiseno ?? '',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        tooltip: 'Activar',
                                        icon: Icon(Icons.check_box_rounded,
                                            size: 18,
                                            color: GPColors.PrimaryColor),
                                        onPressed: () {
                                          // dialogs
                                          //     .dialogChangeStatusOrdenTrabajo(
                                          //         context,
                                          //         snapshot.data![index],
                                          //         "activar",
                                          //         1);
                                        },
                                      ),
                                      IconButton(
                                          tooltip: "Editar",
                                          //padding: EdgeInsets.zero,
                                          onPressed: () {
                                            // RxVariables.gvTaraSelectedById =
                                            //     snapshot.data![index];
                                            // Navigator.pushNamed(
                                            //     context, RouteNames.taraEdit);
                                          },
                                          icon: Icon(Icons.edit,
                                              size: 18,
                                              color: GPColors.PrimaryColor)),
                                      IconButton(
                                          tooltip: "Desactivar",
                                          //padding: EdgeInsets.zero,
                                          onPressed: () {
                                            // dialogs
                                            //     .dialogChangeStatusOrdenTrabajo(
                                            //         context,
                                            //         snapshot.data![index],
                                            //         "desactivar",
                                            //         2);
                                          },
                                          icon: Icon(
                                            Icons.not_interested_outlined,
                                            size: 18,
                                            color: GPColors.PrimaryColor,
                                          )),
                                      IconButton(
                                        tooltip: 'Eliminar',
                                        icon: Icon(Icons.delete,
                                            size: 18,
                                            color: GPColors.PrimaryColor),
                                        onPressed: () {
                                          // dialogs
                                          //     .dialogChangeStatusOrdenTrabajo(
                                          //         context,
                                          //         snapshot.data![index],
                                          //         "eliminar",
                                          //         3);
                                        },
                                      ),
                                    ]),
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
