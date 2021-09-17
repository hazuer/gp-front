// To parse this JSON data, do
//
//     final ordenesDeEntregaModel = ordenesDeEntregaModelFromJson(jsonString);

import 'dart:convert';

ListOrdenesDeEntregaModel ordenesDeEntregaModelFromJson(String str) =>
    ListOrdenesDeEntregaModel.fromJson(json.decode(str));

String ordenesDeEntregaModelToJson(ListOrdenesDeEntregaModel data) =>
    json.encode(data.toJson());

class ListOrdenesDeEntregaModel {
  ListOrdenesDeEntregaModel({
    this.result,
    this.deliveryOrdersTotal,
    this.actualPage,
    this.lastPage,
    required this.deliveryOrdersList,
  });

  bool? result;
  int? deliveryOrdersTotal;
  int? actualPage;
  int? lastPage;
  List<DeliveryOrdersList> deliveryOrdersList;

  factory ListOrdenesDeEntregaModel.fromJson(Map<String, dynamic> json) =>
      ListOrdenesDeEntregaModel(
        result: json["result"],
        deliveryOrdersTotal: json["deliveryOrdersTotal"],
        actualPage: json["actualPage"],
        lastPage: json["lastPage"],
        deliveryOrdersList: List<DeliveryOrdersList>.from(
            json["deliveryOrdersList"]
                .map((x) => DeliveryOrdersList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "deliveryOrdersTotal": deliveryOrdersTotal,
        "actualPage": actualPage,
        "lastPage": lastPage,
        "deliveryOrdersList":
            List<dynamic>.from(deliveryOrdersList.map((x) => x.toJson())),
      };
}

class DeliveryOrdersList {
  DeliveryOrdersList({
    this.idOrdenTrabajo,
    this.ordenTrabajoOf,
    this.fechaCreacion,
    this.idOperadorResponsable,
    this.nombreOperadorResponsable,
    this.idClienteAutoriza,
    this.nombreCliente,
    this.idCatEstatusOt,
    this.estatusOt,
    this.idCatMaquina,
    this.nombreMaquina,
    this.idCatDiseno,
    this.nombreDiseno,
    this.tintas,
    this.adiciones,
  });

  int? idOrdenTrabajo;
  String? ordenTrabajoOf;
  DateTime? fechaCreacion;
  int? idOperadorResponsable;
  String? nombreOperadorResponsable;
  int? idClienteAutoriza;
  String? nombreCliente;
  int? idCatEstatusOt;
  String? estatusOt;
  int? idCatMaquina;
  String? nombreMaquina;
  int? idCatDiseno;
  String? nombreDiseno;
  List<Tinta>? tintas;
  dynamic adiciones;

  factory DeliveryOrdersList.fromJson(Map<String, dynamic> json) =>
      DeliveryOrdersList(
        idOrdenTrabajo: json["id_orden_trabajo"],
        ordenTrabajoOf: json["orden_trabajo_of"],
        fechaCreacion: DateTime.parse(json["fecha_creacion"]),
        idOperadorResponsable: json["id_operador_responsable"],
        nombreOperadorResponsable: json["nombre_operador_responsable"],
        idClienteAutoriza: json["id_cliente_autoriza"],
        nombreCliente: json["nombre_cliente"],
        idCatEstatusOt: json["id_cat_estatus_ot"],
        estatusOt: json["estatus_ot"],
        idCatMaquina: json["id_cat_maquina"],
        nombreMaquina: json["nombre_maquina"],
        idCatDiseno: json["id_cat_diseno"],
        nombreDiseno: json["nombre_diseno"],
        tintas: List<Tinta>.from(json["tintas"].map((x) => Tinta.fromJson(x))),
        adiciones: json["adiciones"],
      );

  Map<String, dynamic> toJson() => {
        "id_orden_trabajo": idOrdenTrabajo,
        "orden_trabajo_of": ordenTrabajoOf,
        "fecha_creacion": fechaCreacion!.toIso8601String(),
        "id_operador_responsable": idOperadorResponsable,
        "nombre_operador_responsable": nombreOperadorResponsable,
        "id_cliente_autoriza": idClienteAutoriza,
        "nombre_cliente": nombreCliente,
        "id_cat_estatus_ot": idCatEstatusOt,
        "estatus_ot": estatusOt,
        "id_cat_maquina": idCatMaquina,
        "nombre_maquina": nombreMaquina,
        "id_cat_diseno": idCatDiseno,
        "nombre_diseno": nombreDiseno,
        "tintas": List<dynamic>.from(tintas!.map((x) => x.toJson())),
        "adiciones": adiciones,
      };
}

class Tinta {
  Tinta({
    this.nombreTinta,
    this.codigoCliente,
    this.codigoGp,
    this.aditivo,
  });

  String? nombreTinta;
  String? codigoCliente;
  String? codigoGp;
  String? aditivo;

  factory Tinta.fromJson(Map<String, dynamic> json) => Tinta(
        nombreTinta: json["nombre_tinta"],
        codigoCliente: json["codigo_cliente"],
        codigoGp: json["codigo_gp"],
        aditivo: json["aditivo"],
      );

  Map<String, dynamic> toJson() => {
        "nombre_tinta": nombreTinta,
        "codigo_cliente": codigoCliente,
        "codigo_gp": codigoGp,
        "aditivo": aditivo,
      };
}
