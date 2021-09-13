class CatDesignsOEModel {
  CatDesignsOEModel({
    this.idCatDiseno,
    this.nombreDiseno,
  });

  int? idCatDiseno;
  String? nombreDiseno;

  factory CatDesignsOEModel.fromJson(Map<String, dynamic> json) =>
      CatDesignsOEModel(
        idCatDiseno: json["id_cat_diseno"],
        nombreDiseno: json["nombre_diseno"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_diseno": idCatDiseno,
        "nombre_diseno": nombreDiseno,
      };
}
