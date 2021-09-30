// To parse this JSON data, do
//
//     final registrarRecursosModel = registrarRecursosModelFromJson(jsonString);

import 'dart:convert';

RegistrarRecursosModel registrarRecursosModelFromJson(String str) =>
    RegistrarRecursosModel.fromJson(json.decode(str));

String registrarRecursosModelToJson(RegistrarRecursosModel data) =>
    json.encode(data.toJson());

class RegistrarRecursosModel {
  RegistrarRecursosModel({
    this.result,
    this.registrarRecursosModelOperator,
    // this.customer,
    this.statusOwList,
    // this.designsList,
    this.machinesList,
    required this.shiftsList,
    this.tarasList,
    required this.reasonsList,
    this.additivesList,
    this.catReading,
    this.systemParams,
  });

  bool? result;
  Operator? registrarRecursosModelOperator;
  // Customer? customer;
  List<StatusOwList>? statusOwList;
  // List<DesignsList>? designsList;
  List<MachinesList>? machinesList;
  List<ShiftsList> shiftsList;
  List<dynamic>? tarasList;
  List<ReasonsList> reasonsList;
  List<dynamic>? additivesList;
  List<CatReading>? catReading;
  SystemParamsOE? systemParams;

  factory RegistrarRecursosModel.fromJson(Map<String, dynamic> json) =>
      RegistrarRecursosModel(
        result: json["result"],
        registrarRecursosModelOperator: Operator.fromJson(json["operator"]),
        // customer: Customer.fromJson(json["customer"]),
        statusOwList: List<StatusOwList>.from(
            json["statusOWList"].map((x) => StatusOwList.fromJson(x))),
        // designsList: List<DesignsList>.from(
        //     json["designsList"].map((x) => DesignsList.fromJson(x))),
        machinesList: List<MachinesList>.from(
            json["machinesList"].map((x) => MachinesList.fromJson(x))),
        shiftsList: List<ShiftsList>.from(
            json["shiftsList"].map((x) => ShiftsList.fromJson(x))),
        tarasList: List<dynamic>.from(json["tarasList"].map((x) => x)),
        reasonsList: List<ReasonsList>.from(
            json["reasonsList"].map((x) => ReasonsList.fromJson(x))),
        additivesList: List<dynamic>.from(json["additivesList"].map((x) => x)),
        catReading: List<CatReading>.from(
            json["catReading"].map((x) => CatReading.fromJson(x))),
        systemParams: SystemParamsOE.fromJson(json["systemParams"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "operator": registrarRecursosModelOperator!.toJson(),
        // "customer": customer.toJson(),
        "statusOWList":
            List<dynamic>.from(statusOwList!.map((x) => x.toJson())),
        // "designsList": List<dynamic>.from(designsList.map((x) => x.toJson())),
        "machinesList":
            List<dynamic>.from(machinesList!.map((x) => x.toJson())),
        "shiftsList": List<dynamic>.from(shiftsList.map((x) => x.toJson())),
        "tarasList": List<dynamic>.from(tarasList!.map((x) => x)),
        "reasonsList": List<dynamic>.from(reasonsList.map((x) => x.toJson())),
        "additivesList": List<dynamic>.from(additivesList!.map((x) => x)),
        "catReading": List<dynamic>.from(catReading!.map((x) => x.toJson())),
        "systemParams": systemParams!.toJson(),
      };
}

class CatReading {
  CatReading({
    this.idCatLectura,
    this.lectura,
  });

  int? idCatLectura;
  String? lectura;

  factory CatReading.fromJson(Map<String, dynamic> json) => CatReading(
        idCatLectura: json["id_cat_lectura"],
        lectura: json["lectura"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_lectura": idCatLectura,
        "lectura": lectura,
      };
}

// class Customer {
//   Customer({
//     this.nombreCliente,
//   });

//   String? nombreCliente;

//   factory Customer.fromJson(Map<String, dynamic> json) => Customer(
//         nombreCliente: json["nombre_cliente"],
//       );

//   Map<String, dynamic> toJson() => {
//         "nombre_cliente": nombreCliente,
//       };
// }

// class DesignsList {
//   DesignsList({
//     this.idCatDiseno,
//     this.nombreDiseno,
//   });

//   int? idCatDiseno;
//   String? nombreDiseno;

//   factory DesignsList.fromJson(Map<String, dynamic> json) => DesignsList(
//         idCatDiseno: json["id_cat_diseno"],
//         nombreDiseno: json["nombre_diseno"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id_cat_diseno": idCatDiseno,
//         "nombre_diseno": nombreDiseno,
//       };
// }

class MachinesList {
  MachinesList({
    this.idCatMaquina,
    this.nombreMaquina,
  });

  int? idCatMaquina;
  String? nombreMaquina;

  factory MachinesList.fromJson(Map<String, dynamic> json) => MachinesList(
        idCatMaquina: json["id_cat_maquina"],
        nombreMaquina: json["nombre_maquina"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_maquina": idCatMaquina,
        "nombre_maquina": nombreMaquina,
      };
}

class ReasonsList {
  ReasonsList({
    this.idCatRazon,
    this.razon,
  });

  int? idCatRazon;
  String? razon;

  factory ReasonsList.fromJson(Map<String, dynamic> json) => ReasonsList(
        idCatRazon: json["id_cat_razon"],
        razon: json["razon"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_razon": idCatRazon,
        "razon": razon,
      };
}

class Operator {
  Operator({
    this.nombreOperadorResponsable,
  });

  String? nombreOperadorResponsable;

  factory Operator.fromJson(Map<String, dynamic> json) => Operator(
        nombreOperadorResponsable: json["nombre_operador_responsable"],
      );

  Map<String, dynamic> toJson() => {
        "nombre_operador_responsable": nombreOperadorResponsable,
      };
}

class ShiftsList {
  ShiftsList({
    this.idCatTurno,
    this.turno,
  });

  int? idCatTurno;
  String? turno;

  factory ShiftsList.fromJson(Map<String, dynamic> json) => ShiftsList(
        idCatTurno: json["id_cat_turno"],
        turno: json["turno"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_turno": idCatTurno,
        "turno": turno,
      };
}

class StatusOwList {
  StatusOwList({
    this.idCatEstatusOt,
    this.estatusOt,
  });

  int? idCatEstatusOt;
  String? estatusOt;

  factory StatusOwList.fromJson(Map<String, dynamic> json) => StatusOwList(
        idCatEstatusOt: json["id_cat_estatus_ot"],
        estatusOt: json["estatus_ot"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_estatus_ot": idCatEstatusOt,
        "estatus_ot": estatusOt,
      };
}

class SystemParamsOE {
  SystemParamsOE({
    this.idConfiguracionSistema,
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
    this.idCatEstatus,
    this.idUsuarioCrea,
    this.fechaCreacion,
    this.idUsuarioModifica,
    this.fechaModificacion,
    this.idUsuarioElimina,
    this.fechaEliminacion,
  });

  int? idConfiguracionSistema;
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
  int? idCatEstatus;
  int? idUsuarioCrea;
  DateTime? fechaCreacion;
  int? idUsuarioModifica;
  DateTime? fechaModificacion;
  dynamic idUsuarioElimina;
  dynamic fechaEliminacion;

  factory SystemParamsOE.fromJson(Map<String, dynamic> json) => SystemParamsOE(
        idConfiguracionSistema: json["id_configuracion_sistema"],
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
        idCatEstatus: json["id_cat_estatus"],
        idUsuarioCrea: json["id_usuario_crea"],
        fechaCreacion: DateTime.parse(json["fecha_creacion"]),
        idUsuarioModifica: json["id_usuario_modifica"],
        fechaModificacion: DateTime.parse(json["fecha_modificacion"]),
        idUsuarioElimina: json["id_usuario_elimina"],
        fechaEliminacion: json["fecha_eliminacion"],
      );

  Map<String, dynamic> toJson() => {
        "id_configuracion_sistema": idConfiguracionSistema,
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
        "id_cat_estatus": idCatEstatus,
        "id_usuario_crea": idUsuarioCrea,
        "fecha_creacion": fechaCreacion!.toIso8601String(),
        "id_usuario_modifica": idUsuarioModifica,
        "fecha_modificacion": fechaModificacion!.toIso8601String(),
        "id_usuario_elimina": idUsuarioElimina,
        "fecha_eliminacion": fechaEliminacion,
      };
}

// // To parse this JSON data, do
// //
// //     final registrarRecursosModel = registrarRecursosModelFromJson(jsonString);

// // Se omitieron los campos de diseños y clientes de este modelo para
// // evitar duplicidades en los nombres en las variables globales, no se
// // estan utilizando actualmente, de ser así, descomentarlos, renombrarlos
// // y elmiminar este comentario

// import 'dart:convert';

// RegistrarRecursosModel registrarRecursosModelFromJson(String str) =>
//     RegistrarRecursosModel.fromJson(json.decode(str));

// String registrarRecursosModelToJson(RegistrarRecursosModel data) =>
//     json.encode(data.toJson());

// class RegistrarRecursosModel {
//   RegistrarRecursosModel({
//     this.result,
//     this.registrarRecursosModelOperator,
//     // this.customer,
//     this.statusOwList,
//     // this.designsList,
//     this.machinesList,
//     required this.shiftsList,
//     this.tarasList,
//     required this.reasonsList,
//     this.additivesList,
//   });

//   bool? result;
//   Operator? registrarRecursosModelOperator;
//   // Customer? customer;
//   List<StatusOwList>? statusOwList;
//   // List<DesignsList>? designsList;
//   List<MachinesList>? machinesList;
//   List<ShiftsList> shiftsList;
//   List<dynamic>? tarasList;
//   List<ReasonsList> reasonsList;
//   List<dynamic>? additivesList;

//   factory RegistrarRecursosModel.fromJson(Map<String, dynamic> json) =>
//       RegistrarRecursosModel(
//         result: json["result"],
//         registrarRecursosModelOperator: Operator.fromJson(json["operator"]),
//         // customer: Customer.fromJson(json["customer"]),
//         statusOwList: List<StatusOwList>.from(
//             json["statusOWList"].map((x) => StatusOwList.fromJson(x))),
//         // designsList: List<DesignsList>.from(
//         // json["designsList"].map((x) => DesignsList.fromJson(x))),
//         machinesList: List<MachinesList>.from(
//             json["machinesList"].map((x) => MachinesList.fromJson(x))),
//         shiftsList: List<ShiftsList>.from(
//             json["shiftsList"].map((x) => ShiftsList.fromJson(x))),
//         tarasList: List<dynamic>.from(json["tarasList"].map((x) => x)),
//         reasonsList: List<ReasonsList>.from(
//             json["reasonsList"].map((x) => ReasonsList.fromJson(x))),
//         additivesList: List<dynamic>.from(json["additivesList"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "result": result,
//         // "operator": registrarRecursosModelOperator.toJson(),
//         // "customer": customer.toJson(),
//         "statusOWList":
//             List<dynamic>.from(statusOwList!.map((x) => x.toJson())),
//         // "designsList": List<dynamic>.from(designsList!.map((x) => x.toJson())),
//         "machinesList":
//             List<dynamic>.from(machinesList!.map((x) => x.toJson())),
//         "shiftsList": List<dynamic>.from(shiftsList.map((x) => x.toJson())),
//         "tarasList": List<dynamic>.from(tarasList!.map((x) => x)),
//         "reasonsList": List<dynamic>.from(reasonsList.map((x) => x.toJson())),
//         "additivesList": List<dynamic>.from(additivesList!.map((x) => x)),
//       };
// }

// // class Customer {
// //   Customer({
// //     this.nombreCliente,
// //   });

// //   String? nombreCliente;

// //   factory Customer.fromJson(Map<String, dynamic> json) => Customer(
// //         nombreCliente: json["nombre_cliente"],
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "nombre_cliente": nombreCliente,
// //       };
// // }

// // class DesignsList {
// //   DesignsList({
// //     this.idCatDiseno,
// //     this.nombreDiseno,
// //   });

// //   int? idCatDiseno;
// //   String? nombreDiseno;

// //   factory DesignsList.fromJson(Map<String, dynamic> json) => DesignsList(
// //         idCatDiseno: json["id_cat_diseno"],
// //         nombreDiseno: json["nombre_diseno"],
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "id_cat_diseno": idCatDiseno,
// //         "nombre_diseno": nombreDiseno,
// //       };
// // }

// class MachinesList {
//   MachinesList({
//     this.idCatMaquina,
//     this.nombreMaquina,
//   });

//   int? idCatMaquina;
//   String? nombreMaquina;

//   factory MachinesList.fromJson(Map<String, dynamic> json) => MachinesList(
//         idCatMaquina: json["id_cat_maquina"],
//         nombreMaquina: json["nombre_maquina"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id_cat_maquina": idCatMaquina,
//         "nombre_maquina": nombreMaquina,
//       };
// }

// class ReasonsList {
//   ReasonsList({
//     this.idCatRazon,
//     this.razon,
//   });

//   int? idCatRazon;
//   String? razon;

//   factory ReasonsList.fromJson(Map<String, dynamic> json) => ReasonsList(
//         idCatRazon: json["id_cat_razon"],
//         razon: json["razon"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id_cat_razon": idCatRazon,
//         "razon": razon,
//       };
// }

// class Operator {
//   Operator({
//     this.nombreOperadorResponsable,
//   });

//   String? nombreOperadorResponsable;

//   factory Operator.fromJson(Map<String, dynamic> json) => Operator(
//         nombreOperadorResponsable: json["nombre_operador_responsable"],
//       );

//   Map<String, dynamic> toJson() => {
//         "nombre_operador_responsable": nombreOperadorResponsable,
//       };
// }

// class ShiftsList {
//   ShiftsList({
//     this.idCatTurno,
//     this.turno,
//   });

//   int? idCatTurno;
//   String? turno;

//   factory ShiftsList.fromJson(Map<String, dynamic> json) => ShiftsList(
//         idCatTurno: json["id_cat_turno"],
//         turno: json["turno"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id_cat_turno": idCatTurno,
//         "turno": turno,
//       };
// }

// class StatusOwList {
//   StatusOwList({
//     this.idCatEstatusOt,
//     this.estatusOt,
//   });

//   int? idCatEstatusOt;
//   String? estatusOt;

//   factory StatusOwList.fromJson(Map<String, dynamic> json) => StatusOwList(
//         idCatEstatusOt: json["id_cat_estatus_ot"],
//         estatusOt: json["estatus_ot"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id_cat_estatus_ot": idCatEstatusOt,
//         "estatus_ot": estatusOt,
//       };
// }
