 import 'package:general_products_web/models/catalogs/plant/catPlantModel.dart';
 /*
 * Clase que define los atributos de la tabla cat_plant
 */
class DtPlantModel {
  DtPlantModel({
    this.result,
    this.plantsTotal,
    this.actualPage,
    this.lastPage,
    required this.plantsList,
  });

  bool? result;
  int? plantsTotal;
  int? actualPage;
  int? lastPage;
  List<CatPlantModel> plantsList;

  factory DtPlantModel.fromJson(Map<String, dynamic> json) => DtPlantModel(
    result     : json["result"],
    plantsTotal: json["plantsTotal"],
    actualPage : json["actualPage"],
    lastPage   : json["lastPage"],
    plantsList: List<CatPlantModel>.from(json["plantsList"].map((x) => CatPlantModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result"     : result,
    "plantsTotal": plantsTotal,
    "actualPage" : actualPage,
    "lastPage"   : lastPage,
    "plantsList" : List<dynamic>.from(plantsList.map((x) => x.toJson())),
  };
}
