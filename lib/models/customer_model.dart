import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
    Customer({
        this.idCatCliente,
        this.nombreCliente,
    });

    int? idCatCliente;
    String? nombreCliente;

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        idCatCliente: json["id_cat_cliente"],
        nombreCliente: json["nombre_cliente"],
    );

    Map<String, dynamic> toJson() => {
        "id_cat_cliente": idCatCliente,
        "nombre_cliente": nombreCliente,
    };
}
