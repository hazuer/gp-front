import 'package:dio/dio.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/provider/routes_provider.dart';
import 'package:general_products_web/models/catalogs/plant/catPlantModel.dart';
import 'package:general_products_web/models/catalogs/plant/dtPlantModel.dart';
import 'package:general_products_web/models/catalogs/plant/catPaisModel.dart';
import 'package:general_products_web/models/catalogs/plant/dtPaisModel.dart';


class PlantsProvider{
  RoutesProvider routes         = RoutesProvider();
  final Options headerWithToken = new Options(
    headers: {
      'Content-Type'    : 'application/json',
      'Accept'          : 'application/json',
      'X-Requested-With': "XMLHttpRequest",
      "Authorization"   : "Bearer ${RxVariables.token}"
    }
  );

  //Listar todas las plantas activas
  Future getAllPlants()async {
    List<CatPlantModel> provListPlants = [];
    RxVariables.errorMessage         = "";
    DtPlantModel provDtPlant           = DtPlantModel(plantsList: []);
    String url                       = routes.urlBase+routes.listarPlants;

    try {
      final dio               = Dio();
      final result            = await dio.get(url,options: headerWithToken);
      provDtPlant              = DtPlantModel.fromJson(result.data);
      RxVariables.gvListPlants = provDtPlant;
      provDtPlant.plantsList.forEach((item){
        if(item.estatus!.toLowerCase() == "activo"){
          provListPlants.add( item );
        }
      });
      rxVariables.gvBeSubListPlants.sink.add(provListPlants);
      return result.data;
    }on DioError catch (e) {
      RxVariables.errorMessage =  e.response!.data["message"]
      .toString()
      .replaceAll("{", "")
      .replaceAll("[", "")
      .replaceAll("}", "")
      .replaceAll("]", "");
      rxVariables.gvBeSubListPlants.sink.addError("Ocurrio un error, intenta más tarde "+RxVariables.errorMessage);
      return  null;
    }
  }

  //Filtrar plantas sin importar el estatus
  Future headerFilterPlant(String path) async {
    List<CatPlantModel> provListPlants = [];
    RxVariables.errorMessage         = '';
    DtPlantModel provDtPlant           = DtPlantModel(plantsList: []);
    String url                       = routes.urlBase + routes.listarPlants + path;

    try {
      final dio               = Dio();
      final result            = await dio.get(url, options: headerWithToken);
      provDtPlant              = DtPlantModel.fromJson(result.data);
      RxVariables.gvListPlants = provDtPlant;
      provDtPlant.plantsList.forEach((element) {
        //if(element.estatus!.toLowerCase() == "activo"){
          provListPlants.add(element);
        //}
      });
      rxVariables.gvBeSubListPlants.sink.add(provListPlants);
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

  Future changeStatusPlantProvider(int idCatPlanta, int idCatStatus) async {
  RxVariables.errorMessage = '';
  String url               = routes.urlBase + routes.changeEstatusPlants;

    try {
      final dio  = Dio();
      final data = {
        'id_cat_planta': idCatPlanta,
        'id_cat_estatus': idCatStatus
      };
      final resp = await dio.post(url, data: data, options: headerWithToken);
      await getAllPlants();
      RxVariables.errorMessage = resp.data["message"].toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
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

  Future createPlant (String nombrePlanta, int idCatPais) async {
  RxVariables.errorMessage = '';
  String url               = routes.urlBase + routes.crearPlants;
    try {
      final dio  = Dio();
      final data = {
        'nombre_planta': nombrePlanta,
        'id_cat_pais'  : idCatPais
      };
      final resp = await dio.post(url, data: data, options: headerWithToken);
      await getAllPlants();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
      .toString()
      .replaceAll("{", "")
      .replaceAll("[", "")
      .replaceAll("}", "")
      .replaceAll("]", "");
      rxVariables.gvBeSubListPlants.sink.addError("Ocurrio un error, intenta más tarde "+RxVariables.errorMessage);
      return null;
    }
  }

  Future editPlant(int idCatPlanta, String nombrePlanta, int idCatPais) async {
    RxVariables.errorMessage = '';
    String url               = routes.urlBase + routes.editarPlants;

    try {
      final dio  = Dio();
      final data = {
        'id_cat_planta': idCatPlanta,
        'nombre_planta': nombrePlanta,
        'id_cat_pais'  : idCatPais
      };

      final resp = await dio.post(url, data: data, options: headerWithToken);
      await getAllPlants();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
      .toString()
      .replaceAll("{", "")
      .replaceAll("[", "")
      .replaceAll("}", "")
      .replaceAll("]", "");
      rxVariables.gvBeSubListPlants.sink.addError("Ocurrio un error, intenta más tarde "+RxVariables.errorMessage);
      return null;
    }
  }

  //cargar el select de paises en el crud de plantas
  Future getAllPais()async {
    List<CatPaisModel> provListPais = [];
    RxVariables.errorMessage        = "";
    DtPaisModel provDtPais          = DtPaisModel(listCountries: []);
    String url                      = routes.urlBase+routes.paisesEstatusListas;

    try {
      final dio                 = Dio();
      final result              = await dio.get(url,options: headerWithToken);
      provDtPais                = DtPaisModel.fromJson(result.data);
      RxVariables.gvListCatPais = provDtPais;
      provDtPais.listCountries.forEach((item){
        //TODO:Filtrar por los paises activos, deben retornase desde el back solo los activos
        //if(item.estatus!.toLowerCase() == "activo"){
          provListPais.add( item );
        //}
      });
      rxVariables.gvBeSubListCatPais.sink.add(provListPais);
      return result.data;
    }on DioError catch (e) {
      RxVariables.errorMessage =  e.response!.data["message"]
      .toString()
      .replaceAll("{", "")
      .replaceAll("[", "")
      .replaceAll("}", "")
      .replaceAll("]", "");
      rxVariables.gvBeSubListPlants.sink.addError("Ocurrio un error, intenta más tarde "+RxVariables.errorMessage);
      return  null;
    }
  }

}