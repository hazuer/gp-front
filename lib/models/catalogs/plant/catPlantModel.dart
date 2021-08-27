/*
Clase para la definición de los atributos de la entidad de Planta
*/
class CatPlantModel {
  CatPlantModel({
    this.idCatPlanta,
    this.nombrePlanta,
    this.estatus,
    this.idCatEstatus,
    this.nombrePais,
    this.idCatPais,
  });

  int    ? idCatPlanta;
  String ? nombrePlanta;
  String ? estatus;
  int    ? idCatEstatus;
  String ? nombrePais;
  int    ? idCatPais;

  factory CatPlantModel.fromJson(Map<String, dynamic> json) => CatPlantModel(
    idCatPlanta : json["id_cat_planta"],
    nombrePlanta: json["nombre_planta"],
    estatus     : json["estatus"],
    nombrePais  : json["nombre_pais"],
  );

  Map<String, dynamic> toJson() => {
    "id_cat_planta" : idCatPlanta,
    "nombre_planta" : nombrePlanta,
    "estatus"       : estatus,
    "id_cat_estatus": idCatEstatus,
    "nombre_pais"   : nombrePais,
    "id_cat_pais"   : idCatPais,
  };
}