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
  });

  int? idCatRazon;
  String? razon;
  String? nombrePlanta;
  String? estatus;

  factory RazonModel.fromJson(Map<String, dynamic> json) => RazonModel(
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
