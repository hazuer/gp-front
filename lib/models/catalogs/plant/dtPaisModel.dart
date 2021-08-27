 import 'package:general_products_web/models/catalogs/plant/catPaisModel.dart';
 /*
 * Clase que define los atributos de la tabla cat de paises
 */
class DtPaisModel {
  DtPaisModel({
    this.result,
    required this.listCountries,
  });

  bool? result;
  List<CatPaisModel> listCountries;

  factory DtPaisModel.fromJson(Map<String, dynamic> json) => DtPaisModel(
    result       : json["result"],
    listCountries: List<CatPaisModel>.from(json["listCountries"].map((x) => CatPaisModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result"     : result,
    "listCountries" : List<dynamic>.from(listCountries.map((x) => x.toJson())),
  };
}
