/*
Clase para la definición de los atributos de la entidad de Tara
*/
class CatTaraModel {
  CatTaraModel({
    this.idCatTara,
    this.nombreTara,
    this.capacidad,
    this.estatus,
    this.nombrePlanta,
    this.idCatEstatus,
    this.idCatPlanta,
  });

  int? idCatTara;
  String? nombreTara;
  String? capacidad;
  String? estatus;
  String? nombrePlanta;
  int? idCatEstatus;
  int? idCatPlanta;

  factory CatTaraModel.fromJson(Map<String, dynamic> json) => CatTaraModel(
        idCatTara: json["id_cat_tara"],
        nombreTara: json["nombre_tara"],
        capacidad:
            json["capacidad"] == "" ? null : json["capacidad"].toString(),
        estatus: json["estatus"],
        nombrePlanta: json["nombre_planta"],
        idCatEstatus: json["id_cat_estatus"],
        idCatPlanta: json["id_cat_planta"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_tara": idCatTara,
        "nombre_tara": nombreTara,
        "capacidad": capacidad == null ? "" : capacidad,
        "estatus": estatus,
        "nombre_planta": nombrePlanta,
        "id_cat_estatus": idCatEstatus,
        "id_cat_planta": idCatPlanta,
      };
}
