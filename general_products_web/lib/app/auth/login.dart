import 'package:flutter/material.dart';
import 'package:general_products_web/bloc/login_bloc.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/provider/signup_provider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/general_dialog.dart';
import 'package:general_products_web/widgets/input_custom.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ListUsersProvider provider = ListUsersProvider();
  LoginBloc loginBloc = LoginBloc();
  GeneralDialog dialogs = GeneralDialog();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    //final bool displayMobileLayout = MediaQuery.of(context).size.width < 900;
    //print(MediaQuery.of(context).size.width);

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
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Iniciar Sesión',
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
                          width: width < 880
                              ? MediaQuery.of(context).size.width
                              : MediaQuery.of(context).size.width / 2.65,
                          padding: EdgeInsets.symmetric(
                               horizontal: 35.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 24,
                              ),
                              StreamBuilder(
                                stream: loginBloc.emailStream,
                                builder: (context, snapshot) {
                                  return CustomInput(
                                    controller: userController,
                                    hint: "* Usuario",
                                    errorText: snapshot.error?.toString(),
                                    onChanged: loginBloc.changeEmail,
                                  );
                                }
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              StreamBuilder(
                                stream: loginBloc.passwordStream,
                                builder: (context, snapshot) {
                                  return CustomInput(
                                    controller: passwordController,
                                    hint: "* Contraseña",
                                    errorText: snapshot.error?.toString(),
                                    onChanged: loginBloc.changePassword,
                                  );
                                }
                              ),
                              SizedBox(
                                height: 80,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () async{ 
                                      await provider.searchUserId("20");
                                      await provider.listUsers();
                                      //TODO descomentar Navigator.pushNamed(context, RouteNames.register);
                                    },
                                    child: Text("Registro", style: TextStyle(
                                      color: GPColors.hexToColor("#B3B2B3"),
                                      fontSize:  19
                                    ),),
                                  ),
                                  TextButton(
                                    onPressed: () { 
                                      Navigator.pushNamed(context, RouteNames.recoveryPwd);
                                    },
                                    child: Text("Recuperar Contraseña", style: TextStyle(
                                      color: GPColors.hexToColor("#B3B2B3"),
                                      fontSize:   19
                                    ),),
                                  )

                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),

                              StreamBuilder(
                                stream: loginBloc.formLoginStream,
                                builder: (context, snapshot) {
                                  return CustomButton(
                                    isLoading: isLoading,
                                    title: "Ingresar", 
                                    onPressed:snapshot.hasData? ()async{
                                      
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await SignupProvider().login(userController.text, passwordController.text).then((value) {
                                        if(value == null){
                                          setState(() {
                                            isLoading = false;
                                          });
                                          dialogs.showInfoDialog(context, "Ha ocurrido un error al iniciar sesión.", "Error: ${RxVariables.errorMessage}");
                                          
                                        }else{
                                          setState(() {
                                           isLoading = false;
                                          });
                                          Navigator.pushReplacementNamed(context, '/');
                                        }
                                      });
                                      
                                    }
                                    :
                                    (){
                                       dialogs.showInfoDialog(context, "Favor de llenar correctamente los campos", "");

                                    },
                                   /* onPressed: ()async{
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await SignupProvider().login(userController.text, passwordController.text).then((value) {
                                        if(value == null){
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(RxVariables.errorMessage), backgroundColor: Colors.red,));
                                          setState(() {
                                           isLoading = false;
                                          });
                                        }else{
                                          setState(() {
                                           isLoading = false;
                                          });
                                          Navigator.pushReplacementNamed(context, '/');
                                        }
                                      });
                                    }*/
                                  );
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
