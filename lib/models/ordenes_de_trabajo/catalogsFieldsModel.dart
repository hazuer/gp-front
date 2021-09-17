// To parse this JSON data, do
//
//     final catalogsFieldsModel = catalogsFieldsModelFromJson(jsonString);

import 'dart:convert';

import 'package:general_products_web/models/ordenes_de_trabajo/catCustomersOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/dtDesignsOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catMachinesOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catOperatorsOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catStatusOEModel.dart';

CatalogsFieldsModel catalogsFieldsModelFromJson(String str) =>
    CatalogsFieldsModel.fromJson(json.decode(str));

String catalogsFieldsModelToJson(CatalogsFieldsModel data) =>
    json.encode(data.toJson());

class CatalogsFieldsModel {
  CatalogsFieldsModel({
    this.result,
    required this.operatorsList,
    required this.customersList,
    required this.statusOwList,
    required this.machinesList,
    required this.designsList,
  });

  bool? result;
  List<CatOperatorsOEModel> operatorsList;
  List<CatCustomersOEModel> customersList;
  List<CatStatusOEModel> statusOwList;
  List<CatMachinesOEModel> machinesList;
  List<DtDesignsOEModel> designsList;

  factory CatalogsFieldsModel.fromJson(Map<String, dynamic> json) =>
      CatalogsFieldsModel(
        result: json["result"],
        operatorsList: List<CatOperatorsOEModel>.from(
            json["operatorsList"].map((x) => CatOperatorsOEModel.fromJson(x))),
        customersList: List<CatCustomersOEModel>.from(
            json["customersList"].map((x) => CatCustomersOEModel.fromJson(x))),
        statusOwList: List<CatStatusOEModel>.from(
            json["statusOWList"].map((x) => CatStatusOEModel.fromJson(x))),
        machinesList: List<CatMachinesOEModel>.from(
            json["machinesList"].map((x) => CatMachinesOEModel.fromJson(x))),
        designsList: List<DtDesignsOEModel>.from(
            json["designsList"].map((x) => DtDesignsOEModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "operatorsList":
            List<dynamic>.from(operatorsList.map((x) => x.toJson())),
        "customersList":
            List<dynamic>.from(customersList.map((x) => x.toJson())),
        "statusOWList": List<dynamic>.from(statusOwList.map((x) => x.toJson())),
        "machinesList": List<dynamic>.from(machinesList.map((x) => x.toJson())),
        "designsList": List<dynamic>.from(designsList.map((x) => x.toJson())),
      };
}

// class CustomersList {
//   CustomersList({
//     this.idCatCliente,
//     this.nombreCliente,
//   });

//   int? idCatCliente;
//   String? nombreCliente;

//   factory CustomersList.fromJson(Map<String, dynamic> json) => CustomersList(
//         idCatCliente: json["id_cat_cliente"],
//         nombreCliente: json["nombre_cliente"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id_cat_cliente": idCatCliente,
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

// class OperatorsList {
//   OperatorsList({
//     this.idUsuario,
//     this.nombreOperadorResponsable,
//   });

//   int? idUsuario;
//   String? nombreOperadorResponsable;

//   factory OperatorsList.fromJson(Map<String, dynamic> json) => OperatorsList(
//         idUsuario: json["id_usuario"],
//         nombreOperadorResponsable: json["nombre_operador_responsable"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id_usuario": idUsuario,
//         "nombre_operador_responsable": nombreOperadorResponsable,
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
