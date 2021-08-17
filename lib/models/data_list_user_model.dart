// To parse this JSON data, do
//
//     final dataListUserModel = dataListUserModelFromJson(jsonString);

import 'dart:convert';

import 'package:general_products_web/models/customer_model.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/models/profile_model.dart';
import 'package:general_products_web/models/status_model.dart';

//@JsonProperty(ignoreIfNull: true)

DataListUserModel dataListUserModelFromJson(String str) => DataListUserModel.fromJson(json.decode(str));

String dataListUserModelToJson(DataListUserModel data) => json.encode(data.toJson());

class DataListUserModel {
    DataListUserModel({
        this.result,
        this.listCustomers,
        this.listPlants,
        this.listProfiles,
        this.listStatus,
    });

    bool? result;
    List<Customer>? listCustomers;
    List<Plant>? listPlants;
    List<ProfileModel>? listProfiles;
    List<StatusModel>? listStatus;

    factory DataListUserModel.fromJson(Map<String, dynamic> json) => DataListUserModel(
        result: json["result"],
        listCustomers: List<Customer>.from(json["listCustomers"].map((x) => Customer.fromJson(x))),
        listPlants: List<Plant>.from(json["listPlants"].map((x) => Plant.fromJson(x))),
        listProfiles: List<ProfileModel>.from(json["listProfiles"].map((x) => ProfileModel.fromJson(x))),
        listStatus: List<StatusModel>.from(json["listStatus"].map((x) => StatusModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "listCustomers": List<Customer>.from(listCustomers!.map((x) => x.toJson())),
        "listPlants": List<Plant>.from(listPlants!.map((x) => x.toJson())),
        "listProfiles": List<ProfileModel>.from(listProfiles!.map((x) => x.toJson())),
        "listStatus": List<StatusModel>.from(listStatus!.map((x) => x.toJson())),
    };
}




