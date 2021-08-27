import 'package:flutter/material.dart';
import 'package:general_products_web/constants/route_names.dart';

import 'package:general_products_web/models/list_paises_model.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/general_dialog.dart';

class TablePaisesList extends StatefulWidget {
  const TablePaisesList({Key? key}) : super(key: key);

  @override
  _TablePaisesListState createState() => _TablePaisesListState();
}

class _TablePaisesListState extends State<TablePaisesList> {
  GeneralDialog dialogs = GeneralDialog();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      child: StreamBuilder(
        stream: rxVariables.listPaisesStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<CountriesList>> snapshot) {
          if (snapshot.hasError) {
            return Text(RxVariables.errorMessage);
          }
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Text(
                'No hay paises por mostrar',
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
                        (states) => GPColors.PrimaryColor),
                    columns: [
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Paises',
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
                        color: MaterialStateColor.resolveWith((states) =>
                            index % 2 == 0
                                ? GPColors.PrimaryColor.withOpacity(0.06)
                                : Colors.white),
                        cells: [
                          DataCell(
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                snapshot.data![index].nombrePais ?? '',
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
                                    icon: Icon(Icons.check_box_rounded,
                                        size: 18, color: GPColors.PrimaryColor),
                                    onPressed: () {
                                      dialogs.showEnalbledCountryDialog(
                                          context, snapshot.data![index]);
                                    },
                                  ),
                                  IconButton(
                                    tooltip: 'Editar',
                                    icon: Icon(Icons.edit,
                                        size: 18, color: GPColors.PrimaryColor),
                                    onPressed: () {
                                      RxVariables.countrySelected =
                                          snapshot.data![index];
                                      Navigator.pushNamed(
                                        context,
                                        RouteNames.paisEdit,
                                      );
                                    },
                                  ),
                                  IconButton(
                                    tooltip: 'Desactivar',
                                    icon: Icon(Icons.not_interested_outlined,
                                        size: 18, color: GPColors.PrimaryColor),
                                    onPressed: () {
                                      dialogs.showDisabledCountryDialog(
                                          context, snapshot.data![index]);
                                    },
                                  ),
                                  IconButton(
                                    tooltip: 'Eliminar',
                                    icon: Icon(Icons.delete,
                                        size: 18, color: GPColors.PrimaryColor),
                                    onPressed: () {
                                      dialogs.showDeleteCountryDialog(
                                          context, snapshot.data![index]);
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
      // child: StreamBuilder(
      //   stream: rxVariables.listWorkZonesSelectedStream,
      //   builder:
      //       (BuildContext context, AsyncSnapshot<List<PaisesList>> snapshot) {
      //     if (snapshot.hasError) {
      //       return Text(RxVariables.errorMessage);
      //     }
      //     if(snapshot.hasData) {
      //       if(snapshot.data!.is)
      //     }
      //   },
      // ),
    );
  }
}
