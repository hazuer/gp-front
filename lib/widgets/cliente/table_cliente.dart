import 'package:flutter/material.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/models/cliente/list_clientes_model.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/cliente/clienteDialog.dart';

class TableClienteList extends StatefulWidget {
  const TableClienteList({Key? key}) : super(key: key);

  @override
  _TableClienteListState createState() => _TableClienteListState();
}

class _TableClienteListState extends State<TableClienteList> {
  ClienteDialog dialogs = ClienteDialog();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      child: StreamBuilder(
          stream: rxVariables.listClientesStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<CustomersList>> snapshot) {
            if (snapshot.hasError) {
              return Text(RxVariables.errorMessage);
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Text(
                  "No hay clientes por mostrar",
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
                        headingRowColor: MaterialStateColor.resolveWith(
                          (states) {
                            return GPColors.PrimaryColor;
                          },
                        ),
                        columns: [
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Cliente',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Planta',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Estatus',
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
                                    snapshot.data![index].nombreCliente ?? '',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                              DataCell(
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data![index].nombrePlanta ?? '',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                              DataCell(
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data![index].estatus ?? '',
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
                                        onPressed: () {
                                          dialogs.dialogChangeStatusCliente(
                                              context,
                                              snapshot.data![index],
                                              'activar',
                                              1);
                                          //  Navigator.pushNamed(context, RouteNames.);
                                        },
                                        icon: Icon(Icons.check_box_rounded,
                                            size: 18,
                                            color: GPColors.PrimaryColor),
                                      ),
                                      IconButton(
                                        tooltip: 'Editar',
                                        onPressed: () {
                                          RxVariables.clienteSelected =
                                              snapshot.data![index];
                                          Navigator.pushNamed(context,
                                              RouteNames.clienteUpdate);
                                        },
                                        icon: Icon(Icons.edit,
                                            size: 18,
                                            color: GPColors.PrimaryColor),
                                      ),
                                      IconButton(
                                        tooltip: "Desactivar",
                                        //padding: EdgeInsets.zero,
                                        onPressed: () {
                                          dialogs.dialogChangeStatusCliente(
                                              context,
                                              snapshot.data![index],
                                              'desactivar',
                                              2);
                                        },
                                        icon: Icon(
                                          Icons.not_interested_outlined,
                                          size: 18,
                                          color: GPColors.PrimaryColor,
                                        ),
                                      ),
                                      IconButton(
                                        tooltip: 'Eliminar',
                                        icon: Icon(Icons.delete,
                                            size: 18,
                                            color: GPColors.PrimaryColor),
                                        onPressed: () {
                                          dialogs.dialogChangeStatusCliente(
                                              context,
                                              snapshot.data![index],
                                              'eliminar',
                                              3);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        })),
                  ),
                );
              }
            } else {
              return Center(
                  child: Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            GPColors.PrimaryColor),
                      )));
            }
          }),
    );
  }
}
