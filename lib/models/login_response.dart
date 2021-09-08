// To parse this JSON data, do
//
//     final loginReponse = loginReponseFromJson(jsonString);

import 'dart:convert';

import 'package:general_products_web/models/customer_model.dart';
// import 'package:general_products_web/models/plant_model.dart';

LoginResponse loginReponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginReponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.result,
    this.data,
    this.message,
  });

  bool? result;
  Data? data;
  String? message;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        result: json["result"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": data!.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.token,
    this.user,
    this.catPlant,
    this.catProfile,
    this.catCustomer,
  });

  String? token;
  User? user;
  CatPlant? catPlant;
  CatProfile? catProfile;
  Customer? catCustomer;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromJson(json["user"]),
        catPlant: CatPlant.fromJson(json["catPlant"]),
        catProfile: CatProfile.fromJson(json["catProfile"]),
        catCustomer: Customer.fromJson(json["catCustomer"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user!.toJson(),
        "catPlant": catPlant!.toJson(),
        "catProfile": catProfile!.toJson(),
        "catCustomer": catCustomer!.toJson(),
      };
}

class CatProfile {
  CatProfile({
    this.profileId,
    this.nameProfile,
  });

  int? profileId;
  String? nameProfile;

  factory CatProfile.fromJson(Map<String, dynamic> json) => CatProfile(
        profileId: json["profileId"],
        nameProfile: json["nameProfile"],
      );

  Map<String, dynamic> toJson() => {
        "profileId": profileId,
        "nameProfile": nameProfile,
      };
}

class CatPlant {
  CatPlant({
    this.plantId,
    this.plantName,
  });

  int? plantId;
  String? plantName;

  factory CatPlant.fromJson(Map<String, dynamic> json) => CatPlant(
        plantId: json["plantId"],
        plantName: json["plantName"],
      );

  Map<String, dynamic> toJson() => {
        "plantId": plantId,
        "plantName": plantName,
      };
}

class User {
  User({
    this.userId,
    this.name,
    this.lastName,
    this.secondaryLastName,
  });

  int? userId;
  String? name;
  String? lastName;
  String? secondaryLastName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        name: json["name"],
        lastName: json["last_name"],
        secondaryLastName: json["secondary_last_name"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "last_name": lastName,
        "secondary_last_name": secondaryLastName,
      };
}
