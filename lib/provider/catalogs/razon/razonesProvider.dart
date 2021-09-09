import 'package:dio/dio.dart';
import 'package:general_products_web/models/catalogs/razon/dtRazonModel.dart';
import 'package:general_products_web/models/catalogs/razon/catRazonModel.dart';
import 'package:general_products_web/provider/routes_provider.dart';
import 'package:general_products_web/resources/global_variables.dart';

class RazonesProvider {
  RoutesProvider routes = RoutesProvider();
  final Options headerWithToken = new Options(headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Requested-With': "XMLHttpRequest",
    "Authorization": "Bearer ${RxVariables.token}"
  });


  Future listRazones() async {
    List<RazonModel> listActives = [];
    RxVariables.errorMessage = '';
    DtRazonesModel listRazonesModel = DtRazonesModel(reasonsList: []);

    String url = routes.urlBase + routes.listarRazones + '?porPagina=100';

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listRazonesModel = DtRazonesModel.fromJson(resp.data);
      listRazonesModel.reasonsList.forEach((element) {
        if (element.estatus!.toLowerCase() == 'activo') {
          listActives.add(element);
        }
      });
      rxVariables.gvBeSubListRazones.sink.add(listActives);
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.gvBeSubListRazones.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future listRazonesWithFiltter(String path) async {
    List<RazonModel> listFilters = [];
    RxVariables.errorMessage = '';
    DtRazonesModel listRazonesModel = DtRazonesModel(reasonsList: []);

    String url = routes.urlBase + routes.listarRazones + path;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listRazonesModel = DtRazonesModel.fromJson(resp.data);
      listRazonesModel.reasonsList.forEach((element) {
        listFilters.add(element);
      });
      rxVariables.gvBeSubListRazones.sink.add(listFilters);
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.gvBeSubListRazones.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future crearRazon(String razon, int planta) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.crearRazones;

    try {
      final dio = Dio();
      final data = {'razon': razon, 'id_cat_planta': planta};

      final resp = await dio.post(url, data: data, options: headerWithToken);

      await listRazones();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.gvBeSubListRazones.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future editarRazon(int idRazon, String razon, int idPlanta) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.editarRazones;

    try {
      final dio = Dio();
      final data = {
        'id_cat_razon': idRazon,
        'razon': razon,
        'id_cat_planta': idPlanta
      };

      final resp = await dio.post(url, data: data, options: headerWithToken);
      await listRazones();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.gvBeSubListRazones.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future changeStatusRazonProvider(int idCatRazon, int idCatStatus) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.changeEstatusRazones;

    try {
      final dio = Dio();
      final data = {'id_cat_razon': idCatRazon, 'id_cat_estatus': idCatStatus};
      final resp = await dio.post(url, data: data, options: headerWithToken);
      await listRazones();
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
}
