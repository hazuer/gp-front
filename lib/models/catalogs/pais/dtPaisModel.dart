import 'package:general_products_web/models/catalogs/pais/catPaisesModel.dart';
 /*
 * Clase que define los atributos de la tabla del listado de paises
 */
class ListPaisesModel {
  ListPaisesModel({
    this.result,
    this.countriesTotal,
    this.actualPage,
    this.lastPage,
    required this.countriesList,
  });

  bool? result;
  int? countriesTotal;
  int? actualPage;
  int? lastPage;
  List<CountriesList> countriesList;

  factory ListPaisesModel.fromJson(Map<String, dynamic> json) =>
      ListPaisesModel(
        result: json["result"],
        countriesTotal: json["countriesTotal"],
        actualPage: json["actualPage"],
        lastPage: json["lastPage"],
        countriesList: List<CountriesList>.from(
            json["countriesList"].map((x) => CountriesList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "countriesTotal": countriesTotal,
        "actualPage": actualPage,
        "lastPage": lastPage,
        "countriesList":
            List<dynamic>.from(countriesList.map((e) => e.toJson())),
      };
}