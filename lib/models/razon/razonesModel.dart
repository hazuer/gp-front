// To parse this JSON data, do
//
//     final listRazonesModel = listRazonesModelFromJson(jsonString);

import 'dart:convert';

ListRazonesModel listRazonesModelFromJson(String str) =>
    ListRazonesModel.fromJson(json.decode(str));

String listRazonesModelToJson(ListRazonesModel data) =>
    json.encode(data.toJson());

class ListRazonesModel {
  ListRazonesModel({
    this.result,
    this.reasonsTotal,
    this.actualPage,
    this.lastPage,
    required this.reasonsList,
  });

  bool? result;
  int? reasonsTotal;
  int? actualPage;
  int? lastPage;
  List<ReasonsList> reasonsList;
  // ReasonsList reasonsList;

  factory ListRazonesModel.fromJson(Map<String, dynamic> json) =>
      ListRazonesModel(
        result: json["result"],
        reasonsTotal: json["reasonsTotal"],
        actualPage: json["actualPage"],
        lastPage: json["lastPage"],
        reasonsList: List<ReasonsList>.from(
            json["reasonsList"].map((x) => ReasonsList.fromJson(x))),
        // reasonsList: ReasonsList.fromJson(json["reasonsList"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "reasonsTotal": reasonsTotal,
        "actualPage": actualPage,
        "lastPage": lastPage,
        "reasonsList": List<dynamic>.from(reasonsList.map((e) => e.toJson())),
        // "reasonsList": reasonsList.toJson(),
      };
}

class ReasonsList {
  ReasonsList({
    this.idCatRazon,
    this.razon,
    this.nombrePlanta,
    this.estatus,
  });

  int? idCatRazon;
  String? razon;
  String? nombrePlanta;
  String? estatus;

  factory ReasonsList.fromJson(Map<String, dynamic> json) => ReasonsList(
        idCatRazon: json["id_cat_razon"],
        razon: json["razon"],
        nombrePlanta: json["nombre_planta"],
        estatus: json["estatus"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_razon": idCatRazon,
        "razon": razon,
        "nombre_planta": nombrePlanta,
        "estatus": estatus,
      };
}
