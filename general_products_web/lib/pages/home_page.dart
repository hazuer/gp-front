import 'package:flutter/material.dart';
import 'package:general_products_web/models/customer_model.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/models/profile_model.dart';
import 'package:general_products_web/models/status_model.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';

import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';

class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future futureUsers;
  late Future futurefields;
  Plant plant = Plant();
  ProfileModel profile = ProfileModel();
  StatusModel status = StatusModel();
  Customer customer = Customer();
  ListUsersProvider listProvider = ListUsersProvider();
  final GlobalKey<AppExpansionTileState> customerKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> plantsKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> statusKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> profileKey = new GlobalKey();

  @override
  void initState() {
    futureUsers = listProvider.listUsers();
    futurefields = listProvider.dataListUser();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;

    return AppScaffold(
        pageTitle: PageTitles.admin,
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xffF5F6F5),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  //height: MediaQuery.of(context).size.width*.8,
                  margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 26.0),
                  child:  Column( 
                    children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xffffffff),
                      padding: EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'Autorizar Usuario',
                            style: TextStyle(
                                color: Color(0xff313945),
                                fontSize: 14.08,
                                fontWeight: FontWeight.w200),
                          ),
                          Divider(),
                          displayMobileLayout? ListView(
                            shrinkWrap: true,
                            children: [
                              CustomInput(hint: "* Nombre"),
                              SizedBox(height: 25,),
                              CustomInput(hint: "* Apellido Paterno"),
                              SizedBox(height: 25,),
                              CustomInput(hint: "* Apellido Materno"),
                              SizedBox(height: 25,),
                              CustomInput(hint: "* Correo"),
                              SizedBox(height: 25,),
                              listProfile(),
                              SizedBox(height: 25,),
                              listPlants(),
                              SizedBox(height: 25,),
                              listCustomer(),
                              SizedBox(height: 25,),
                              listStatus(),
                              SizedBox(height: 40,),
                              /*CustomButton(
                                width: MediaQuery.of(context).size.width*.2,
                                title: "Autorizar", 
                                isLoading: false,
                                onPressed: (){},
                              ),
                              SizedBox(height: 25,),
                              CustomButton(
                                width: MediaQuery.of(context).size.width*.2,
                                title: "Cancelar", 
                                isLoading: false,
                                onPressed: (){},
                              )*/
                              
                            ],
                          )
                          :Container( //WEB view
                            height: MediaQuery.of(context).size.height*.7,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Flexible(child: CustomInput(hint: "* Nombre")),
                                    SizedBox(width: 25,),
                                    Flexible(child: CustomInput(hint: "* Apellido Paterno")),
                                    SizedBox(width: 25,),
                                    Flexible(child: CustomInput(hint: "* Apellido Materno")),
                                    SizedBox(width: 25,),
                                    Flexible(child: listStatus()),
                                  ],
                                ),
                                SizedBox(height: 25,),
                                Row(
                                  children: [
                                    Flexible(child: listProfile()),
                                    SizedBox(width: 25,),
                                    Flexible(child: listPlants()),
                                    SizedBox(width: 25,),
                                    Flexible(child: listCustomer()),
                                    SizedBox(width: 25,),
                                    IconButton(onPressed: (){print('Aply filter');}, icon: Icon(Icons.filter_alt),),
                                    Flexible(child: Container(),)
                                    
                                  ],
                                ),
                              
                                SizedBox(height: 70,),
                                tableUser()
                                
                                
                                
                              ],
                            ),
                          ),
                          
                        ],
                      ),
                    )
                  ]
                  )
                  
                )
              ],
            ),
          ),
        ));
  }

  Widget tableUser(){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*.47,
      child: FutureBuilder(
        future: futureUsers,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return ListView(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    sortAscending: true,
                    //columnSpacing: 70,
                    horizontalMargin: 0,
                    headingRowColor: MaterialStateColor.resolveWith((states) {
                      return  GPColors.PrimaryColor; //make tha magic!
                    }),
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Nombre',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white, fontSize: 14), textAlign: TextAlign.center,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Ap. Paterno',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white, fontSize: 14),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Ap. Materno',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white, fontSize: 14),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Estatus',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white, fontSize: 14),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Perfil',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white, fontSize: 14),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Planta',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white, fontSize: 14),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Cliente',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white, fontSize: 14),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Opciones',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                    rows: List.generate(
                      RxVariables.listUsers.userList.length, 
                      (index) {
                      return DataRow(
                        color: MaterialStateColor.resolveWith((states) {
                          return index % 2 == 0 ? GPColors.PrimaryColor.withOpacity(0.06) : Colors.white; //make tha magic!
                        }),
                        cells: <DataCell>[
                        DataCell(
                          Center(
                            child: Text(
                              RxVariables.listUsers.userList[index].nombre??"",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Text(
                             RxVariables.listUsers.userList[index].apellidoPaterno??"",
                            ),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Text(
                              RxVariables.listUsers.userList[index].apellidoMaterno??"",
                            ),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Text(
                             "${RxVariables.listUsers.userList[index].estatus??""}",
                            ),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Text(
                              RxVariables.listUsers.userList[index].perfil??"",
                            ),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Text(
                             RxVariables.listUsers.userList[index].nombrePlanta??"",
                            ),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Text(
                              RxVariables.listUsers.userList[index].nombreCliente??"",
                            ),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Row(
                              children: [
                                IconButton(onPressed: (){
                                  setState(() {
                                    
                                  });
                                  print("permission");
                                }, 
                                  icon: Icon(Icons.check_box)
                                ),
                                IconButton(onPressed: (){
                                  print("Edit");
                                }, 
                                  icon: Icon(Icons.edit)
                                ),
                                IconButton(onPressed: (){
                                  print("Block");
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
              ],
            );
          }else{
            return Center(child: Container(width: 50, height: 50, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(GPColors.PrimaryColor),)));
          }
        },
      ),
    );
  }

  Widget listPlants(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[100]
      ),
      child: AppExpansionTile(
        key: plantsKey,
        initiallyExpanded: false,
        title: Text( plant.nombrePlanta?? "* Planta",
        style:  TextStyle(color: Colors.black54, fontSize: 17),),
        children: [
          Container(
            height: MediaQuery.of(context).size.height*.2,
            child: FutureBuilder(
              future: futurefields,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                  //physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: RxVariables.dataFromUsers.listPlants!.length,
                  itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap:(){
                      setState(() {
                        plant = RxVariables.dataFromUsers.listPlants![index];
                        plantsKey.currentState!.collapse();
                      });
                    },
                    child: Container(
                      color: Colors.grey[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Text( RxVariables.dataFromUsers.listPlants![index].nombrePlanta!, style:  TextStyle(color: Colors.black54, fontSize: 17)),
                          ),
                          Container(width: double.infinity, height: .5, color: Colors.grey[300],)
                        ],
                      ),
                    ),
                  );
                 },
                );
                }else{
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget listProfile(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[100]
      ),
      child: AppExpansionTile(
        key: profileKey,
        initiallyExpanded: false,
        title: Text( profile.perfil?? "* Perfil",
        style:  TextStyle(color: Colors.black54, fontSize: 17),),
        children: [
          Container(
            height: MediaQuery.of(context).size.height*.2,
            child: FutureBuilder(
              future: futurefields,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                  //physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: RxVariables.dataFromUsers.listProfiles!.length,
                  itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap:(){
                      setState(() {
                        profile = RxVariables.dataFromUsers.listProfiles![index];
                        profileKey.currentState!.collapse();
                      });
                    },
                    child: Container(
                      color: Colors.grey[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Text( RxVariables.dataFromUsers.listProfiles![index].perfil!, style:  TextStyle(color: Colors.black54, fontSize: 17)),
                          ),
                          Container(width: double.infinity, height: .5, color: Colors.grey[300],)
                        ],
                      ),
                    ),
                  );
                 },
                );
                }else{
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget listStatus(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[100]
      ),
      child: AppExpansionTile(
        key: statusKey,
        initiallyExpanded: false,
        title: Text( status.estatus?? "* Estatus",
        style:  TextStyle(color: Colors.black54, fontSize: 17),),
        children: [
          Container(
            height: MediaQuery.of(context).size.height*.2,
            child: FutureBuilder(
              future: futurefields,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                  //physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: RxVariables.dataFromUsers.listStatus!.length,
                  itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap:(){
                      setState(() {
                        status = RxVariables.dataFromUsers.listStatus![index];
                        statusKey.currentState!.collapse();
                      });
                    },
                    child: Container(
                      color: Colors.grey[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Text( RxVariables.dataFromUsers.listStatus![index].estatus!, style:  TextStyle(color: Colors.black54, fontSize: 17)),
                          ),
                          Container(width: double.infinity, height: .5, color: Colors.grey[300],)
                        ],
                      ),
                    ),
                  );
                 },
                );
                }else{
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget listCustomer(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[100]
      ),
      child: AppExpansionTile(
        key: customerKey,
        initiallyExpanded: false,
        title: Text( customer.nombreCliente?? "* Cliente",
        style:  TextStyle(color: Colors.black54, fontSize: 17),),
        children: [
          Container(
            height: MediaQuery.of(context).size.height*.2,
            child: FutureBuilder(
              future: futurefields,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: RxVariables.dataFromUsers.listCustomers!.length,
                  itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap:(){
                      setState(() {
                        customer = RxVariables.dataFromUsers.listCustomers![index];
                        customerKey.currentState!.collapse();
                      });
                    },
                    child: Container(
                      color: Colors.grey[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(RxVariables.dataFromUsers.listCustomers![index].nombreCliente!, style:  TextStyle(color: Colors.black54, fontSize: 17)),
                          ),
                          Container(width: double.infinity, height: .5, color: Colors.grey[300],)
                        ],
                      ),
                    ),
                  );
                 },
                );
                }else{
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
