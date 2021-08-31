import 'package:dio/dio.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/provider/routes_provider.dart';
import 'package:general_products_web/models/catalogs/machine/catMachineModel.dart';
import 'package:general_products_web/models/catalogs/machine/dtMachineModel.dart';

class MachinesProvider {
  RoutesProvider routes = RoutesProvider();
  final Options headerWithToken = new Options(headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Requested-With': "XMLHttpRequest",
    "Authorization": "Bearer ${RxVariables.token}"
  });

  //Listar todas las maquinas activas
  Future getAllMachines() async {
    List<CatMachineModel> provListMachines = [];
    RxVariables.errorMessage = "";
    DtMachineModel provDtMachine = DtMachineModel(machinesList: []);
    String url = routes.urlBase + routes.listarMachines + '?porPagina=100';

    try {
      final dio = Dio();
      final result = await dio.get(url, options: headerWithToken);
      provDtMachine = DtMachineModel.fromJson(result.data);
      RxVariables.gvListMachines = provDtMachine;
      provDtMachine.machinesList.forEach((item) {
        if (item.estatus!.toLowerCase() == "activo") {
          provListMachines.add(item);
        }
      });
      rxVariables.gvBeSubListMachines.sink.add(provListMachines);
      return result.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.gvBeSubListMachines.sink.addError(
          "Ocurrio un error, intenta más tarde " + RxVariables.errorMessage);
      return null;
    }
  }

  //Filtrar maquinas sin importar el estatus
  Future headerFilterMachine(String path) async {
    List<CatMachineModel> provListMachines = [];
    RxVariables.errorMessage = '';
    DtMachineModel provDtMachine = DtMachineModel(machinesList: []);
    String url = routes.urlBase + routes.listarMachines + path;

    try {
      final dio = Dio();
      final result = await dio.get(url, options: headerWithToken);
      provDtMachine = DtMachineModel.fromJson(result.data);
      RxVariables.gvListMachines = provDtMachine;
      provDtMachine.machinesList.forEach((element) {
        //if(element.estatus!.toLowerCase() == "activo"){
        provListMachines.add(element);
        //}
      });
      rxVariables.gvBeSubListMachines.sink.add(provListMachines);
      return result.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      return null;
    }
  }

  Future changeStatusMachineProvider(int idCatMaquina, int idCatStatus) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.changeEstatusMachines;

    try {
      final dio = Dio();
      final data = {
        'id_cat_maquina': idCatMaquina,
        'id_cat_estatus': idCatStatus
      };
      final resp = await dio.post(url, data: data, options: headerWithToken);
      await getAllMachines();
      RxVariables.errorMessage = resp.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      return null;
    }
  }

  Future createMachine(
      String nombreMaquina, String modelo, int idCatPlanta) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.crearMachines;
    try {
      final dio = Dio();
      final data = {
        'nombre_maquina': nombreMaquina,
        'modelo': modelo,
        'id_cat_planta': idCatPlanta
      };
      final resp = await dio.post(url, data: data, options: headerWithToken);
      await getAllMachines();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.gvBeSubListMachines.sink.addError(
          "Ocurrio un error, intenta más tarde " + RxVariables.errorMessage);
      return null;
    }
  }

  Future editMachine(int idCatMaquina, String nombreMaquina, String modelo,
      int idPlanta) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.editarMachines;

    try {
      final dio = Dio();
      final data = {
        'id_cat_maquina': idCatMaquina,
        'nombre_maquina': nombreMaquina,
        'modelo': modelo,
        'id_cat_planta': idPlanta
      };

      final resp = await dio.post(url, data: data, options: headerWithToken);
      await getAllMachines();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.gvBeSubListMachines.sink.addError(
          "Ocurrio un error, intenta más tarde " + RxVariables.errorMessage);
      return null;
    }
  }
}
