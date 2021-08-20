import 'package:flutter/material.dart';
import 'package:general_products_web/widgets/app_scaffold.dart';

class ReportsPage extends StatefulWidget {
  ReportsPage({Key? key}) : super(key: key);

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  DateTime selectedDate = DateTime.now();
  var birthdate = TextEditingController();
  bool isSwitched = false;

  /*Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1940, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        birthdate.text = selectedDate.toIso8601String().split('T')[0];
      });
  }*/

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;

    return AppScaffold(
        pageTitle: "Reportes",
        body: new GestureDetector(
            onTap: () {
              // call this method here to hide soft keyboard
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
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
                                'Consulta de Reportes',
                                style: TextStyle(
                                    color: Color(0xff313945),
                                    fontSize: 14.08,
                                    fontWeight: FontWeight.w200),
                              ),
                              Divider(),

                              SizedBox(
                                height: 28.0,
                              ),
                              /*Container(
                                padding: width < 1200
                                    ? EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 20.0)
                                    : EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 180.0),
                                child: Column(
                                  children: [
                                    TextField(
                                      style:
                                          TextStyle(color: Color(0xff313945)),
                                      decoration: InputDecoration(
                                          labelText: 'First Name *',
                                          prefixIcon: Icon(Icons.person_add)),
                                    ),
                                    SizedBox(
                                      height: 28,
                                    ),
                                    TextField(
                                      style:
                                          TextStyle(color: Color(0xff313945)),
                                      decoration: InputDecoration(
                                          labelText: 'Last Name *',
                                          prefixIcon: Icon(Icons.person)),
                                    ),
                                    SizedBox(
                                      height: 28,
                                    ),
                                    GestureDetector(
                                      onTap: () => _selectDate(context),
                                      child: AbsorbPointer(
                                        child: TextField(
                                          style: TextStyle(
                                              color: Color(0xff313945)),
                                          controller: birthdate,
                                          decoration: InputDecoration(
                                              labelText: 'Date Of Birth *',
                                              prefixIcon: Icon(Icons.cake)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 28,
                                    ),
                                    Container(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.question_answer),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                              child: Text(
                                                  "Accept terms of service? "),
                                            ),
                                            Switch(
                                                value: isSwitched,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isSwitched = value;
                                                  });
                                                }),
                                          ],
                                        )
                                      ],
                                    )),
                                    SizedBox(
                                      height: 28,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: Text("Create user account"))
                                  ],
                                ),
                              ),*/
                            ],
                          ),
                        )
                      ]),
                    )
                  ],
                ),
              ),
            )));
  }
}
