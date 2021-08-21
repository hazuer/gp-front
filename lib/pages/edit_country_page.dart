import 'package:flutter/material.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/provider/list_paises_provider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/app_scaffold.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/general_style_widget.dart';

import 'package:flutter/material.dart';
import 'package:general_products_web/widgets/input_custom.dart';

class EditCountryPage extends StatelessWidget {
  ListPaisesProvider listPaisesProvider = ListPaisesProvider();

  final paisController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final paisId = ModalRoute.of(context)!.settings.arguments;

    return AppScaffold(
      pageTitle: "Administrador / Listado de paises",
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffF5F6F5),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 26.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xffffffff),
                      padding: EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Listado de paises',
                            style: TextStyle(
                                color: Color(0xff313945),
                                fontSize: 14.08,
                                fontWeight: FontWeight.w200),
                          ),
                          Divider(),
                          Container(
                            // height: MediaQuery.of(context).size.height * .7,
                            height: MediaQuery.of(context).size.height * .2,
                            child: Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: CustomInput(
                                    controller: paisController,
                                    hint: '* Pais',
                                  ),
                                ),
                                SizedBox(width: 25),
                                CustomButton(
                                  width: MediaQuery.of(context).size.width * .2,
                                  title: 'Guardar',
                                  isLoading: false,
                                  onPressed: () {
                                    print(paisId);
                                    print(paisController.text.trim());
                                    listPaisesProvider.editPais(
                                        int.parse(paisId.toString()),
                                        paisController.text.trim());
                                    Navigator.pushReplacementNamed(
                                        context, RouteNames.paises);
                                  },
                                  // onPressed: authorize
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.filter_alt),
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
            ],
          ),
        ),
      ),
    );
  }
}
// class EditCountryPage extends StatelessWidget {
//   late Future futureCountry;
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return AppScaffold(
//       pageTitle: "Administrador / Listado de paises",
//       body: SingleChildScrollView(
//         child: Container(
//           color: Color(0xffF5F6F5),
//           child: FutureBuilder(
//             future: futureCountry,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       margin: EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 10.0),
//                       child: Column(
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width,
//                             color: Color(0xffffffff),
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 30.0, horizontal: 30.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: <Widget>[
//                                 Text(
//                                   'Editar pais',
//                                   style: TextStyle(
//                                       color: Color(0xff313945),
//                                       fontSize: 13.00,
//                                       fontWeight: FontWeight.w200),
//                                 ),
//                                 Divider(),
//                                 Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   height:
//                                       MediaQuery.of(context).size.height * .7,
//                                   child: SingleChildScrollView(
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Row(
//                                           mainAxisSize: MainAxisSize.max,
//                                           children: [
//                                             GeneralStyleContainer(
//                                               child: Text(
//                                                 RxVariables
//                                                     .countryById.nombrePais!,
//                                                 style: TextStyle(
//                                                     color: Colors.black54,
//                                                     fontSize: 13),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: 25,
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               } else {
//                 return Center(
//                   child: Container(
//                       margin: EdgeInsets.only(top: 50),
//                       width: 45,
//                       height: 45,
//                       child: CircularProgressIndicator()),
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
