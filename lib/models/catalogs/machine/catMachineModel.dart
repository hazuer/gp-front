/*
Clase para la definición de los atributos de la entidad de Maquina
*/
class CatMachineModel {
  CatMachineModel({
    this.idCatMaquina,
    this.nombreMaquina,
    this.modelo,
    this.estatus,
    this.nombrePlanta,
  });

  int    ? idCatMaquina;
  String ? nombreMaquina;
  String ? modelo;
  String ? estatus;
  String ? nombrePlanta;

  factory CatMachineModel.fromJson(Map<String, dynamic> json) => CatMachineModel(
    idCatMaquina : json["id_cat_maquina"],
    nombreMaquina: json["nombre_maquina"],
    modelo       : json["modelo"] == "" ? null: json["modelo"].toString(),
    nombrePlanta : json["nombre_planta"],
    estatus      : json["estatus"],
  );

  Map<String, dynamic> toJson() => {
    "id_cat_maquina": idCatMaquina,
    "nombre_maquina": nombreMaquina,
    "modelo"        : modelo == null ? "": modelo,
    "estatus"       : estatus,
    "nombre_planta" : nombrePlanta,
  };
}