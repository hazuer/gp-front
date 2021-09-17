// To parse this JSON data, do
//
//     final createOrdenesEntregaModel = createOrdenesEntregaModelFromJson(jsonString);

import 'dart:convert';

CatInksOEModel createOrdenesEntregaModelFromJson(String str) =>
    CatInksOEModel.fromJson(json.decode(str));

String createOrdenesEntregaModelToJson(CatInksOEModel data) =>
    json.encode(data.toJson());

class CatInksOEModel {
  CatInksOEModel({
    this.result,
    required this.inksList,
  });

  bool? result;
  List<InksList> inksList;

  factory CatInksOEModel.fromJson(Map<String, dynamic> json) => CatInksOEModel(
        result: json["result"],
        inksList: List<InksList>.from(
            json["inksList"].map((x) => InksList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "inksList": List<dynamic>.from(inksList!.map((x) => x.toJson())),
      };
}

class InksList {
  InksList({
    this.idCatTinta,
    this.nombreTinta,
    this.codigoCliente,
    this.codigoGp,
    this.aditivo,
  });

  int? idCatTinta;
  String? nombreTinta;
  String? codigoCliente;
  String? codigoGp;
  int? aditivo;

  factory InksList.fromJson(Map<String, dynamic> json) => InksList(
        idCatTinta: json["id_cat_tinta"],
        nombreTinta: json["nombre_tinta"],
        codigoCliente: json["codigo_cliente"],
        codigoGp: json["codigo_gp"],
        aditivo: json["aditivo"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_tinta": idCatTinta,
        "nombre_tinta": nombreTinta,
        "codigo_cliente": codigoCliente,
        "codigo_gp": codigoGp,
        "aditivo": aditivo,
      };
}
