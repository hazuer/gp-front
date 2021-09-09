import 'package:general_products_web/models/catalogs/razon/catRazonModel.dart';
 /*
 * Clase que define los atributos de la tabla del listado de razones
 */

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
            json["reasonsList"].map((x) => RazonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "reasonsTotal": reasonsTotal,
        "actualPage": actualPage,
        "lastPage": lastPage,
        "reazonList": List<dynamic>.from(reasonsList.map((x) => x.toJson())),
      };
}
