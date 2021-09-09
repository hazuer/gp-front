/*
Clase para la definición de los atributos de la entidad de pais
*/
class CountriesList {
  CountriesList({
    this.idCatPais,
    this.nombrePais,
    this.estatus,
  });

  int? idCatPais;
  String? nombrePais;
  String? estatus;

  factory CountriesList.fromJson(Map<String, dynamic> json) => CountriesList(
        idCatPais: json["id_cat_pais"],
        nombrePais: json["nombre_pais"],
        estatus: json["estatus"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_pais": idCatPais,
        "nombre_pais": nombrePais,
        "estatus": estatus,
      };
}
