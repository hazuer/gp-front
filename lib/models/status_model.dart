class StatusModel {
    StatusModel({
        this.idCatEstatus,
        this.estatus,
    });

    int? idCatEstatus;
    String? estatus;

    factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        idCatEstatus: json["id_cat_estatus"],
        estatus: json["estatus"],
    );

    Map<String, dynamic> toJson() => {
        "id_cat_estatus": idCatEstatus,
        "estatus": estatus,
    };
}