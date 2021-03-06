import 'package:flutter/material.dart';
//import 'package:general_products_web/constants/page_titles.dart';
import 'package:general_products_web/models/customer_model.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/models/profile_model.dart';
import 'package:general_products_web/models/status_model.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/app_scaffold.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/general_dialog.dart';
import 'package:general_products_web/widgets/general_style_widget.dart';

class AuthorizeUserPage extends StatefulWidget {
  const AuthorizeUserPage({ Key? key }) : super(key: key);

  @override
  _AuthorizeUserPageState createState() => _AuthorizeUserPageState();
}

class _AuthorizeUserPageState extends State<AuthorizeUserPage> {
  late Future futureUser;
  bool isLoading = false;
  GeneralDialog dialogs = GeneralDialog();
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
    futureUser = listProvider.searchUserId(RxVariables.userSelected.idDatoUsuario.toString());
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
            child: FutureBuilder(
              future: futureUser,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Column(
                  children: <Widget>[
                    //SizedBox(
                      //height: 10,
                    //),
                    Container(
                      width: double.infinity,
                      //height: MediaQuery.of(context).size.width*.8,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                                    fontSize: 13.00,
                                    fontWeight: FontWeight.w200),
                              ),
                              Divider(),
                              displayMobileLayout? ListView(
                                shrinkWrap: true,
                                children: [
                                  
                                  SizedBox(height: 15,),
                                  GeneralStyleContainer(child: Text(RxVariables.userById.user!.nombre!, style: TextStyle(color: Colors.black54, fontSize: 13),),),
                                  SizedBox(height: 15,),
                                  GeneralStyleContainer(child: Text(RxVariables.userById.user!.apellidoPaterno??"", style: TextStyle(color: Colors.black54, fontSize: 13),),),
                                  SizedBox(height: 15,),
                                  GeneralStyleContainer(child: Text(RxVariables.userById.user!.apellidoMaterno??"", style: TextStyle(color: Colors.black54, fontSize: 13),),),
                                  SizedBox(height: 15,),
                                  GeneralStyleContainer(child: Text(RxVariables.userById.user!.correo??"", style: TextStyle(color: Colors.black54, fontSize: 13),),),
                                  SizedBox(height: 15,),
                                  listProfile(),
                                  SizedBox(height: 15,),
                                  listPlants(),
                                  SizedBox(height: 15,),
                                  listCustomer(),
                                  SizedBox(height: 15,),
                                  listStatus(),
                                  SizedBox(height: 40,),
                                  
                                 
                                CustomButton(
                                    width: MediaQuery.of(context).size.width*.2,
                                    title:  "Autorizar", 
                                    isLoading: isLoading,
                                    onPressed: authorize
                                  ),
                                  SizedBox(height: 15,),
                                  CustomButton(
                                    width: MediaQuery.of(context).size.width*.2,
                                    title: "Cancelar", 
                                    isLoading: false,
                                    onPressed: (){Navigator.pop(context);},
                                  )
                                ],
                              )
                              :Container( //WEB view
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height*.7,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          GeneralStyleContainer(child: Text(RxVariables.userById.user!.nombre!, style: TextStyle(color: Colors.black54, fontSize: 13),),),
                                          SizedBox(width: 25,),
                                          GeneralStyleContainer(child: Text(RxVariables.userById.user!.apellidoPaterno??"", style: TextStyle(color: Colors.black54, fontSize: 13),),),
                                          SizedBox(width: 25,),
                                          GeneralStyleContainer(child: Text(RxVariables.userById.user!.apellidoMaterno??"", style: TextStyle(color: Colors.black54, fontSize: 13),),),
                                          SizedBox(width: 25,),
                                          GeneralStyleContainer(child: Text(RxVariables.userById.user!.correo??"", style: TextStyle(color: Colors.black54, fontSize: 13),),),
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Row(
                                        children: [
                                          Flexible(child: listProfile()),
                                          SizedBox(width: 25,),
                                          Flexible(child: listPlants()),
                                          SizedBox(width: 25,),
                                          Flexible(child: listCustomer()),
                                          SizedBox(width: 25,),
                                          Flexible(child: listStatus())
                                          
                                        ],
                                      ),
                                    
                                      SizedBox(height: 70,),
                                      isLoading? Container(
                                        margin: EdgeInsets.only(top:50),
                                        width: 44, height: 44,
                                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(GPColors.PrimaryColor),),
                                      )
                                      : Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CustomButton(
                                            width: MediaQuery.of(context).size.width*.2,
                                            title: "Autorizar",
                                            isLoading: false,
                                            onPressed: authorize
                                          ),
                                          SizedBox(width: 50,),
                                          CustomButton(
                                            width: MediaQuery.of(context).size.width*.2,
                                            title: "Cancelar", 
                                            isLoading: false,
                                            onPressed: (){Navigator.pop(context);},
                                          )
                                        ],
                                      )
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
                );

                }else{
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(top:50),
                      width: 45,
                      height: 45,
                      child: CircularProgressIndicator()
                    ),
                  );
                }
                
              }
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
        title: Text( plant.nombrePlanta ?? RxVariables.userSelected.nombrePlanta!,
        style:  TextStyle(color: Colors.black54, fontSize: 13),),
        children: [
          Container(
            //height: MediaQuery.of(context).size.height*.2,
            child: FutureBuilder(
              future: futureUser,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                  //physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: RxVariables.userById.listPlants!.length,
                  itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap:(){
                      setState(() {
                        plant = RxVariables.userById.listPlants![index];
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
                            child: Text( RxVariables.userById.listPlants![index].nombrePlanta!, style:  TextStyle(color: Colors.black54, fontSize: 13)),
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
        style:  TextStyle(color: Colors.black54, fontSize: 13),),
        children: [
          Container(
            //height: MediaQuery.of(context).size.height*.2,
            child: FutureBuilder(
              future: futureUser,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                  //physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: RxVariables.userById.listProfiles!.length,
                  itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap:(){
                      setState(() {
                        profile = RxVariables.userById.listProfiles![index];
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
                            child: Text( RxVariables.userById.listProfiles![index].perfil!, style:  TextStyle(color: Colors.black54, fontSize: 13)),
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
        title: Text( status.estatus ?? RxVariables.userSelected.estatus!,
        style:  TextStyle(color: Colors.black54, fontSize: 13),),
        children: [
          Container(
            //height: MediaQuery.of(context).size.height*.2,
            child: FutureBuilder(
              future: futureUser,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                  //physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: RxVariables.userById.listStatus!.length,
                  itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap:(){
                      setState(() {
                        status = RxVariables.userById.listStatus![index];
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
                            child: Text( RxVariables.userById.listStatus![index].estatus!, style:  TextStyle(color: Colors.black54, fontSize: 13)),
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
        title: Text( customer.nombreCliente ?? RxVariables.userSelected.nombreCliente!,
        style:  TextStyle(color: Colors.black54, fontSize: 13),),
        children: [
          Container(
            child: FutureBuilder(
              future: futureUser,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: RxVariables.userById.listCustomers!.length,
                  itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap:(){
                      setState(() {
                        customer = RxVariables.userById.listCustomers![index];
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
                            child: Text(RxVariables.userById.listCustomers![index].nombreCliente!, style:  TextStyle(color: Colors.black54, fontSize: 13)),
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

  authorize()async {
    if(profile.idCatPerfil == null){
      dialogs.showInfoDialog(context, "Ha ocurrido un error","No puede autorizar un usuario sin selecionar un perfil");
    }else{
      setState(() {
      isLoading = true;
      });
      await listProvider.authorizeUser(
        RxVariables.userById.user!.idDatoUsuario!, 
        profile.idCatPerfil!, 
        customer.idCatCliente?? RxVariables.userById.user!.idCatCliente!, 
        plant.idCatPlanta?? RxVariables.userById.user!.idCatPlanta!,
        status.idCatEstatus?? RxVariables.userById.user!.idCatEstatus!,).then((value){
          if(value == null){
            setState(() {
              isLoading = false;
            });
            dialogs.showInfoDialog(context, "Ha ocurrido un error","Detalle: ${RxVariables.errorMessage}");
          }else{
            setState(() {
              isLoading = false;
            });
            dialogs.showInfoDialog(context, "??Se ha autorizado a ${RxVariables.userById.user!.nombre??""} ${RxVariables.userById.user!.apellidoPaterno??""}", "");
          }
        });
    }
  }

  /*editUser()async {
    //if (profile.idCatPerfil == null && plant.idCatPlanta == null && customer.idCatCliente == null && status.estatus == null || (RxVariables.userSelected.perfil == null || RxVariables.userSelected.perfil!.isEmpty)){
    //  dialogs.showInfoDialog(context, "Ha ocurrido un error","No detectamos cambios a editar, por favor intentelo de nuevo");
//
    //}else{
      
      await listProvider.editUser(
        RxVariables.userById.user!.idDatoUsuario!, 
        profile.idCatPerfil!, 
        customer.idCatCliente?? RxVariables.userById.user!.idCatCliente!, 
        plant.idCatPlanta?? RxVariables.userById.user!.idCatPlanta!,
        status.idCatEstatus?? RxVariables.userById.user!.idCatEstatus!,).then((value){
          if(value == null){
            setState(() {
              isLoading = false;
            });
            dialogs.showInfoDialog(context, "Ha ocurrido un error","Detalle: ${RxVariables.errorMessage}");
          }else{
            setState(() {
              isLoading = false;
            });
            dialogs.showInfoDialog(context, "??Se ha autorizado a ${RxVariables.userById.user!.nombre??""} ${RxVariables.userById.user!.apellidoPaterno??""}", "");
          }
        });
  }*/
}