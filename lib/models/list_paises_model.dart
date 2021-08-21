// To parse this JSON data, do
//
//     final listPaisesModel = listPaisesModelFromJson(jsonString);

import 'dart:convert';

ListPaisesModel listPaisesModelFromJson(String str) =>
    ListPaisesModel.fromJson(json.decode(str));

String listPaisesModelToJson(ListPaisesModel data) =>
    json.encode(data.toJson());

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
        // countriesList: List<CountriesList>.from(json["countriesList"]),
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

class CountriesList {
  CountriesList({
    this.idCatPais,
    this.nombrePais,
    this.estatus,
  });

  int? idCatPais;
  String? nombrePais;
  String? estatus;

  factory CountriesList.fromJson(Map<String, dynamic> json) => CountriesList(
        idCatPais: json["id_cat_pais"],
        nombrePais: json["nombre_pais"],
        estatus: json["estatus"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_pais": idCatPais,
        "nombre_pais": nombrePais,
        "estatus": estatus,
      };
}


// // To parse this JSON data, do
// //
// //     final paisesList = paisesListFromJson(jsonString);

// import 'dart:convert';

// ListPaisesModel listPaisesModelFromJson(String str) =>
//     ListPaisesModel.fromJson(json.decode(str));

// String listPaisesModelToJson(ListPaisesModel data) =>
//     json.encode(data.toJson());

// class ListPaisesModel {
//   ListPaisesModel({
//     this.result,
//     this.countriesTotal,
//     this.actualPage,
//     this.lastPage,
//     required this.countriesList,
//   });

//   bool? result;
//   int? countriesTotal;
//   int? actualPage;
//   int? lastPage;
//   List<PaisesList> countriesList;

//   factory ListPaisesModel.fromJson(Map<String, dynamic> json) =>
//       ListPaisesModel(
//         result: json["result"],
//         countriesTotal: json["countriesTotal"],
//         actualPage: json["actualPage"],
//         lastPage: json["lastPage"],
//         countriesList: List<PaisesList>.from(
//             json["paisesList"].map((x) => PaisesList.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "result": result,
//         "countriesTotal": countriesTotal,
//         "actualPage": actualPage,
//         "lastPage": lastPage,
//         "userList": List<dynamic>.from(countriesList.map((x) => x.toJson())),
//       };
// }

// class PaisesList {
//   PaisesList({
//     required this.idCatPais,
//     required this.nombrePais,
//     required this.estatus,
//   });

//   int idCatPais;
//   String nombrePais;
//   String estatus;

//   factory PaisesList.fromRawJson(String str) =>
//       PaisesList.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory PaisesList.fromJson(Map<String, dynamic> json) => PaisesList(
//         idCatPais: json["id_cat_pais"],
//         nombrePais: json["nombre_pais"],
//         estatus: json["estatus"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id_cat_pais": idCatPais,
//         "nombre_pais": nombrePais,
//         "estatus": estatus,
//       };
// }
