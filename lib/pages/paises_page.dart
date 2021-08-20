import 'package:flutter/material.dart';
import 'package:general_products_web/provider/list_paises_provider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/widgets/app_scaffold.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/widgets/table_paises.dart';

class PaisesPage extends StatefulWidget {
  @override
  _PaisesPageState createState() => _PaisesPageState();
}

class _PaisesPageState extends State<PaisesPage> {
  late Future futurePaises;
  late Future futureFields;
  bool isLoading = false;
  final paisController = TextEditingController();
  ListPaisesProvider listPaisesProvider = ListPaisesProvider();

  @override
  void initState() {
    futurePaises = listPaisesProvider.listPaises();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;

    return AppScaffold(
      pageTitle: 'Paises / Listado de paises',
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffF5F6F5),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Container(
                // color: Color(0xffffffff),
                width: double.infinity,
                // height: 500.0,
                // height: MediaQuery.of(context).size.width * .8,
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
                          // displayMobileLayout
                          Container(
                            // height: MediaQuery.of(context).size.height * .7,
                            height: MediaQuery.of(context).size.height * .2,
                            child: Row(
                              children: [
                                Flexible(
                                  child: CustomInput(
                                    controller: paisController,
                                    hint: '* Pais',
                                  ),
                                ),
                                SizedBox(width: 25),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.filter_alt),
                                ),
                                SizedBox(width: 25),
                                IconButton(
                                  onPressed: () {
                                    // await clearFilters();
                                  },
                                  icon: Icon(Icons.clear),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 70.0),
                          // Table(
                          //   border: TableBorder.all(),
                          //   children: [
                          //     TableRow(
                          //       decoration:
                          //           BoxDecoration(color: Color(0xff2b3f55)),
                          //       children: [
                          //         Container(
                          //           alignment: AlignmentDirectional.center,
                          //           child: Text('Pais',
                          //               style: TextStyle(color: Colors.white)),
                          //         ),
                          //         Container(
                          //           alignment: AlignmentDirectional.center,
                          //           child: Text('Estatus',
                          //               style: TextStyle(color: Colors.white)),
                          //         ),
                          //         Container(
                          //           alignment: AlignmentDirectional.center,
                          //           child: Text('Opciones',
                          //               style: TextStyle(color: Colors.white)),
                          //         ),
                          //       ],
                          //     ),
                          //     _tableRow(Colors.white),
                          //     _tableRow(Colors.black12),
                          //     _tableRow(Colors.white),
                          //   ],
                          // ),
                          isLoading
                              ? Container(
                                  margin: EdgeInsets.only(top: 50),
                                  width: 44,
                                  height: 44,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        GPColors.PrimaryColor),
                                  ),
                                )
                              : TablePaisesList(),
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

  TableRow _tableRow(Color color) {
    return TableRow(
      decoration: BoxDecoration(color: color),
      children: [
        Text(''),
        Text(''),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.check_box),
              Icon(Icons.edit),
              Icon(Icons.block),
            ],
          ),
        ),
      ],
    );
  }
}
