
/*
Clase para la definición de los atributos de la entidad de tintas
*/
class InkList {
  InkList({
    this.idCatTinta,
    this.nombreTinta,
    this.codigoCliente,
    this.codigoGp,
    this.nombrePlanta,
    this.estatus,
  });

  int? idCatTinta;
  String? nombreTinta;
  String? codigoCliente;
  String? codigoGp;
  String? nombrePlanta;
  String? estatus;

  factory InkList.fromJson(Map<String, dynamic> json) => InkList(
        idCatTinta: json["id_cat_tinta"],
        nombreTinta: json["nombre_tinta"],
        codigoCliente: json["codigo_cliente"],
        codigoGp: json["codigo_gp"],
        nombrePlanta: json["nombre_planta"],
        estatus: json["estatus"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_tinta": idCatTinta,
        "nombre_tinta": nombreTinta,
        "codigo_cliente": codigoCliente,
        "codigo_gp": codigoGp,
        "nombre_planta": nombrePlanta,
        "estatus": estatus,
      };
}
