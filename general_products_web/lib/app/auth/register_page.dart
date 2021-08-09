import 'package:flutter/material.dart';
import 'package:general_products_web/models/customer_model.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/provider/signup_provider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/general_dialog.dart';
import 'package:general_products_web/widgets/input_custom.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<AppExpansionTileState> customerKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> plantsKey = new GlobalKey();

  TextEditingController nameController = TextEditingController();
  late Future futureData;
  TextEditingController lastnameController = TextEditingController();
  TextEditingController secondLastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  Plant plantSelected = Plant();
  Customer customerSelected = Customer();
  GeneralDialog dialogs = GeneralDialog();

  @override
  void initState() {
    futureData = SignupProvider().dataUser();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: new GestureDetector(
            onTap: () {
              // call this method here to hide soft keyboard
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    margin:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Registrar Usuario", style: TextStyle(color: GPColors.PrimaryColor, fontSize: 22, fontWeight: FontWeight.bold),),
                        
                        displayMobileLayout?
                        Column(
                          children: [
                            SizedBox(height: 50,),
                            CustomInput(
                              controller: nameController,
                              hint: "* Nombre",
                            ),
                            SizedBox(height: 35,),
                            CustomInput(
                              controller: lastnameController,
                              hint: "* Apellido Paterno",
                            ),
                             SizedBox(height: 35,),
                            CustomInput(
                              controller: secondLastnameController,
                              hint: "* Apellido Materno",
                            ),
                            SizedBox(height: 35,),
                            CustomInput(
                              controller: emailController,
                              hint: "* correo",
                            ),
                            listPlants(),
                            listCustomers(),
                            SizedBox(height:35),
                            CustomButton(
                              isLoading: isLoading,
                              title: "Enviar Registro", 
                              onPressed: ()async{
                                if(nameController.text.isEmpty || lastnameController.text.isEmpty || emailController.text.isEmpty || plantSelected.idCatPlanta == null || customerSelected.idCatCliente == null){
                                  dialogs.showInfoDialog(context, "Favor de llenar correctamente todos los campos.", "");

                                }else{
                                  setState(() {
                                  isLoading = true;
                                });
                                await SignupProvider().registerUser(nameController.text, "${lastnameController.text} ${secondLastnameController.text}", emailController.text, plantSelected.idCatPlanta.toString(), customerSelected.idCatCliente.toString()).then((value){
                                  if(value == null){
                                    setState(() {
                                      isLoading = false;
                                    });
                                    dialogs.showInfoDialog(context, "Ocurrió un error al realizar el registro", "Error: ${RxVariables.errorMessage}");

                                  }else{

                                    setState(() {
                                      isLoading = false;
                                    });
                                    dialogs.showInfoDialog(context, "¡Registro Exitoso!", RxVariables.errorMessage);

                                    print("Correcto");
                                  }
                                });
                                  
                                }
                              }
                            ),
                            SizedBox(height: 35,),
                            CustomButton(
                              isLoading: false,
                              title: "Salir", 
                              onPressed: (){
                                Navigator.pop(context);
                                //Navigator.pushReplacementNamed(context, '/');
                              }
                            )

                          ],
                        )
                        : Container(
                          width: !displayMobileLayout
                              ? MediaQuery.of(context).size.width
                              : MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.symmetric(
                               horizontal: 35.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(child: CustomInput(
                                    controller: nameController,
                                    hint: "* Nombre",)
                                  ),
                                  SizedBox(width: 35,),
                                  Flexible(child: CustomInput(
                                    controller: lastnameController,
                                    hint: "* Apellido Paterno",)),
                                ],
                              ),
                              SizedBox( height: 35,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(child: CustomInput(
                                    controller: secondLastnameController,
                                    hint: "* Apellido Materno",)),
                                  SizedBox(width: 35,),
                                  Flexible(child: CustomInput(
                                    controller: emailController,
                                    hint: "* Correo",)),
                                ],
                              ),
                               Row(
                                children: [
                                  Flexible(child: listCustomers()),
                                  SizedBox(width: 35,),
                                  Flexible(child: listPlants())
                                ],
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: CustomButton(
                                      isLoading: isLoading,
                                      title: "Enviar Registro", 
                                      onPressed: ()async{
                                        if(nameController.text.isEmpty || lastnameController.text.isEmpty || emailController.text.isEmpty || plantSelected.idCatPlanta == null || customerSelected.idCatCliente == null){
                                          dialogs.showInfoDialog(context, "Favor de llenar correctamente todos los campos.", "");
                                        }else{
                                          setState(() {
                                          isLoading = true;
                                        });
                                        await SignupProvider().registerUser(nameController.text, "${lastnameController.text} ${secondLastnameController.text}", emailController.text, plantSelected.idCatPlanta.toString(), customerSelected.idCatCliente.toString()).then((value){
                                          if(value == null){
                                            setState(() {
                                              isLoading = false;
                                            });
                                            dialogs.showInfoDialog(context, "Ocurrió un error al realizar el registro", "Error: ${RxVariables.errorMessage}");
                                          }else{
                                            setState(() {
                                              isLoading = false;
                                            });
                                            dialogs.showInfoDialog(context, "¡Registro Exitoso!", RxVariables.errorMessage);
                                          }
                                        });
                                        }
                                      }
                                    ),
                                  ),
                                  SizedBox(width: 40,),
                                  Flexible(
                                    child: CustomButton(
                                      isLoading: false,
                                      title: "Salir", 
                                      onPressed: (){
                                        Navigator.pop(context);
                                        //Navigator.pushReplacementNamed(context, '/');
                                      }
                                    ),
                                  )

                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              

                              
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget listCustomers(){
    return Container(
      margin: EdgeInsets.only(top:35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[100]
      ),
      child: AppExpansionTile(
        key: customerKey,
        initiallyExpanded: false,
        title: Text( customerSelected.nombreCliente?? "*Selecciona Cliente",
        style:  TextStyle(color: Colors.black54, fontSize: 17),),
        children: [
          Container(
            child: FutureBuilder(
              future: futureData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                  shrinkWrap: true,
                  itemCount: RxVariables.customerAvailables.length,
                  itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap:(){
                      setState(() {
                        customerSelected = RxVariables.customerAvailables[index];
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
                            child: Text(RxVariables.customerAvailables[index].nombreCliente!, style: TextStyle(color: Colors.black54, fontSize: 17),),
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

  Widget listPlants(){
    return Container(
      margin: EdgeInsets.only(top:35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[100]
      ),
      child: AppExpansionTile(
        key: plantsKey,
        initiallyExpanded: false,
        title: Text( plantSelected.nombrePlanta?? "* Selecciona Planta",//SkillUser.jobSelected.name??"Seleccionar", 
        style:  TextStyle(color: Colors.black54, fontSize: 17),),
        children: [
          Container(
            child: FutureBuilder(
              future: futureData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: RxVariables.plantsAvailables.length,
                  itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap:(){
                      setState(() {
                        plantSelected = RxVariables.plantsAvailables[index];
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
                            child: Text(RxVariables.plantsAvailables[index].nombrePlanta!, style:  TextStyle(color: Colors.black54, fontSize: 17)),
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
