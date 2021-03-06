import 'package:flutter/material.dart';

import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';

class OrdersWorkPage extends StatelessWidget {
  const OrdersWorkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        pageTitle: PageTitles.formWorks,
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xffF5F6F5),
            child: Column(
              children: <Widget>[
                //SizedBox(
                  //height: 10,
                //),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: Column(children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xffffffff),
                      padding: EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'Listado de Ordenes de trabajo',
                            style: TextStyle(
                                color: Color(0xff313945),
                                fontSize: 14.08,
                                fontWeight: FontWeight.w200),
                          ),
                          Divider(),
                          Text(
                            '',
                            style: TextStyle(
                                color: Color(0xff313945),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w100),
                          ),
                          SizedBox(
                            height: 28.0,
                          ),
                        ],
                      ),
                    )
                  ]),
                )
              ],
            ),
          ),
        ));
  }
}
