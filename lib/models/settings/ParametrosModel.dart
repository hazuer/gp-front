// // To parse this JSON data, do
// //
// //     final parametrosModel = parametrosModelFromJson(jsonString);

// import 'dart:convert';

// ParametrosModel parametrosModelFromJson(String str) =>
//     ParametrosModel.fromJson(json.decode(str));

// String parametrosModelToJson(ParametrosModel data) =>
//     json.encode(data.toJson());

// class ParametrosModel {
//   ParametrosModel({
//     this.result,
//     this.systemParams,
//   });

//   bool? result;
//   Map<String, int>? systemParams;

//   factory ParametrosModel.fromJson(Map<String, dynamic> json) =>
//       ParametrosModel(
//         result: json["result"],
//         systemParams: Map.from(json["systemParams"])
//             .map((k, v) => MapEntry<String, int>(k, v)),
//       );

//   Map<String, dynamic> toJson() => {
//         "result": result,
//         "systemParams": Map.from(systemParams!)
//             .map((k, v) => MapEntry<String, dynamic>(k, v)),
//       };
// }

// To parse this JSON data, do
//
//     final parametrosModel = parametrosModelFromJson(jsonString);

import 'dart:convert';

ParametrosModel parametrosModelFromJson(String str) =>
    ParametrosModel.fromJson(json.decode(str));

String parametrosModelToJson(ParametrosModel data) =>
    json.encode(data.toJson());

class ParametrosModel {
  ParametrosModel({
    this.result,
    required this.systemParams,
  });

  bool? result;
  // List<SystemParams> systemParams;
  SystemParams systemParams;

  factory ParametrosModel.fromJson(Map<String, dynamic> json) =>
      ParametrosModel(
        result: json["result"],
        // systemParams: List<SystemParams>.from(
        //     json["systemParams"].map((x) => SystemParams.fromJson(x))),
        systemParams: SystemParams.fromJson(json["systemParams"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        // "systemParams": List<dynamic>.from(systemParams.map((x) => x.toJson())),
        "systemParams": systemParams.toJson(),
      };
}

class SystemParams {
  SystemParams({
    this.idCatPlanta,
    this.campoLote,
    this.campoCantidadProgramada,
    this.utilizaTara,
    this.campoLinea,
    this.requiereTurno,
    this.variacionMaxima,
    this.porcentajeVariacionAceptado,
    this.utilizaPh,
    this.mideViscosidad,
    this.utilizaFiltro,
  });

  int? idCatPlanta;
  int? campoLote;
  int? campoCantidadProgramada;
  int? utilizaTara;
  int? campoLinea;
  int? requiereTurno;
  int? variacionMaxima;
  int? porcentajeVariacionAceptado;
  int? utilizaPh;
  int? mideViscosidad;
  int? utilizaFiltro;

  factory SystemParams.fromJson(Map<String, dynamic> json) => SystemParams(
        idCatPlanta: json["id_cat_planta"],
        campoLote: json["campo_lote"],
        campoCantidadProgramada: json["campo_cantidad_programada"],
        utilizaTara: json["utiliza_tara"],
        campoLinea: json["campo_linea"],
        requiereTurno: json["requiere_turno"],
        variacionMaxima: json["variacion_maxima"],
        porcentajeVariacionAceptado: json["porcentaje_variacion_aceptado"],
        utilizaPh: json["utiliza_ph"],
        mideViscosidad: json["mide_viscosidad"],
        utilizaFiltro: json["utiliza_filtro"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_planta": idCatPlanta,
        "campo_lote": campoLote,
        "campo_cantidad_programada": campoCantidadProgramada,
        "utiliza_tara": utilizaTara,
        "campo_linea": campoLinea,
        "requiere_turno": requiereTurno,
        "variacion_maxima": variacionMaxima,
        "porcentaje_variacion_aceptado": porcentajeVariacionAceptado,
        "utiliza_ph": utilizaPh,
        "mide_viscosidad": mideViscosidad,
        "utiliza_filtro": utilizaFiltro,
      };
}
