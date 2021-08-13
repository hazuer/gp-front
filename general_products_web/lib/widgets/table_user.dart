import 'package:flutter/material.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/models/list_users_model.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/general_dialog.dart';

class TableUserList extends StatefulWidget {
  const TableUserList({ Key? key }) : super(key: key);

  @override
  _TableUserListState createState() => _TableUserListState();
}

class _TableUserListState extends State<TableUserList> {
  GeneralDialog dialogs = GeneralDialog();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*.4,
      child: StreamBuilder(
        stream: rxVariables.listWorkZonesSelectedStream,
        builder: (BuildContext context, AsyncSnapshot<List<UserList>> snapshot) {
          if(snapshot.hasData){
            if(snapshot.data!.isEmpty){
              return Text("No hay usuarios por mostrar", style: TextStyle(color: GPColors.PrimaryColor, fontSize: 18),textAlign: TextAlign.center,);
            }else{
            return SingleChildScrollView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
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
                      label: Text(
                        '   Nombre',
                        style: TextStyle( color: Colors.white, fontSize: 14), textAlign: TextAlign.center,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Ap. Paterno',
                        style: TextStyle( color: Colors.white, fontSize: 14),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Ap. Materno',
                        style: TextStyle( color: Colors.white, fontSize: 14),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Estatus',
                        style: TextStyle( color: Colors.white, fontSize: 14),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Perfil',
                        style: TextStyle( color: Colors.white, fontSize: 14),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Planta',
                        style: TextStyle( color: Colors.white, fontSize: 14),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Cliente',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Opciones',
                        style: TextStyle(color: Colors.white, fontSize: 14),
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
                        Center(
                          child: Text(
                            "   ${snapshot.data![index].nombre??""}",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            snapshot.data![index].apellidoPaterno??"",
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            snapshot.data![index].apellidoMaterno??"",
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                         snapshot.data![index].estatus??"",
                        ),
                      ),
                      DataCell(
                        Text(
                          snapshot.data![index].perfil??"",
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                           snapshot.data![index].nombrePlanta??"",
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            snapshot.data![index].nombreCliente??"",
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Row(
                            children: [
                              IconButton(onPressed: (){
                                //RxVariables.isEdition = false;
                                RxVariables.userSelected = snapshot.data![index];
                               Navigator.pushNamed(context, RouteNames.authorizeUser);
                              }, 
                                icon: Icon(Icons.check_box_rounded)
                              ),
                              IconButton(onPressed: (){
                                RxVariables.userSelected = snapshot.data![index];
                               //RxVariables.isEdition = true;
                               Navigator.pushNamed(context, RouteNames.editUser);
                              }, 
                                icon: Icon(Icons.edit)
                              ),
                              IconButton(onPressed: (){
                                dialogs.showDisabledUserDialog(
                                  context, 
                                  snapshot.data![index], 

                                );
                              }, 
                                icon: Icon(Icons.not_interested_outlined)
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