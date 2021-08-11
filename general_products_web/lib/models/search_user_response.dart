// To parse this JSON data, do
//
//     final searchUserResponse = searchUserResponseFromJson(jsonString);

import 'dart:convert';

import 'package:general_products_web/models/customer_model.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/models/profile_model.dart';
import 'package:general_products_web/models/status_model.dart';

SearchUserResponse searchUserResponseFromJson(String str) => SearchUserResponse.fromJson(json.decode(str));

String searchUserResponseToJson(SearchUserResponse data) => json.encode(data.toJson());

class SearchUserResponse {
    SearchUserResponse({
        this.result,
         this.user,
        this.listCustomers,
        this.listPlants,
        this.listProfiles,
        this.listStatus,
    });

    bool? result;
    User? user;
    List<Customer>? listCustomers;
    List<Plant>? listPlants;
    List<ProfileModel>? listProfiles;
    List<StatusModel>? listStatus;

    factory SearchUserResponse.fromJson(Map<String, dynamic> json) => SearchUserResponse(
        result: json["result"],
        user: User.fromJson(json["user"]),
        listCustomers: List<Customer>.from(json["listCustomers"].map((x) => Customer.fromJson(x))),
        listPlants: List<Plant>.from(json["listPlants"].map((x) => Plant.fromJson(x))),
        listProfiles: List<ProfileModel>.from(json["listProfiles"].map((x) => ProfileModel.fromJson(x))),
        listStatus: List<StatusModel>.from(json["listStatus"].map((x) => StatusModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "user": user!.toJson(),
        "listCustomers": List<Customer>.from(listCustomers!.map((x) => x.toJson())),
        "listPlants": List<Plant>.from(listPlants!.map((x) => x.toJson())),
        "listProfiles": List<ProfileModel>.from(listProfiles!.map((x) => x.toJson())),
        "listStatus": List<StatusModel>.from(listStatus!.map((x) => x.toJson())),
    };
}




class User {
    User({
        this.idDatoUsuario,
        this.correo,
        this.nombre,
        this.apellidoPaterno,
        this.apellidoMaterno,
        this.idCatPerfil,
        this.idCatCliente,
        this.idCatPlanta,
        this.idCatEstatus,
    });

    int? idDatoUsuario;
    String? correo;
    String? nombre;
    String? apellidoPaterno;
    String? apellidoMaterno;
    int? idCatPerfil;
    int? idCatCliente;
    int? idCatPlanta;
    int? idCatEstatus;

    factory User.fromJson(Map<String, dynamic> json) => User(
        idDatoUsuario: json["id_dato_usuario"],
        correo: json["correo"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellido_paterno"],
        apellidoMaterno: json["apellido_materno"],
        idCatPerfil: json["id_cat_perfil"],
        idCatCliente: json["id_cat_cliente"],
        idCatPlanta: json["id_cat_planta"],
        idCatEstatus: json["id_cat_estatus"],
    );

    Map<String, dynamic> toJson() => {
        "id_dato_usuario": idDatoUsuario,
        "correo": correo,
        "nombre": nombre,
        "apellido_paterno": apellidoPaterno,
        "apellido_materno": apellidoMaterno,
        "id_cat_perfil": idCatPerfil,
        "id_cat_cliente": idCatCliente,
        "id_cat_planta": idCatPlanta,
        "id_cat_estatus": idCatEstatus,
    };
}
