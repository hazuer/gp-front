class ProfileModel {
    ProfileModel({
        this.idCatPerfil,
        this.perfil,
    });

    int? idCatPerfil;
    String? perfil;

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        idCatPerfil: json["id_cat_perfil"],
        perfil: json["perfil"],
    );

    Map<String, dynamic> toJson() => {
        "id_cat_perfil": idCatPerfil,
        "perfil": perfil,
    };
}