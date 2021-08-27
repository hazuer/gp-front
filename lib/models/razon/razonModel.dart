// To parse this JSON data, do
//
//     final reazonModel = reazonModelFromJson(jsonString);

// import 'dart:convert';

// RazonModel reazonModelFromJson(String str) =>
//     RazonModel.fromJson(json.decode(str));

// String reazonModelToJson(RazonModel data) => json.encode(data.toJson());

class RazonModel {
  RazonModel({
    this.idCatRazon,
    this.razon,
    this.nombrePlanta,
    this.estatus,
    this.idCatEstatus,
    this.idCatPlanta,
  });

  int? idCatRazon;
  String? razon;
  String? nombrePlanta;
  String? estatus;
  int? idCatEstatus;
  int? idCatPlanta;

  factory RazonModel.fromJson(Map<String, dynamic> json) => RazonModel(
        idCatRazon: json["id_cat_razon"],
        razon: json["razon"],
        nombrePlanta: json["nombre_planta"],
        estatus: json["estatus"],
        idCatEstatus: json["id_cat_estatus"],
        idCatPlanta: json["id_cat_planta"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_razon": idCatRazon,
        "razon": razon,
        "nombre_planta": nombrePlanta,
        "estatus": estatus,
        "id_cat_estatus": idCatEstatus,
        "id_cat_planta": idCatPlanta,
      };
}
