import 'package:flutter/material.dart';
import 'package:general_products_web/models/customer_model.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/models/profile_model.dart';
import 'package:general_products_web/models/status_model.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/widgets/table_user.dart';

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
  bool isLoading = false;
  String path = "?porPagina=20";
  Plant plant = Plant();
  ProfileModel profile = ProfileModel();
  StatusModel status = StatusModel();
  Customer customer = Customer();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController secondLastNameController = TextEditingController();
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
        pageTitle: "Administrador / Listado de Usuarios",
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
                              CustomInput(
                                controller: nameController,
                                hint: "* Nombre"
                              ),
                              SizedBox(height: 25,),
                              CustomInput(
                                controller: lastNameController,
                                hint: "* Apellido Paterno"),
                              SizedBox(height: 25,),
                              CustomInput(
                                hint: "* Apellido Materno",
                                controller: secondLastNameController,
                              ),
                              SizedBox(height: 25,),
                              CustomInput(
                                controller: emailController,
                                hint: "* Correo"),
                              SizedBox(height: 25,),
                              listProfile(),
                              SizedBox(height: 25,),
                              listPlants(),
                              SizedBox(height: 25,),
                              listCustomer(),
                              SizedBox(height: 25,),
                              listStatus(),
                              SizedBox(height: 40,),
                              CustomButton(
                                width: MediaQuery.of(context).size.width*.2,
                                title: "Buscar", 
                                isLoading: false,
                                onPressed: ()async{await applyFilter();}, 
                              ),
                              SizedBox(height: 40,),
                              isLoading? Container(
                                margin: EdgeInsets.only(top:50),
                                width: 44, height: 44,
                                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(GPColors.PrimaryColor),),
                              )
                              : TableUserList()
                              
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
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(child: CustomInput(controller: nameController,hint: "* Nombre")),
                                      SizedBox(width: 25,),
                                      Flexible(child: CustomInput(controller: lastNameController, hint: "* Apellido Paterno")),
                                      SizedBox(width: 25,),
                                      Flexible(child: CustomInput(controller: secondLastNameController, hint: "* Apellido Materno")),
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
                                      IconButton(
                                        onPressed: ()async{await applyFilter();}, 
                                        icon: Icon(Icons.filter_alt),
                                      ),
                                      Flexible(child: Container(),)
                                      
                                    ],
                                  ),
                                
                                  SizedBox(height: 70,),
                                  isLoading? Container(
                                    margin: EdgeInsets.only(top:50),
                                    width: 44, height: 44,
                                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(GPColors.PrimaryColor),),
                                  )
                                  : TableUserList()
                                  
                                ],
                              ),
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
            //height: MediaQuery.of(context).size.height*.2,
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
            //height: MediaQuery.of(context).size.height*.2,
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
            //height: MediaQuery.of(context).size.height*.2,
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

  applyFilter()async{
    path = "?porPagina=20";
    if(nameController.text.isNotEmpty){
      path = path+"&nombre=${nameController.text.trim()}";
    }if(lastNameController.text.isNotEmpty){
      path = path+"&apellido_paterno=${lastNameController.text.trim()}";
    }if(secondLastNameController.text.isNotEmpty){
      path = path+"&apellido_materno${secondLastNameController.text.trim()}";
    }if(profile.idCatPerfil != null){
      path = path+"&id_cat_perfil=${profile.idCatPerfil}";
    }if(plant.idCatPlanta != null){
      path = path+"&id_cat_planta=${plant.idCatPlanta}";
    }if(customer.idCatCliente != null){
      path = path+"&id_cat_cliente=${customer.idCatCliente}";
    }

    print(path);
    setState(() {
      isLoading = true;
    });
    await listProvider.listUsersWithFilters(path).then((value){
      setState(() {
        isLoading = false;
      });
    });


    //List<UserList> listFilter =[];
    //rxVariables.listUsersFilter.sink.add([]);
    //RxVariables.listUsers.userList.forEach((item){
    //    if(item.estatus!.toLowerCase() == status.estatus!.toLowerCase() || item.perfil!.toLowerCase() == profile.perfil!.toLowerCase()){
    //      listFilter.add( item );
    //    }
    //});
    //rxVariables.listUsersFilter.sink.add(listFilter);
  }
}
