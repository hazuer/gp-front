 import 'package:general_products_web/models/catalogs/tara/catTaraModel.dart';
 /*
 * Clase que define los atributos de la tabla cat_tara
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
  List<CatTaraModel> tarassList;

  factory DtTaraModel.fromJson(Map<String, dynamic> json) => DtTaraModel(
    result    : json["result"],
    tarasTotal: json["tarasTotal"],
    actualPage: json["actualPage"],
    lastPage  : json["lastPage"],
    tarassList: List<CatTaraModel>.from(json["tarassList"].map((x) => CatTaraModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result"    : result,
    "tarasTotal": tarasTotal,
    "actualPage": actualPage,
    "lastPage"  : lastPage,
    "tarassList": List<dynamic>.from(tarassList.map((x) => x.toJson())),
  };
}
