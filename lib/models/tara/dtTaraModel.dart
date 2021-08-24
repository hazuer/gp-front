 import 'package:general_products_web/models/tara/taraModel.dart';
 /*
 * Clase que define el objeto del Datatable del listado de taras
 */
class DtTaraModel {
  DtTaraModel({
    this.result,
    this.tarasTotal,
    this.actualPage,
    this.lastPage,
    required this.tarassList,
  });

  bool? result;
  int? tarasTotal;
  int? actualPage;
  int? lastPage;
  List<TaraModel> tarassList;

  factory DtTaraModel.fromJson(Map<String, dynamic> json) => DtTaraModel(
    result    : json["result"],
    tarasTotal: json["tarasTotal"],
    actualPage: json["actualPage"],
    lastPage  : json["lastPage"],
    tarassList: List<TaraModel>.from(json["tarassList"].map((x) => TaraModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result"    : result,
    "tarasTotal": tarasTotal,
    "actualPage": actualPage,
    "lastPage"  : lastPage,
    "tarassList": List<dynamic>.from(tarassList.map((x) => x.toJson())),
  };
}
