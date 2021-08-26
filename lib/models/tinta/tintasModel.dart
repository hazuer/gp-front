// To parse this JSON data, do
//
//     final listTintasModel = listTintasModelFromJson(jsonString);

import 'dart:convert';

ListTintasModel listTintasModelFromJson(String str) =>
    ListTintasModel.fromJson(json.decode(str));

String listTintasModelToJson(ListTintasModel data) =>
    json.encode(data.toJson());

class ListTintasModel {
  ListTintasModel({
    this.result,
    this.inksTotal,
    this.actualPage,
    this.lastPage,
    required this.inkList,
  });

  bool? result;
  int? inksTotal;
  int? actualPage;
  int? lastPage;
  List<InkList> inkList;

  factory ListTintasModel.fromJson(Map<String, dynamic> json) =>
      ListTintasModel(
        result: json["result"],
        inksTotal: json["inksTotal"],
        actualPage: json["actualPage"],
        lastPage: json["lastPage"],
        inkList:
            List<InkList>.from(json["inkList"].map((x) => InkList.fromJson(x))),
        // inkList: InkList.fromJson(json["inkList"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "inksTotal": inksTotal,
        "actualPage": actualPage,
        "lastPage": lastPage,
        "inkList": List<dynamic>.from(inkList.map((e) => e.toJson())),
        // "inkList": inkList.toJson(),
      };
}

class InkList {
  InkList({
    this.idCatTinta,
    this.nombreTinta,
    this.codigoCliente,
    this.codigoGp,
    this.nombrePlanta,
    this.estatus,
  });

  int? idCatTinta;
  String? nombreTinta;
  String? codigoCliente;
  String? codigoGp;
  String? nombrePlanta;
  String? estatus;

  factory InkList.fromJson(Map<String, dynamic> json) => InkList(
        idCatTinta: json["id_cat_tinta"],
        nombreTinta: json["nombre_tinta"],
        codigoCliente: json["codigo_cliente"],
        codigoGp: json["codigo_gp"],
        nombrePlanta: json["nombre_planta"],
        estatus: json["estatus"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_tinta": idCatTinta,
        "nombre_tinta": nombreTinta,
        "codigo_cliente": codigoCliente,
        "codigo_gp": codigoGp,
        "nombre_planta": nombrePlanta,
        "estatus": estatus,
      };
}
