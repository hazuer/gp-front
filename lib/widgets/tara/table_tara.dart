//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
//import 'package:general_products_web/widgets/general_dialog.dart';
import 'package:general_products_web/models/tara/list_taras_model.dart';

class TableTaraList extends StatefulWidget {
  const TableTaraList({ Key? key }) : super(key: key);

  @override
  _TableTaraListState createState() => _TableTaraListState();
}

class _TableTaraListState extends State<TableTaraList> {
  //GeneralDialog dialogs = GeneralDialog();
  bool isLoading        = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*.5,
      child: StreamBuilder(
        stream: rxVariables.lsTarasFiltrosStream,
        builder: (BuildContext context, AsyncSnapshot<List<TaraList>> snapshot) {
          if(snapshot.hasError){
            return Text(RxVariables.errorMessage);
          }
          if(snapshot.hasData){
            if(snapshot.data!.isEmpty){
              return Text("No hay usuarios por mostrar", style: TextStyle(color: GPColors.PrimaryColor, fontSize: 18),textAlign: TextAlign.center,);
            }else{
            return SingleChildScrollView(
              padding: EdgeInsets.zero,
              scrollDirection:  MediaQuery.of(context).size.width< 1100? Axis.horizontal : Axis.vertical,
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                child: DataTable(
                  sortAscending: true,
                  columnSpacing: 30,
                  horizontalMargin: 0,
                  headingRowColor: MaterialStateColor.resolveWith((states) {
                    return  GPColors.PrimaryColor; //make tha magic!
                  }),
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Tara',
                          style: TextStyle( color: Colors.white, fontSize: 13), textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Capacidad',
                          style: TextStyle( color: Colors.white, fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Planta',
                          style: TextStyle( color: Colors.white, fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Estatus',
                          style: TextStyle( color: Colors.white, fontSize: 13),
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
                  rows: List.generate(
                    snapshot.data!.length, 
                    (index) {
                    return DataRow(
                      color: MaterialStateColor.resolveWith((states) {
                        return index % 2 == 0 ? GPColors.PrimaryColor.withOpacity(0.06) : Colors.white;
                      }),
                      cells: <DataCell>[
                      DataCell(
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${snapshot.data![index].nombreTara??""}",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            snapshot.data![index].capacidad??"",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                           snapshot.data![index].nombrePlanta??"",
                           style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                           snapshot.data![index].estatus??"",
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
                                tooltip: "Editar",
                                //padding: EdgeInsets.zero,
                                onPressed: (){
                                RxVariables.taraSelected = snapshot.data![index];
                               //RxVariables.isEdition = true;
                               Navigator.pushNamed(context, RouteNames.editUser);
                              }, 
                                icon: Icon(Icons.edit, size: 18, color: GPColors.PrimaryColor)
                              ),
                              IconButton(
                                tooltip: "Eliminar",
                                //padding: EdgeInsets.zero,
                                onPressed: (){
                                //dialogs.showDisabledUserDialog(
                                  //context,
                                  //snapshot.data![index],
                               // );
                              },
                                icon: Icon(Icons.not_interested_outlined, size: 18, color: GPColors.PrimaryColor,)
                              )
                            ]
                          ),
                        ),
                      ),
                    ]);
                  }),
                ),
              ),
            );
            }
          }else{
            return Center(child: Container(width: 50, height: 50, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(GPColors.PrimaryColor),)));
          }
        },
      ),
    );
  }
  
}