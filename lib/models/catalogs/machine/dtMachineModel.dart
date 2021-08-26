 import 'package:general_products_web/models/catalogs/machine/catMachineModel.dart';
 /*
 * Clase que define los atributos de la tabla cat_maquina
 */
class DtMachineModel {
  DtMachineModel({
    this.result,
    this.machinesTotal,
    this.actualPage,
    this.lastPage,
    required this.machinesList,
  });

  bool? result;
  int? machinesTotal;
  int? actualPage;
  int? lastPage;
  List<CatMachineModel> machinesList;

  factory DtMachineModel.fromJson(Map<String, dynamic> json) => DtMachineModel(
    result       : json["result"],
    machinesTotal: json["machinesTotal"],
    actualPage   : json["actualPage"],
    lastPage     : json["lastPage"],
    machinesList : List<CatMachineModel>.from(json["machinesList"].map((x) => CatMachineModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result"       : result,
    "machinesTotal": machinesTotal,
    "actualPage"   : actualPage,
    "lastPage"     : lastPage,
    "machinesList" : List<dynamic>.from(machinesList.map((x) => x.toJson())),
  };
}
