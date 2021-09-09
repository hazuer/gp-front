import 'package:general_products_web/models/catalogs/tinta/catTintasModel.dart';
 /*
 * Clase que define los atributos de la tabla del listado de tintas
 */

class ListTintasModel {
  ListTintasModel({
    this.result,
    this.inksTotal,
    this.actualPage,
    this.lastPage,
    required this.inkList,
  });

  bool? result;
  int? inksTotal;
  int? actualPage;
  int? lastPage;
  List<InkList> inkList;

  factory ListTintasModel.fromJson(Map<String, dynamic> json) =>
      ListTintasModel(
        result: json["result"],
        inksTotal: json["inksTotal"],
        actualPage: json["actualPage"],
        lastPage: json["lastPage"],
        inkList:
            List<InkList>.from(json["inkList"].map((x) => InkList.fromJson(x))),
        // inkList: InkList.fromJson(json["inkList"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "inksTotal": inksTotal,
        "actualPage": actualPage,
        "lastPage": lastPage,
        "inkList": List<dynamic>.from(inkList.map((e) => e.toJson())),
        // "inkList": inkList.toJson(),
      };
}