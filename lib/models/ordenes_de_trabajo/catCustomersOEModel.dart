class CatCustomersOEModel {
  CatCustomersOEModel({
    this.idCatCliente,
    this.nombreCliente,
  });

  int? idCatCliente;
  String? nombreCliente;

  factory CatCustomersOEModel.fromJson(Map<String, dynamic> json) => CatCustomersOEModel(
        idCatCliente: json["id_cat_cliente"],
        nombreCliente: json["nombre_cliente"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_cliente": idCatCliente,
        "nombre_cliente": nombreCliente,
      };
}