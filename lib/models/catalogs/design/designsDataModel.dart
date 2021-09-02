// To parse this JSON data, do
//
//     final desingsDataModel = desingsDataModelFromJson(jsonString);

import 'dart:convert';

DesingsDataModel desingsDataModelFromJson(String str) =>
    DesingsDataModel.fromJson(json.decode(str));

String desingsDataModelToJson(DesingsDataModel data) =>
    json.encode(data.toJson());

class DesingsDataModel {
  DesingsDataModel({
    this.result,
    this.design,
  });

  bool? result;
  Design? design;

  factory DesingsDataModel.fromJson(Map<String, dynamic> json) =>
      DesingsDataModel(
        result: json["result"],
        design: Design.fromJson(json["design"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "design": result,
        // "design": design.toJson(),
      };
}

class Design {
  Design({
    this.designData,
    this.inksDesign,
  });

  List<DesignDatum>? designData;
  List<InksDesign>? inksDesign;

  factory Design.fromJson(Map<String, dynamic> json) => Design(
        designData: List<DesignDatum>.from(
            json["designData"].map((x) => DesignDatum.fromJson(x))),
        inksDesign: List<InksDesign>.from(
            json["inksDesign"].map((x) => InksDesign.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "designData": List<dynamic>.from(designData!.map((x) => x.toJson())),
        "inksDesign": List<dynamic>.from(inksDesign!.map((x) => x.toJson())),
      };
}

class DesignDatum {
  DesignDatum({
    this.idCatDiseno,
    this.nombreDiseno,
    this.descripcion,
    this.idCatPlanta,
    this.idCatEstatus,
  });

  int? idCatDiseno;
  String? nombreDiseno;
  String? descripcion;
  int? idCatPlanta;
  int? idCatEstatus;

  factory DesignDatum.fromJson(Map<String, dynamic> json) => DesignDatum(
        idCatDiseno: json["id_cat_diseno"],
        nombreDiseno: json["nombre_diseno"],
        descripcion: json["descripcion"],
        idCatPlanta: json["id_cat_planta"],
        idCatEstatus: json["id_cat_estatus"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_diseno": idCatDiseno,
        "nombre_diseno": nombreDiseno,
        "descripcion": descripcion,
        "id_cat_planta": idCatPlanta,
        "id_cat_estatus": idCatEstatus,
      };
}

class InksDesign {
  InksDesign({
    this.idDisenoTinta,
    this.nombreTinta,
    this.codigoCliente,
    this.codigoGp,
    this.estatus,
  });

  dynamic? idDisenoTinta;
  String? nombreTinta;
  String? codigoCliente;
  String? codigoGp;
  String? estatus;

  factory InksDesign.fromJson(Map<String, dynamic> json) => InksDesign(
        idDisenoTinta: json["id_diseno_tinta"],
        nombreTinta: json["nombre_tinta"],
        codigoCliente: json["codigo_cliente"],
        codigoGp: json["codigo_gp"],
        estatus: json["estatus"],
      );

  Map<String, dynamic> toJson() => {
        "id_diseno_tinta": idDisenoTinta,
        "nombre_tinta": nombreTinta,
        "codigo_cliente": codigoCliente,
        "codigo_gp": codigoGp,
        "estatus": estatus,
      };
}
