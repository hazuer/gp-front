import 'package:flutter/material.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/input_custom.dart';

import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 850;

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
                              CustomInput(hint: "* Perfil"),
                              SizedBox(height: 25,),
                              CustomInput(hint: "* Planta"),
                              SizedBox(height: 25,),
                              CustomInput(hint: "* Cliente"),
                              SizedBox(height: 25,),
                              CustomInput(hint: "* Status"),
                              SizedBox(height: 40,),
                              CustomButton(
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
                              )
                              
                            ],
                          )
                          :Container(
                            height: MediaQuery.of(context).size.height*.5,
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
                                    Flexible(child: CustomInput(hint: "* Correo")),
                                  ],
                                ),
                                SizedBox(height: 25,),
                                Row(
                                  children: [
                                    Flexible(child: CustomInput(hint: "* Perfil")),
                                    SizedBox(width: 25,),
                                    Flexible(child: CustomInput(hint: "* Planta")),
                                    SizedBox(width: 25,),
                                    Flexible(child: CustomInput(hint: "* Cliente")),
                                    SizedBox(width: 25,),
                                    Flexible(child: CustomInput(hint: "* Status")),
                                  ],
                                ),
                                SizedBox(height: 50,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomButton(
                                      width: MediaQuery.of(context).size.width*.2,
                                      title: "Autorizar", 
                                      isLoading: false,
                                      onPressed: (){},
                                    ),
                                    CustomButton(
                                      width: MediaQuery.of(context).size.width*.2,
                                      title: "Cancelar", 
                                      isLoading: false,
                                      onPressed: (){},
                                    )
                                  ],
                                )
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
}

/*
Column(
                    children: [
                      Row(
                        children: [
                          CustomInput(hint: "Text"),
                          CustomInput(hint: "Text")
                        ],
                      ),
                      SizedBox(height: 50,),
                      Row(
                        children: [
                          CustomInput(hint: "Text"),
                          CustomInput(hint: "Text")
                        ],
                      ),
                      SizedBox(height: 50,),
                      Row(
                        children: [
                          CustomInput(hint: "Text"),
                          CustomInput(hint: "Text")
                        ],
                      ),
                    ],
                  ),
 */
