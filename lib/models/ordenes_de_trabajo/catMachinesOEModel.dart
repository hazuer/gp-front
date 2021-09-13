class CatMachinesOEModel {
  CatMachinesOEModel({
    this.idCatMaquina,
    this.nombreMaquina,
  });

  int? idCatMaquina;
  String? nombreMaquina;

  factory CatMachinesOEModel.fromJson(Map<String, dynamic> json) =>
      CatMachinesOEModel(
        idCatMaquina: json["id_cat_maquina"],
        nombreMaquina: json["nombre_maquina"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_maquina": idCatMaquina,
        "nombre_maquina": nombreMaquina,
      };
}
