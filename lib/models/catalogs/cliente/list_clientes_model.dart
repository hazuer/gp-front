class ListClientesModel {
  ListClientesModel({
    this.result,
    this.customersTotal,
    this.actualPage,
    this.lastPage,
    required this.customersList,
  });

  bool? result;
  int? customersTotal;
  int? actualPage;
  int? lastPage;
  List<CustomersList> customersList;

  factory ListClientesModel.fromJson(Map<String, dynamic> json) =>
      ListClientesModel(
        result: json["result"],
        customersTotal: json["customersTotal"],
        actualPage: json["actualPage"],
        lastPage: json["lastPage"],
        customersList: List<CustomersList>.from(
            json["customersList"].map((x) => CustomersList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "customersTotal": customersTotal,
        "actualPage": actualPage,
        "lastPage": lastPage,
        "customersList":
            List<dynamic>.from(customersList.map((e) => e.toJson())),
      };
}

class CustomersList {
  CustomersList({
    this.idCatCliente,
    this.nombreCliente,
    this.nombrePlanta,
    this.estatus,
    this.idCatEstatus,
    this.idCatPlanta,
  });

  int? idCatCliente;
  String? nombreCliente;
  String? nombrePlanta;
  String? estatus;
  int? idCatEstatus;
  int? idCatPlanta;

  factory CustomersList.fromJson(Map<String, dynamic> json) => CustomersList(
        idCatCliente: json["id_cat_cliente"],
        nombreCliente: json["nombre_cliente"],
        nombrePlanta: json["nombre_planta"],
        estatus: json["estatus"],
        idCatEstatus: json["id_cat_estatus"],
        idCatPlanta: json["id_cat_planta"],
      );

  Map<String, dynamic> toJson() => {
        "id_cat_cliente": idCatCliente,
        "nombre_cliente": nombreCliente,
        "nombre_planta": nombrePlanta,
        "estatus": estatus,
        "id_cat_estatus": idCatEstatus,
        "id_cat_planta": idCatPlanta,
      };
}
