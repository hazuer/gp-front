// To parse this JSON data, do
//
//     final plantsStatusCustomersModel = plantsStatusCustomersModelFromJson(jsonString);

import 'dart:convert';

PlantsStatusCustomersModel plantsStatusCustomersModelFromJson(String str) =>
    PlantsStatusCustomersModel.fromJson(json.decode(str));

String plantsStatusCustomersModelToJson(PlantsStatusCustomersModel data) =>
    json.encode(data.toJson());

class PlantsStatusCustomersModel {
  PlantsStatusCustomersModel({
    this.result,
    this.listPlants,
    this.listStatus,
  });

  bool? result;
  List<ListPlant>? listPlants;
  List<ListStatus>? listStatus;

  factory PlantsStatusCustomersModel.fromJson(Map<String, dynamic> json) =>
      PlantsStatusCustomersModel(
        result: json["result"],
        listPlants: List<ListPlant>.from(
            json["listPlants"].map((x) => ListPlant.fromJson(x))),
        listStatus: List<ListStatus>.from(
            json["listStatus"].map((x) => ListStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "listPlants": List<dynamic>.from(listPlants!.map((x) => x.toJson())),
        "listStatus": List<dynamic>.from(listStatus!.map((x) => x.toJson())),
      };
}

class ListPlant {
  ListPlant({
    this.idCatPlanta,
    this.nombrePlanta,
  });

  int? idCatPlanta;
  String? nombrePlanta;

  factory ListPlant.fromJson(Map<String, dynamic> json) => ListPlant(
        idCatPlanta: json["id_cat_planta"],
        nombrePlanta: json["nombre_planta"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_planta": idCatPlanta,
        "nombre_planta": nombrePlanta,
      };
}

class ListStatus {
  ListStatus({
    this.idCatEstatus,
    this.estatus,
  });

  int? idCatEstatus;
  String? estatus;

  factory ListStatus.fromJson(Map<String, dynamic> json) => ListStatus(
        idCatEstatus: json["id_cat_estatus"],
        estatus: json["estatus"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_estatus": idCatEstatus,
        "estatus": estatus,
      };
}
