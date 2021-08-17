import 'package:flutter/material.dart';
import 'package:general_products_web/provider/signup_provider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/general_dialog.dart';
import 'package:general_products_web/widgets/input_custom.dart';

class RecoveryPasswordPage extends StatefulWidget {
  RecoveryPasswordPage({Key? key}) : super(key: key);

  @override
  _RecoveryPasswordPageState createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
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
                    height: 60,
                  ),
                  Container(
                    width: double.infinity,
                    margin:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Recuperar Contraseña',
                          style: TextStyle(
                              color: GPColors.PrimaryColor,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.height / 4,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 16.0),
                          child: Column(
                            children: [
                              Flexible(
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      left: 0,
                                      bottom: 15,
                                      child: Container(
                                        child: Image.asset(
                                          'assets/images/logo_login.png',
                                          width: 120,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: width < 850
                              ? MediaQuery.of(context).size.width
                              : MediaQuery.of(context).size.width / 3.3,
                          padding: EdgeInsets.symmetric(
                               horizontal: 35.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              CustomInput(
                                controller: emailController,
                                hint: "* Correo",
                              ),

                              SizedBox(
                                height: 15,
                              ),

                              CustomButton(
                                isLoading: isLoading,
                                title: "Recuperar Contraseña", 
                                onPressed: ()async{
                                  if(emailController.text.contains("@")){
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await SignupProvider().recoverPassword(emailController.text).then((value){
                                      if(value == null){
                                        setState(() {
                                          isLoading = false;
                                        });
                                        GeneralDialog().showInfoDialog(context, "¡Atención!" , "${RxVariables.errorMessage}");
  
                                      }else{
                                        setState(() {
                                          isLoading = false;
                                        });
                                        GeneralDialog().showInfoDialog(context, "¡Éxito!", RxVariables.errorMessage);
                                      }

                                    });

                                  }else{
                                    GeneralDialog().showInfoDialog(context, "¡Atención!", "Ingrese un correo válido");

                                  }
                                  

                                 // Navigator.pushReplacementNamed(context, '/');
                                }
                              ),
                              SizedBox(
                                height: 30,
                              ),

                              //CustomButton(
                                //isLoading: false,
                                //title: "Salir", 
                                //onPressed: (){
                                  //print("onpressed");
//                                  
                                 //Navigator.pop(context);
                                //}
                              //),
                              TextButton(
                                     onPressed: (){
                                      print("onpressed");
                                      Navigator.pop(context);
                                    },
                                    child: Text("Regresar", style: TextStyle(
                                      color: GPColors.hexToColor("#B3B2B3"),
                                      fontSize:   13
                                    ),),
                                  )
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

   showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: color,));

  }

}
