// To parse this JSON data, do
//
//     final paisesList = paisesListFromJson(jsonString);

import 'dart:convert';

ListPaisesModel listPaisesModelFromJson(String str) =>
    ListPaisesModel.fromJson(json.decode(str));

String listPaisesModelToJson(ListPaisesModel data) =>
    json.encode(data.toJson());

class ListPaisesModel {
  ListPaisesModel({
    this.result,
    this.paisesTotal,
    this.actualPage,
    this.lastPage,
    required this.paisesList,
  });

  bool? result;
  int? paisesTotal;
  int? actualPage;
  int? lastPage;
  List<PaisesList> paisesList;

  factory ListPaisesModel.fromJson(Map<String, dynamic> json) =>
      ListPaisesModel(
        result: json["result"],
        paisesTotal: json["paisesTotal"],
        actualPage: json["actualPage"],
        lastPage: json["lastPage"],
        paisesList: List<PaisesList>.from(
            json["paisesList"].map((x) => PaisesList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "paisesTotal": paisesTotal,
        "actualPage": actualPage,
        "lastPage": lastPage,
        "userList": List<dynamic>.from(paisesList.map((x) => x.toJson())),
      };
}

class PaisesList {
  PaisesList({
    required this.idCatPais,
    required this.nombrePais,
    required this.estatus,
  });

  int idCatPais;
  String nombrePais;
  String estatus;

  factory PaisesList.fromRawJson(String str) =>
      PaisesList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaisesList.fromJson(Map<String, dynamic> json) => PaisesList(
        idCatPais: json["id_cat_pais"],
        nombrePais: json["nombre_pais"],
        estatus: json["estatus"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_pais": idCatPais,
        "nombre_pais": nombrePais,
        "estatus": estatus,
      };
}
