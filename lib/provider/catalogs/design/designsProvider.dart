import 'package:dio/dio.dart';
import 'package:general_products_web/models/catalogs/design/designsModel.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/provider/routes_provider.dart';
import 'package:general_products_web/models/tara/catTaraModel.dart';
import 'package:general_products_web/models/tara/dtTaraModel.dart';

class DesignsProvider {
  RoutesProvider routes = RoutesProvider();
  final Options headerWithToken = new Options(headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Requested-With': "XMLHttpRequest",
    "Authorization": "Bearer ${RxVariables.token}"
  });

  //Listar todas las taras activas
  Future getAllDesigns() async {
    List<DesignsList> listActives = [];
    RxVariables.errorMessage = '';
    ListDesignsModel listDesignsModel = ListDesignsModel(designsList: []);

    String url = routes.urlBase + routes.listarDisenos;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listDesignsModel = ListDesignsModel.fromJson(resp.data);
      listDesignsModel.designsList.forEach((element) {
        if (element.estatus!.toLowerCase() == 'activo') {
          listActives.add(element);
        }
      });
      rxVariables.listDesignsFilter.sink.add(listActives);
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listDesignsFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  //Filtrar taras sin importar el estatus
  Future headerFilterTara(String path) async {
    List<CatTaraModel> provListTaras = [];
    RxVariables.errorMessage = '';
    DtTaraModel provDtTara = DtTaraModel(tarassList: []);
    String url = routes.urlBase + routes.listarTaras + path;

    try {
      final dio = Dio();
      final result = await dio.get(url, options: headerWithToken);
      provDtTara = DtTaraModel.fromJson(result.data);
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

  Future editDesign(int idCatDesign, String nombreDesign, String descripcion,
      int idCatStatus) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.editarDisenos;

    try {
      final dio = Dio();
      final data = {
        'id_cat_diseno': idCatDesign,
        'nombre_diseno': nombreDesign,
        'descripcion': descripcion,
        'id_cat_estatus': idCatStatus,
      };
      final resp = await dio.post(url, data: data, options: headerWithToken);
      await getAllDesigns();
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

  Future changeStatusDesignProvider(int idCatDesign, int idCatStatus) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.changeEstatusDisenos;

    try {
      final dio = Dio();
      final data = {
        'id_cat_diseno': idCatDesign,
        'id_cat_estatus': idCatStatus,
      };
      final resp = await dio.post(url, data: data, options: headerWithToken);
      await getAllDesigns();
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

  Future createTara(
      String nombreTara, String capacidad, int idCatPlanta) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.crearTaras;
    try {
      final dio = Dio();
      final data = {
        'nombre_tara': nombreTara,
        'capacidad': capacidad,
        'id_cat_planta': idCatPlanta
      };
      final resp = await dio.post(url, data: data, options: headerWithToken);
      // await getAllTaras();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.gvBeSubListTaras.sink.addError(
          "Ocurrio un error, intenta más tarde " + RxVariables.errorMessage);
      return null;
    }
  }

  Future editTara(
      int idCatTara, String nombreTara, String capacidad, int idPlanta) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.editarTaras;

    try {
      final dio = Dio();
      final data = {
        'id_cat_tara': idCatTara,
        'nombre_tara': nombreTara,
        'capacidad': capacidad,
        'id_cat_planta': idPlanta
      };

      final resp = await dio.post(url, data: data, options: headerWithToken);
      // await getAllTaras();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.gvBeSubListTaras.sink.addError(
          "Ocurrio un error, intenta más tarde " + RxVariables.errorMessage);
      return null;
    }
  }
}
