// To parse this JSON data, do
//
//     final editOrdenesEntregaModel = editOrdenesEntregaModelFromJson(jsonString);

import 'dart:convert';

EditOrdenesEntregaModel editOrdenesEntregaModelFromJson(String str) =>
    EditOrdenesEntregaModel.fromJson(json.decode(str));

String editOrdenesEntregaModelToJson(EditOrdenesEntregaModel data) =>
    json.encode(data.toJson());

class EditOrdenesEntregaModel {
  EditOrdenesEntregaModel({
    this.result,
    required this.deliveryOrderData,
  });

  bool? result;
  DeliveryOrderData deliveryOrderData;

  factory EditOrdenesEntregaModel.fromJson(Map<String, dynamic> json) =>
      EditOrdenesEntregaModel(
        result: json["result"],
        deliveryOrderData:
            DeliveryOrderData.fromJson(json["deliveryOrderData"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "deliveryOrderData": deliveryOrderData.toJson(),
      };
}

class DeliveryOrderData {
  DeliveryOrderData({
    required this.deliveryOrder,
    this.inks,
  });

  List<DeliveryOrder> deliveryOrder;
  List<Ink>? inks;

  factory DeliveryOrderData.fromJson(Map<String, dynamic> json) =>
      DeliveryOrderData(
        deliveryOrder: List<DeliveryOrder>.from(
            json["deliveryOrder"].map((x) => DeliveryOrder.fromJson(x))),
        inks: List<Ink>.from(json["inks"].map((x) => Ink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "deliveryOrder":
            List<dynamic>.from(deliveryOrder.map((x) => x.toJson())),
        "inks": List<dynamic>.from(inks!.map((x) => x.toJson())),
      };
}

class DeliveryOrder {
  DeliveryOrder({
    this.idOrdenTrabajo,
    this.ordenTrabajoOf,
    this.fechaCreacion,
    this.idOperadorResponsable,
    this.nombreOperadorResponsable,
    this.idCatCliente,
    this.nombreCliente,
    this.idCatEstatusOt,
    this.estatusOt,
    this.idCatMaquina,
    this.nombreMaquina,
    this.idCatDiseno,
    this.nombreDiseno,
    this.idCatTurno,
    this.turno,
    this.cantidadProgramado,
    this.pesoEntregaTotal,
    this.pesoTotal,
    this.linea,
    this.fechaCierreOrden,
    this.folioEntrega,
  });

  int? idOrdenTrabajo;
  String? ordenTrabajoOf;
  DateTime? fechaCreacion;
  int? idOperadorResponsable;
  String? nombreOperadorResponsable;
  int? idCatCliente;
  String? nombreCliente;
  int? idCatEstatusOt;
  String? estatusOt;
  int? idCatMaquina;
  String? nombreMaquina;
  int? idCatDiseno;
  String? nombreDiseno;
  int? idCatTurno;
  String? turno;
  int? cantidadProgramado;
  int? pesoEntregaTotal;
  dynamic? pesoTotal;
  String? linea;
  dynamic? fechaCierreOrden;
  int? folioEntrega;

  factory DeliveryOrder.fromJson(Map<String, dynamic> json) => DeliveryOrder(
        idOrdenTrabajo: json["id_orden_trabajo"],
        ordenTrabajoOf: json["orden_trabajo_of"],
        fechaCreacion: DateTime.parse(json["fecha_creacion"]),
        idOperadorResponsable: json["id_operador_responsable"],
        nombreOperadorResponsable: json["nombre_operador_responsable"],
        idCatCliente: json["id_cat_cliente"],
        nombreCliente: json["nombre_cliente"],
        idCatEstatusOt: json["id_cat_estatus_ot"],
        estatusOt: json["estatus_ot"],
        idCatMaquina: json["id_cat_maquina"],
        nombreMaquina: json["nombre_maquina"],
        idCatDiseno: json["id_cat_diseno"],
        nombreDiseno: json["nombre_diseno"],
        idCatTurno: json["id_cat_turno"],
        turno: json["turno"],
        cantidadProgramado: json["cantidad_programado"],
        pesoEntregaTotal: json["peso_entrega_total"],
        pesoTotal: json["peso_total"],
        linea: json["linea"],
        fechaCierreOrden: json["fecha_cierre_orden"],
        folioEntrega: json["folio_entrega"],
      );

  Map<String, dynamic> toJson() => {
        "id_orden_trabajo": idOrdenTrabajo,
        "orden_trabajo_of": ordenTrabajoOf,
        "fecha_creacion": fechaCreacion!.toIso8601String(),
        "id_operador_responsable": idOperadorResponsable,
        "nombre_operador_responsable": nombreOperadorResponsable,
        "id_cat_cliente": idCatCliente,
        "nombre_cliente": nombreCliente,
        "id_cat_estatus_ot": idCatEstatusOt,
        "estatus_ot": estatusOt,
        "id_cat_maquina": idCatMaquina,
        "nombre_maquina": nombreMaquina,
        "id_cat_diseno": idCatDiseno,
        "nombre_diseno": nombreDiseno,
        "id_cat_turno": idCatTurno,
        "turno": turno,
        "cantidad_programado": cantidadProgramado,
        "peso_entrega_total": pesoEntregaTotal,
        "peso_total": pesoTotal,
        "linea": linea,
        "fecha_cierre_orden": fechaCierreOrden,
        "folio_entrega": folioEntrega,
      };
}

class Ink {
  Ink({
    this.idOtDetalleTinta,
    this.idOrdenTrabajo,
    this.idCatTinta,
    this.nombreTinta,
    this.codigoCliente,
    this.codigoGp,
    this.aditivo,
    this.lote,
    this.idCatTara,
    this.nombreTara,
    this.utilizaPh,
    this.mideViscosidad,
    this.utilizaFiltro,
    this.pesoIndividualGp,
    this.pesoIndividualCliente,
    this.idCatLecturaGp,
    this.lectura,
    this.idCatLecturaCliente,
    this.lecturaCliente,
    this.idCatRazon,
    this.razon,
    this.aditivoTinta,
  });

  int? idOtDetalleTinta;
  int? idOrdenTrabajo;
  int? idCatTinta;
  String? nombreTinta;
  String? codigoCliente;
  String? codigoGp;
  int? aditivo;
  String? lote;
  int? idCatTara;
  dynamic? nombreTara;
  int? utilizaPh;
  int? mideViscosidad;
  int? utilizaFiltro;
  dynamic? pesoIndividualGp;
  dynamic? pesoIndividualCliente;
  int? idCatLecturaGp;
  dynamic? lectura;
  dynamic? idCatLecturaCliente;
  dynamic? lecturaCliente;
  dynamic? idCatRazon;
  dynamic? razon;
  String? aditivoTinta;

  factory Ink.fromJson(Map<String, dynamic> json) => Ink(
        idOtDetalleTinta: json["id_ot_detalle_tinta"],
        idOrdenTrabajo: json["id_orden_trabajo"],
        idCatTinta: json["id_cat_tinta"],
        nombreTinta: json["nombre_tinta"],
        codigoCliente: json["codigo_cliente"],
        codigoGp: json["codigo_gp"],
        aditivo: json["aditivo"],
        lote: json["lote"],
        idCatTara: json["id_cat_tara"],
        nombreTara: json["nombre_tara"],
        utilizaPh: json["utiliza_ph"],
        mideViscosidad: json["mide_viscosidad"],
        utilizaFiltro: json["utiliza_filtro"],
        pesoIndividualGp: json["peso_individual_gp"],
        pesoIndividualCliente: json["peso_individual_cliente"],
        idCatLecturaGp: json["id_cat_lectura_gp"],
        lectura: json["lectura"],
        idCatLecturaCliente: json["id_cat_lectura_cliente"],
        lecturaCliente: json["lectura_cliente"],
        idCatRazon: json["id_cat_razon"],
        razon: json["razon"],
        aditivoTinta: json["aditivo_tinta"],
      );

  Map<String, dynamic> toJson() => {
        "id_ot_detalle_tinta": idOtDetalleTinta,
        "id_orden_trabajo": idOrdenTrabajo,
        "id_cat_tinta": idCatTinta,
        "nombre_tinta": nombreTinta,
        "codigo_cliente": codigoCliente,
        "codigo_gp": codigoGp,
        "aditivo": aditivo,
        "lote": lote,
        "id_cat_tara": idCatTara,
        "nombre_tara": nombreTara,
        "utiliza_ph": utilizaPh,
        "mide_viscosidad": mideViscosidad,
        "utiliza_filtro": utilizaFiltro,
        "peso_individual_gp": pesoIndividualGp,
        "peso_individual_cliente": pesoIndividualCliente,
        "id_cat_lectura_gp": idCatLecturaGp,
        "lectura": lectura,
        "id_cat_lectura_cliente": idCatLecturaCliente,
        "lectura_cliente": lecturaCliente,
        "id_cat_razon": idCatRazon,
        "razon": razon,
        "aditivo_tinta": aditivoTinta,
      };
}
