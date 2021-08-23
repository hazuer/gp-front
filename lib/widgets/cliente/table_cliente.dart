import 'package:flutter/material.dart';
import 'package:general_products_web/models/cliente/list_clientes_model.dart';
import 'package:general_products_web/resources/global_variables.dart';

class TableClienteList extends StatefulWidget {
  const TableClienteList({Key? key}) : super(key: key);

  @override
  _TableClienteListState createState() => _TableClienteListState();
}

class _TableClienteListState extends State<TableClienteList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      // child: StreamBuilder(
      //   stream: rxVariables.listClientesStream,
      //   builder: (BuildContext context, AsyncSnapshot<List<CustomersList>> snapshot) {

      //   }
      // ),
    );
  }
}
