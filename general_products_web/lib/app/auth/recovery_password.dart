import 'package:flutter/material.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/input_custom.dart';

class RecoveryPasswordPage extends StatefulWidget {
  RecoveryPasswordPage({Key? key}) : super(key: key);

  @override
  _RecoveryPasswordPageState createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
  @override
  Widget build(BuildContext context) {
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
                                      bottom: 0,
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
                              : MediaQuery.of(context).size.width / 2.65,
                          padding: EdgeInsets.symmetric(
                               horizontal: 35.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 24,
                              ),
                              CustomInput(hint: "* Correo",),

                              SizedBox(
                                height: 50,
                              ),

                              CustomButton(
                                title: "Recuperar Contraseña", 
                                onPressed: (){
                                  print("onpressed");
                                 // Navigator.pushReplacementNamed(context, '/');
                                }
                              ),
                              SizedBox(
                                height: 30,
                              ),

                              CustomButton(
                                title: "Salir", 
                                onPressed: (){
                                  print("onpressed");
                                 Navigator.pop(context);
                                }
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
}
