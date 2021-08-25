// To parse this JSON data, do
//
//     final dtReasonsModel = dtReasonsModelFromJson(jsonString);

import 'dart:convert';

import 'package:general_products_web/models/razon/razonModel.dart';

DtRazonesModel dtReasonsModelFromJson(String str) =>
    DtRazonesModel.fromJson(json.decode(str));

String dtReasonsModelToJson(DtRazonesModel data) => json.encode(data.toJson());

class DtRazonesModel {
  DtRazonesModel({
    this.result,
    this.reasonsTotal,
    this.actualPage,
    this.lastPage,
    required this.reasonsList,
  });

  bool? result;
  int? reasonsTotal;
  int? actualPage;
  int? lastPage;
  List<RazonModel> reasonsList;

  factory DtRazonesModel.fromJson(Map<String, dynamic> json) => DtRazonesModel(
        result: json["result"],
        reasonsTotal: json["reasonsTotal"],
        actualPage: json["actualPage"],
        lastPage: json["lastPage"],
        reasonsList: List<RazonModel>.from(
            json["razonList"].map((x) => RazonModel.fromJson(x))),
        // reasonsList: ReasonsList.fromJson(json["reasonsList"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "reasonsTotal": reasonsTotal,
        "actualPage": actualPage,
        "lastPage": lastPage,
        "reazonList": List<dynamic>.from(reasonsList.map((x) => x.toJson())),
        // "reasonsList": reasonsList.toJson(),
      };
}
