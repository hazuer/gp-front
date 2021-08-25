import 'package:dio/dio.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/provider/routes_provider.dart';
import 'package:general_products_web/models/tara/catTaraModel.dart';
import 'package:general_products_web/models/tara/dtTaraModel.dart';

class TarasProvider{
  RoutesProvider routes = RoutesProvider();
  final Options headerWithToken = new Options(
    headers: {
      'Content-Type'    : 'application/json',
      'Accept'          : 'application/json',
      'X-Requested-With': "XMLHttpRequest",
      "Authorization"   : "Bearer ${RxVariables.token}"
    }
  );

  //Listar todas las taras activas
  Future getAllTaras()async {
    List<CatTaraModel> provListTaras = [];
    RxVariables.errorMessage         = "";
    DtTaraModel provDtTara           = DtTaraModel(tarassList: []);
    String url                       = routes.urlBase+routes.listarTaras;

    try {
      final dio               = Dio();
      final result            = await dio.get(url,options: headerWithToken);
      //print("statusCode: ${result.statusCode}");
      provDtTara              = DtTaraModel.fromJson(result.data);
      RxVariables.gvListTaras = provDtTara;
      provDtTara.tarassList.forEach((item){
        if(item.estatus!.toLowerCase() == "activo"){
          provListTaras.add( item );
        }
      });
      rxVariables.gvBeSubListTaras.sink.add(provListTaras);
      return result.data;
    }on DioError catch (e) {
      RxVariables.errorMessage =  e.response!.data["message"].toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      rxVariables.gvBeSubListTaras.sink.addError("Ocurrio un error, intenta más tarde "+RxVariables.errorMessage);
      return  null;
    }
  }

  //Filtrar taras sin importar el estatus
  Future headerFilterTara(String path) async {
    List<CatTaraModel> provListTaras = [];
    RxVariables.errorMessage         = '';
    DtTaraModel provDtTara           = DtTaraModel(tarassList: []);
    String url                       = routes.urlBase + routes.listarTaras + path;

    try {
      final dio               = Dio();
      final result            = await dio.get(url, options: headerWithToken);
      //print("statusCode: ${result.statusCode}");
      provDtTara              = DtTaraModel.fromJson(result.data);
      RxVariables.gvListTaras = provDtTara;
      provDtTara.tarassList.forEach((element) {
        //if(element.estatus!.toLowerCase() == "activo"){
          provListTaras.add(element);
        //}
      });
      rxVariables.gvBeSubListTaras.sink.add(provListTaras);
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

  Future changeStatusTaraProvider(int idCatTara, int idCatStatus) async {
  RxVariables.errorMessage = '';
  String url               = routes.urlBase + routes.changeEstatusTaras;

    try {
      final dio  = Dio();
      final data = {'id_cat_tara': idCatTara, 'id_cat_estatus': idCatStatus};
      final resp = await dio.post(url, data: data, options: headerWithToken);
      await getAllTaras();
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

  Future createTara (String nombreTara, String capacidad, int idCatPlanta) async {
  RxVariables.errorMessage = '';
  String url               = routes.urlBase + routes.crearTaras;
    try {
      final dio  = Dio();
      final data = {'nombre_tara'          : nombreTara, 'capacidad': capacidad, 'id_cat_planta': idCatPlanta};
      final resp = await dio.post(url, data: data, options          : headerWithToken);
      await getAllTaras();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
      .toString()
      .replaceAll("{", "")
      .replaceAll("[", "")
      .replaceAll("}", "")
      .replaceAll("]", "");
      rxVariables.gvBeSubListTaras.sink.addError("Ocurrio un error, intenta más tarde "+RxVariables.errorMessage);
      return null;
    }
  }
}