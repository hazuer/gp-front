import 'package:flutter/material.dart';
import 'package:general_products_web/constants/page_titles.dart';
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

class EditUserPage extends StatefulWidget {
  const EditUserPage({ Key? key }) : super(key: key);

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late Future futureUser;
  bool isLoading = false;
  GeneralDialog dialogs = GeneralDialog();
  Plant plant = Plant();
  ProfileModel profile = ProfileModel();
  StatusModel status = StatusModel();
  Customer customer = Customer();
  bool isEditing = false;
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
        pageTitle: PageTitles.admin,
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xffF5F6F5),
            child: FutureBuilder(
              future: futureUser,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Column(
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
                                'Editar Usuario',
                                style: TextStyle(
                                    color: Color(0xff313945),
                                    fontSize: 14.08,
                                    fontWeight: FontWeight.w200),
                              ),
                              Divider(),
                              displayMobileLayout? ListView(
                                shrinkWrap: true,
                                children: [
                                  
                                  SizedBox(height: 25,),
                                  GeneralStyleContainer(child: Text(RxVariables.userById.user!.nombre!, style: TextStyle(color: Colors.black54, fontSize: 14),),),
                                  SizedBox(height: 25,),
                                  GeneralStyleContainer(child: Text(RxVariables.userById.user!.apellidoPaterno??"", style: TextStyle(color: Colors.black54, fontSize: 14),),),
                                  SizedBox(height: 25,),
                                  GeneralStyleContainer(child: Text(RxVariables.userById.user!.apellidoMaterno??"", style: TextStyle(color: Colors.black54, fontSize: 14),),),
                                  SizedBox(height: 25,),
                                  GeneralStyleContainer(child: Text(RxVariables.userById.user!.correo??"", style: TextStyle(color: Colors.black54, fontSize: 14),),),
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
                                    title:  "Guardar", 
                                    isLoading: isLoading,
                                    onPressed: authorize
                                  ),
                                  SizedBox(height: 25,),
                                  CustomButton(
                                    width: MediaQuery.of(context).size.width*.2,
                                    title: "Cancelar", 
                                    isLoading: false,
                                    onPressed: (){},
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
                                          GeneralStyleContainer(child: Text(RxVariables.userById.user!.nombre!, style: TextStyle(color: Colors.black54, fontSize: 14),),),
                                          SizedBox(width: 25,),
                                          GeneralStyleContainer(child: Text(RxVariables.userById.user!.apellidoPaterno??"", style: TextStyle(color: Colors.black54, fontSize: 14),),),
                                          SizedBox(width: 25,),
                                          GeneralStyleContainer(child: Text(RxVariables.userById.user!.apellidoMaterno??"", style: TextStyle(color: Colors.black54, fontSize: 14),),),
                                          SizedBox(width: 25,),
                                          GeneralStyleContainer(child: Text(RxVariables.userById.user!.correo??"", style: TextStyle(color: Colors.black54, fontSize: 14),),),
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
                                            title: "Guardar",
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
        style:  TextStyle(color: Colors.black54, fontSize: 14),),
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
                        isEditing = true;
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
                            child: Text( RxVariables.userById.listPlants![index].nombrePlanta!, style:  TextStyle(color: Colors.black54, fontSize: 14)),
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
        title: Text( RxVariables.userSelected.perfil!.isEmpty?  "* Perfil" :  RxVariables.userSelected.perfil!,
        style:  TextStyle(color: Colors.black54, fontSize: 14),),
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
                        isEditing = true;
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
                            child: Text( RxVariables.userById.listProfiles![index].perfil!, style:  TextStyle(color: Colors.black54, fontSize: 14)),
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
        style:  TextStyle(color: Colors.black54, fontSize: 14),),
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
                        isEditing = true;
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
                            child: Text( RxVariables.userById.listStatus![index].estatus!, style:  TextStyle(color: Colors.black54, fontSize: 14)),
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
        style:  TextStyle(color: Colors.black54, fontSize: 14),),
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
                        isEditing = true;
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
                            child: Text(RxVariables.userById.listCustomers![index].nombreCliente!, style:  TextStyle(color: Colors.black54, fontSize: 14)),
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
    if(!isEditing){
      dialogs.showInfoDialog(context, "Ha ocurrido un error","No detectamos cambios en el perfil.");
    }else{
      setState(() {
      isLoading = true;
      });
      await listProvider.editUser(
        RxVariables.userById.user!.idDatoUsuario!, 
        profile.idCatPerfil?? RxVariables.userById.user!.idCatPerfil!, 
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
            dialogs.showInfoDialog(context, "¡Se ha actualizado el perfil de ${RxVariables.userById.user!.nombre??""} ${RxVariables.userById.user!.apellidoPaterno??""}", "");
          }
        });
    }
  }
}