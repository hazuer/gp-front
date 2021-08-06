
import 'dart:convert';

Plant plantFromJson(String str) => Plant.fromJson(json.decode(str));

String plantToJson(Plant data) => json.encode(data.toJson());

class Plant {
    Plant({
        this.idCatPlanta,
        this.nombrePlanta,
    });

    int? idCatPlanta;
    String? nombrePlanta;

    factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        idCatPlanta: json["id_cat_planta"],
        nombrePlanta: json["nombre_planta"],
    );

    Map<String, dynamic> toJson() => {
        "id_cat_planta": idCatPlanta,
        "nombre_planta": nombrePlanta,
    };
}
