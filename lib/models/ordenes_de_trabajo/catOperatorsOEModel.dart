class CatOperatorsOEModel {
  CatOperatorsOEModel({
    this.idUsuario,
    this.nombreOperadorResponsable,
  });

  int? idUsuario;
  String? nombreOperadorResponsable;

  factory CatOperatorsOEModel.fromJson(Map<String, dynamic> json) =>
      CatOperatorsOEModel(
        idUsuario: json["id_usuario"],
        nombreOperadorResponsable: json["nombre_operador_responsable"],
      );

  Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "nombre_operador_responsable": nombreOperadorResponsable,
      };
}
