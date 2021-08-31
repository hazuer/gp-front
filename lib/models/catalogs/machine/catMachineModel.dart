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
    this.idCatEstatus,
    this.idCatPlanta,
  });

  int? idCatMaquina;
  String? nombreMaquina;
  String? modelo;
  String? estatus;
  String? nombrePlanta;
  int? idCatEstatus;
  int? idCatPlanta;

  factory CatMachineModel.fromJson(Map<String, dynamic> json) =>
      CatMachineModel(
        idCatMaquina: json["id_cat_maquina"],
        nombreMaquina: json["nombre_maquina"],
        modelo: json["modelo"] == "" ? null : json["modelo"].toString(),
        nombrePlanta: json["nombre_planta"],
        estatus: json["estatus"],
        idCatEstatus: json["id_cat_estatus"],
        idCatPlanta: json["id_cat_planta"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_maquina": idCatMaquina,
        "nombre_maquina": nombreMaquina,
        "modelo": modelo == null ? "" : modelo,
        "estatus": estatus,
        "nombre_planta": nombrePlanta,
        "id_cat_estatus": idCatEstatus,
        "id_cat_planta": idCatPlanta,
      };
}
