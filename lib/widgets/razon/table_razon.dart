import 'package:flutter/material.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/models/razon/razonesModel.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/razon/razonDialog.dart';

class TableRazonList extends StatefulWidget {
  const TableRazonList({Key? key}) : super(key: key);

  @override
  _TableRazonListState createState() => _TableRazonListState();
}

class _TableRazonListState extends State<TableRazonList> {
  RazonDialog dialogs = RazonDialog();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      child: StreamBuilder(
          stream: rxVariables.listRazonesStream2,
          builder: (BuildContext context,
              AsyncSnapshot<List<ReasonsList>> snapshot) {
            if (snapshot.hasError) {
              return Text(RxVariables.errorMessage);
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Text(
                  "No hay razones por mostrar",
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
                      columns: [
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Razón',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Planta',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Estatus',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Opciones',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
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
                          cells: [
                            DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  snapshot.data![index].razon ?? '',
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
                                          dialogs.dialogChangeStatusRazon(
                                              context,
                                              snapshot.data![index],
                                              'activar',
                                              1);
                                        },
                                        icon: Icon(Icons.check_box_rounded,
                                            size: 18,
                                            color: GPColors.PrimaryColor),
                                      ),
                                      IconButton(
                                        tooltip: 'Editar',
                                        onPressed: () {
                                          RxVariables.razonSelected =
                                              snapshot.data![index];
                                          Navigator.pushNamed(
                                              context, RouteNames.razonUpdate);
                                        },
                                        icon: Icon(Icons.edit,
                                            size: 18,
                                            color: GPColors.PrimaryColor),
                                      ),
                                      IconButton(
                                        tooltip: "Desactivar",
                                        onPressed: () {
                                          dialogs.dialogChangeStatusRazon(
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
                                          dialogs.dialogChangeStatusRazon(
                                              context,
                                              snapshot.data![index],
                                              'eliminar',
                                              3);
                                        },
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        );
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
                        valueColor: AlwaysStoppedAnimation<Color>(
                            GPColors.PrimaryColor),
                      )));
            }
          }),
    );
  }
}
