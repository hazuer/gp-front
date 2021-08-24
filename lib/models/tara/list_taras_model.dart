// To parse this JSON data, do
//
//     final listUsersModel = listUsersModelFromJson(jsonString);

import 'dart:convert';

ListTarasModel listTarasModelFromJson(String str) => ListTarasModel.fromJson(json.decode(str));

String listTarasModelToJson(ListTarasModel data) => json.encode(data.toJson());

class ListTarasModel {
    ListTarasModel({
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
    List<TaraList> tarassList;

    factory ListTarasModel.fromJson(Map<String, dynamic> json) => ListTarasModel(
        result: json["result"],
        tarasTotal: json["tarasTotal"],
        actualPage: json["actualPage"],
        lastPage: json["lastPage"],
        tarassList: List<TaraList>.from(json["tarassList"].map((x) => TaraList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "tarasTotal": tarasTotal,
        "actualPage": actualPage,
        "lastPage": lastPage,
        "tarassList": List<dynamic>.from(tarassList.map((x) => x.toJson())),
    };
}

class TaraList {
    TaraList({
        this.idCatTara,
        this.nombreTara,
        this.capacidad,
        this.estatus,
        this.nombrePlanta,
    });

    int? idCatTara;
    String? nombreTara;
    String? capacidad;
    String? estatus;
    String? nombrePlanta;

    factory TaraList.fromJson(Map<String, dynamic> json) => TaraList(
        idCatTara: json["id_cat_tara"],
        nombreTara: json["nombre_tara"],
        capacidad: json["capacidad"] == "" ? null : json["capacidad"].toString(),
        estatus: json["estatus"],
        nombrePlanta: json["nombre_planta"],
    );

    Map<String, dynamic> toJson() => {
        "id_cat_tara": idCatTara,
        "nombre_tara": nombreTara,
        "capacidad": capacidad == null ? "" : capacidad,
        "estatus": estatus == null ? "" : estatus,
        "nombre_planta": nombrePlanta,
    };
}




