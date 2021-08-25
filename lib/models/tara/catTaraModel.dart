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
  });

  int    ? idCatTara;
  String ? nombreTara;
  String ? capacidad;
  String ? estatus;
  String ? nombrePlanta;

  factory CatTaraModel.fromJson(Map<String, dynamic> json) => CatTaraModel(
    idCatTara   : json["id_cat_tara"],
    nombreTara  : json["nombre_tara"],
    capacidad   : json["capacidad"] == "" ? null: json["capacidad"].toString(),
    estatus     : json["estatus"],
    nombrePlanta: json["nombre_planta"],
  );

  Map<String, dynamic> toJson() => {
    "id_cat_tara"  : idCatTara,
    "nombre_tara"  : nombreTara,
    "capacidad"    : capacidad == null ? "": capacidad,
    "estatus"      : estatus,
    "nombre_planta": nombrePlanta,
  };
}