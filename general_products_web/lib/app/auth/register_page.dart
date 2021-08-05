import 'package:flutter/material.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/input_custom.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
  @override
  Widget build(BuildContext context) {
    //inal bool displayMobileLayout = MediaQuery.of(context).size.width < 600;

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
                        
                        Container(
                          width: width < 850
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
                                  Flexible(child: CustomInput(hint: "* Nombre",)),
                                  SizedBox(width: 35,),
                                  Flexible(child: CustomInput(hint: "* Apellido Paterno",)),
                                ],
                              ),
                              SizedBox( height: 35,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(child: CustomInput(hint: "* Apellido Materno",)),
                                  SizedBox(width: 35,),
                                  Flexible(child: CustomInput(hint: "* Correo",)),
                                ],
                              ),
                              SizedBox( height: 35,),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(child: CustomInput(hint: "* Selecciona planta",)),
                                  SizedBox(width: 35,),
                                  Flexible(child: CustomInput(hint: "* Selecciona Cliente",)),
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
                                      title: "Enviar Registro", 
                                      onPressed: (){
                                        print("onpressed");
                                        //Navigator.pushReplacementNamed(context, '/');
                                      }
                                    ),
                                  ),
                                  SizedBox(width: 40,),
                                  Flexible(
                                    child: CustomButton(
                                      title: "Salir", 
                                      onPressed: (){
                                        print("onpressed");
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
}
