import 'package:flutter/material.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/models/catalogs/tinta/catTintasModel.dart';
import 'package:general_products_web/provider/catalogs/tinta/tintasProvider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/catalogs/tinta/tinta_dialog.dart';

class TableTinta extends StatefulWidget {
  const TableTinta({Key? key}) : super(key: key);

  @override
  _TableTintaState createState() => _TableTintaState();
}

class _TableTintaState extends State<TableTinta> {
  TintaDialog tintaDialog = TintaDialog();
  TintasProvider tintasProvider = TintasProvider();

  bool isLoading = false;
  late Future futureTintas;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      child: StreamBuilder(
        stream: rxVariables.listTintasStream,
        builder: (BuildContext context, AsyncSnapshot<List<InkList>> snapshot) {
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
                "No hay tintas por mostrar",
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
                            'Tinta',
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
                            'Código SAP',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Planta',
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
                            'Opciones',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                    rows: List.generate(snapshot.data!.length, (index) {
                      return DataRow(
                        color: MaterialStateColor.resolveWith(
                          (states) {
                            return index % 2 == 0
                                ? GPColors.PrimaryColor.withOpacity(0.06)
                                : Colors.white;
                          },
                        ),
                        cells: [
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
                                      tintaDialog.dialogChangeStatusTinta(
                                          context,
                                          snapshot.data![index],
                                          'activar',
                                          1);
                                    },
                                    icon: Icon(Icons.check_box_rounded,
                                        size: 18, color: GPColors.PrimaryColor),
                                  ),
                                  IconButton(
                                    tooltip: 'Editar',
                                    onPressed: () {
                                      RxVariables.tintaSelected =
                                          snapshot.data![index];
                                      Navigator.pushNamed(
                                        context,
                                        RouteNames.tintaUpdate,
                                      );
                                    },
                                    icon: Icon(Icons.edit,
                                        size: 18, color: GPColors.PrimaryColor),
                                  ),
                                  IconButton(
                                    tooltip: "Desactivar",
                                    onPressed: () {
                                      tintaDialog.dialogChangeStatusTinta(
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
                                        size: 18, color: GPColors.PrimaryColor),
                                    onPressed: () {
                                      tintaDialog.dialogChangeStatusTinta(
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
