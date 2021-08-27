/*
Clase para la definición de los atributos de la entidad de Pais
*/
class CatPaisModel {
    CatPaisModel({
      this.idCatPais,
      this.nombrePais,
    });

    int    ? idCatPais;
    String ? nombrePais;

    factory CatPaisModel.fromJson(Map<String, dynamic> json) => CatPaisModel(
      idCatPais : json["id_cat_pais"],
      nombrePais: json["nombre_pais"],
  );

    Map<String, dynamic> toJson() => {
        "id_cat_pais": idCatPais,
        "nombre_pais": nombrePais,
    };
}
