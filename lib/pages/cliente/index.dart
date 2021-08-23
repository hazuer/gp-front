import 'package:flutter/material.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/widgets/app_scaffold.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/input_custom.dart';

class ClientesIndex extends StatefulWidget {
  @override
  _ClientesIndexState createState() => _ClientesIndexState();
}

class _ClientesIndexState extends State<ClientesIndex> {
  bool isLoading = false;
  String pathFilter = "?porPagina = 20";
  TextEditingController clienteCtrl = TextEditingController();
  TextEditingController plantaCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;

    return AppScaffold(
      pageTitle: 'Catálogos / Listado de clientes',
      body: Container(
        color: Color(0xffF5F6F5),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              //height: MediaQuery.of(context).size.width*.8,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xffffffff),
                    padding:
                        EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Listado de clientes',
                          style: TextStyle(
                              color: Color(0xff313945),
                              fontSize: 13.00,
                              fontWeight: FontWeight.w200),
                        ),
                        Divider(),
                        SizedBox(height: 10.0),
                        displayMobileLayout
                            ? ListView(
                                shrinkWrap: true,
                                children: [
                                  CustomInput(hint: 'Cliente'),
                                  SizedBox(height: 15),
                                  CustomInput(hint: 'Planta'),
                                  SizedBox(height: 15),
                                  CustomButton(
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    title: "Buscar",
                                    isLoading: false,
                                    onPressed: () async {
                                      // await applyFilter();
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomButton(
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    title: "Limpiar",
                                    isLoading: false,
                                    onPressed: () async {
                                      // await clearFilters()();
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  // isLoading ?
                                  // Container(
                                  //   margin: EdgeInsets.only(top: 50),
                                  //   width: 44,
                                  //   height: 44,
                                  //   child: CircularProgressIndicator(
                                  //     valueColor:AlwaysStoppedAnimation<Color>(GPColors.PrimaryColor),
                                  //   ),
                                  // )
                                  // :
                                  // TableClientesList()
                                ],
                              )
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                              child:
                                                  CustomInput(hint: 'Cliente')),
                                          SizedBox(width: 15.0),
                                          Flexible(
                                              child: CustomInput(
                                            hint: 'Planta',
                                          )),
                                          // Flexible(child: 'listStatus()'),
                                          SizedBox(width: 15.0),
                                          IconButton(
                                            onPressed: () async {
                                              // await applyFilter();
                                            },
                                            icon: Icon(Icons.filter_alt),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              // await clearFilters();
                                            },
                                            icon: Icon(Icons.clear),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0),
                                      isLoading
                                          ? Container(
                                              margin: EdgeInsets.only(top: 50),
                                              width: 44,
                                              height: 44,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        GPColors.PrimaryColor),
                                              ),
                                            )
                                          :
                                          // TableClientesList(),
                                          Container(),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
