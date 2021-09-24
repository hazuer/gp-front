// To parse this JSON data, do
//
//     final createOrdenesEntregaModel = createOrdenesEntregaModelFromJson(jsonString);

import 'dart:convert';

CreateOrdenesEntregaModel createOrdenesEntregaModelFromJson(String str) =>
    CreateOrdenesEntregaModel.fromJson(json.decode(str));

String createOrdenesEntregaModelToJson(CreateOrdenesEntregaModel data) =>
    json.encode(data.toJson());

class CreateOrdenesEntregaModel {
  CreateOrdenesEntregaModel({
    this.ordenTrabajoOf,
    this.idCatMaquina,
    this.idCatDiseno,
    this.cantidadProgramado,
    this.pesoTotal,
    this.idCatTurno,
    this.linea,
    this.fechaCierreOrden,
    required this.tintas,
  });

  int? ordenTrabajoOf;
  int? idCatMaquina;
  int? idCatDiseno;
  int? cantidadProgramado;
  int? pesoTotal;
  int? idCatTurno;
  int? linea;
  String? fechaCierreOrden;
  List<Tinta?> tintas;

  factory CreateOrdenesEntregaModel.fromJson(Map<String, dynamic> json) =>
      CreateOrdenesEntregaModel(
        ordenTrabajoOf: json["orden_trabajo_of"],
        idCatMaquina: json["id_cat_maquina"],
        idCatDiseno: json["id_cat_diseno"],
        cantidadProgramado: json["cantidad_programado"],
        pesoTotal: json["peso_total"],
        idCatTurno: json["id_cat_turno"],
        linea: json["linea"],
        fechaCierreOrden: json["fecha_cierre_orden"],
        tintas: List<Tinta>.from(json["tintas"].map((x) => Tinta.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orden_trabajo_of": ordenTrabajoOf,
        "id_cat_maquina": idCatMaquina,
        "id_cat_diseno": idCatDiseno,
        "cantidad_programado": cantidadProgramado,
        "peso_total": pesoTotal,
        "id_cat_turno": idCatTurno,
        "linea": linea,
        "fecha_cierre_orden": fechaCierreOrden,
        "tintas": List<dynamic>.from(tintas.map((x) => x!.toJson())),
      };
}

class Tinta {
  Tinta({
    this.idCatTinta,
    this.lote,
    this.idCatTara,
    this.pesoIndividual,
    this.utilizaPh,
    this.mideViscosidad,
    this.utilizaFiltro,
    this.porcentajeVariacion,
    this.pesoIndividualGp,
    this.idCatLecturaGp,
    this.idCatRazon,
    this.aditivoTinta,
    this.aditivo,
  });

  int? idCatTinta;
  int? lote;
  int? idCatTara;
  double?
      pesoIndividual; // En postman venia int, pero es un peso, debe ser double
  bool? utilizaPh;
  bool? mideViscosidad;
  bool? utilizaFiltro;
  int? porcentajeVariacion;
  int? pesoIndividualGp;
  int? idCatLecturaGp;
  int? idCatRazon;
  String? aditivoTinta;
  int? aditivo;

  factory Tinta.fromJson(Map<String, dynamic> json) => Tinta(
        idCatTinta: json["id_cat_tinta"],
        lote: json["lote"],
        idCatTara: json["id_cat_tara"],
        pesoIndividual: json["peso_individual"],
        utilizaPh: json["utiliza_ph"],
        mideViscosidad: json["mide_viscosidad"],
        utilizaFiltro: json["utiliza_filtro"],
        porcentajeVariacion: json["porcentaje_variacion"],
        pesoIndividualGp: json["peso_individual_gp"],
        idCatLecturaGp: json["id_cat_lectura_gp"],
        idCatRazon: json["id_cat_razon"] == null ? null : json["id_cat_razon"],
        aditivoTinta:
            json["aditivo_tinta"] == null ? null : json["aditivo_tinta"],
        aditivo: json["aditivo"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_tinta": idCatTinta,
        "lote": lote,
        "id_cat_tara": idCatTara,
        "peso_individual": pesoIndividual,
        "utiliza_ph": utilizaPh,
        "mide_viscosidad": mideViscosidad,
        "utiliza_filtro": utilizaFiltro,
        "porcentaje_variacion": porcentajeVariacion,
        "peso_individual_gp": pesoIndividualGp,
        "id_cat_lectura_gp": idCatLecturaGp,
        "id_cat_razon": idCatRazon == null ? null : idCatRazon,
        "aditivo_tinta": aditivoTinta == null ? null : aditivoTinta,
        "aditivo": aditivo,
      };
}
