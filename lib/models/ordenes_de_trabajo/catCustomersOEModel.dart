class CatCustomersOEModel {
  CatCustomersOEModel({
    // this.idCatCliente,
    this.customerName,
  });

  // int? idCatCliente;
  String? customerName;

  factory CatCustomersOEModel.fromJson(Map<String, dynamic> json) =>
      CatCustomersOEModel(
        // idCatCliente: json["id_cat_cliente"],
        customerName: json["nombre_cliente"],
      );

  Map<String, dynamic> toJson() => {
        // "id_cat_cliente": idCatCliente,
        "nombre_cliente": customerName,
      };
}
