// To parse this JSON data, do
//
//     final listDesignsModel = listDesignsModelFromJson(jsonString);

import 'dart:convert';

ListDesignsModel listDesignsModelFromJson(String str) =>
    ListDesignsModel.fromJson(json.decode(str));

String listDesignsModelToJson(ListDesignsModel data) =>
    json.encode(data.toJson());

class ListDesignsModel {
  ListDesignsModel({
    this.result,
    this.designsTotal,
    this.actualPage,
    this.lastPage,
    required this.designsList,
    this.nombrePlanta,
    this.estatus,
    this.idCatEstatus,
    this.idCatPlanta,
  });

  bool? result;
  int? designsTotal;
  int? actualPage;
  int? lastPage;
  List<DesignsList> designsList;
  String? nombrePlanta;
  String? estatus;
  int? idCatEstatus;
  int? idCatPlanta;

  factory ListDesignsModel.fromJson(Map<String, dynamic> json) =>
      ListDesignsModel(
        result: json["result"],
        designsTotal: json["designsTotal"],
        actualPage: json["actualPage"],
        lastPage: json["lastPage"],
        designsList: List<DesignsList>.from(
            json["designsList"].map((x) => DesignsList.fromJson(x))),
        nombrePlanta: json["nombre_planta"],
        estatus: json["estatus"],
        idCatEstatus: json["id_cat_estatus"],
        idCatPlanta: json["id_cat_planta"],
        // designsList: DesignsList.fromJson(json["designsList"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "designsTotal": designsTotal,
        "actualPage": actualPage,
        "lastPage": lastPage,
        "designsList": List<dynamic>.from(designsList.map((e) => e.toJson())),
        "nombre_planta": nombrePlanta,
        "estatus": estatus,
        "id_cat_estatus": idCatEstatus,
        "id_cat_planta": idCatPlanta,
        // "designsList": designsList.toJson(),
      };
}

class DesignsList {
  DesignsList({
    this.idCatDiseno,
    this.nombreDiseno,
    this.descripcion,
    this.tintas,
    this.nombrePlanta,
    this.estatus,
    this.idCatEstatus,
    this.idCatPlanta,
  });

  int? idCatDiseno;
  String? nombreDiseno;
  String? descripcion;
  List<dynamic>? tintas;
  String? nombrePlanta;
  String? estatus;
  int? idCatEstatus;
  int? idCatPlanta;

  factory DesignsList.fromJson(Map<String, dynamic> json) => DesignsList(
        idCatDiseno: json["id_cat_diseno"],
        nombreDiseno: json["nombre_diseno"],
        descripcion: json["descripcion"],
        tintas: List<dynamic>.from(json["tintas"].map((x) => x)),
        nombrePlanta: json["nombre_planta"],
        estatus: json["estatus"],
        idCatEstatus: json["id_cat_estatus"],
        idCatPlanta: json["id_cat_planta"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_diseno": idCatDiseno,
        "nombre_diseno": nombreDiseno,
        "descripcion": descripcion,
        "tintas": List<dynamic>.from(tintas!.map((x) => x)),
        "nombre_planta": nombrePlanta,
        "estatus": estatus,
        "id_cat_estatus": idCatEstatus,
        "id_cat_planta": idCatPlanta,
      };
}
