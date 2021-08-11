// To parse this JSON data, do
//
//     final listUsersModel = listUsersModelFromJson(jsonString);

import 'dart:convert';

ListUsersModel listUsersModelFromJson(String str) => ListUsersModel.fromJson(json.decode(str));

String listUsersModelToJson(ListUsersModel data) => json.encode(data.toJson());

class ListUsersModel {
    ListUsersModel({
        this.result,
        this.usersTotal,
        this.actualPage,
        this.lastPage,
        required this.userList,
    });

    bool? result;
    int? usersTotal;
    int? actualPage;
    int? lastPage;
    List<UserList> userList;

    factory ListUsersModel.fromJson(Map<String, dynamic> json) => ListUsersModel(
        result: json["result"],
        usersTotal: json["usersTotal"],
        actualPage: json["actualPage"],
        lastPage: json["lastPage"],
        userList: List<UserList>.from(json["userList"].map((x) => UserList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "usersTotal": usersTotal,
        "actualPage": actualPage,
        "lastPage": lastPage,
        "userList": List<dynamic>.from(userList.map((x) => x.toJson())),
    };
}

class UserList {
    UserList({
        this.idDatoUsuario,
        this.nombre,
        this.apellidoPaterno,
        this.apellidoMaterno,
        this.estatus,
        this.perfil,
        this.nombrePlanta,
        this.nombreCliente,
    });

    int? idDatoUsuario;
    String? nombre;
    String? apellidoPaterno;
    String? apellidoMaterno;
    String? estatus;
    String? perfil;
    String? nombrePlanta;
    String? nombreCliente;

    factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        idDatoUsuario: json["id_dato_usuario"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellido_paterno"],
        apellidoMaterno: json["apellido_materno"] == null ? null : json["apellido_materno"],
        estatus: json["estatus"],
        perfil: json["perfil"] == null ? null : json["perfil"],
        nombrePlanta: json["nombre_planta"],
        nombreCliente: json["nombre_cliente"],
    );

    Map<String, dynamic> toJson() => {
        "id_dato_usuario": idDatoUsuario,
        "nombre": nombre,
        "apellido_paterno": apellidoPaterno,
        "apellido_materno": apellidoMaterno == null ? null : apellidoMaterno,
        "estatus": estatus == null ? null : estatus,
        "perfil": perfil == null ? null : perfil,
        "nombre_planta": nombrePlanta,
        "nombre_cliente": nombreCliente,
    };
}




