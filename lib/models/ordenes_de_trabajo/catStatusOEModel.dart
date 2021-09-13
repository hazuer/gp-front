class CatStatusOEModel {
  CatStatusOEModel({
    this.idCatEstatusOt,
    this.estatusOt,
  });

  int? idCatEstatusOt;
  String? estatusOt;

  factory CatStatusOEModel.fromJson(Map<String, dynamic> json) =>
      CatStatusOEModel(
        idCatEstatusOt: json["id_cat_estatus_ot"],
        estatusOt: json["estatus_ot"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_estatus_ot": idCatEstatusOt,
        "estatus_ot": estatusOt,
      };
}
