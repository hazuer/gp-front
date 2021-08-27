import 'package:dio/dio.dart';
import 'package:general_products_web/models/razon/dtRazonModel.dart';
import 'package:general_products_web/models/razon/razonModel.dart';
import 'package:general_products_web/models/razon/razonesModel.dart';
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
    List<ReasonsList> listActives = [];
    RxVariables.errorMessage = '';
    ListRazonesModel listRazonesModel = ListRazonesModel(reasonsList: []);

    String url = routes.urlBase + routes.listarRazones;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listRazonesModel = ListRazonesModel.fromJson(resp.data);
      listRazonesModel.reasonsList.forEach((element) {
        if (element.estatus!.toLowerCase() == 'activo') {
          listActives.add(element);
        }
      });
      rxVariables.listRazonesFilter.sink.add(listActives);
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listRazonesFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future listRazonesWithFiltter(String path) async {
    List<ReasonsList> listFilters = [];
    RxVariables.errorMessage = '';
    ListRazonesModel listRazonesModel = ListRazonesModel(reasonsList: []);

    String url = routes.urlBase + routes.listarRazones + path;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listRazonesModel = ListRazonesModel.fromJson(resp.data);
      listRazonesModel.reasonsList.forEach((element) {
        if (element.estatus!.toLowerCase() == 'activo') {
          listFilters.add(element);
        }
      });
      rxVariables.listRazonesFilter.sink.add(listFilters);
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listRazonesFilter.sink.addError(RxVariables.errorMessage +
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
      rxVariables.listRazonesFilter.sink.addError(RxVariables.errorMessage +
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
      rxVariables.listRazonesFilter.sink.addError(RxVariables.errorMessage +
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

  Future activarRazon(int idRazon, int idStatus) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.activarRazones;

    try {
      final dio = Dio();

      final data = {'id_cat_razon': idRazon, 'id_cat_estatus': idStatus};

      final resp = await dio.post(url, data: data, options: headerWithToken);

      await listRazones();
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

  Future desactivarRazon(int idRazon, int idStatus) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.desactivarRazones;

    try {
      final dio = Dio();

      final data = {'id_cat_razon': idRazon, 'id_cat_estatus': idStatus};

      final resp = await dio.post(url, data: data, options: headerWithToken);

      await listRazones();
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

  Future eliminarRazon(int idRazon, int idStatus) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.eliminarRazones;

    try {
      final dio = Dio();
      final data = {'id_cat_razon': idRazon, 'id_cat_estatus': idStatus};

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
      rxVariables.listRazonesFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future getAllRazones() async {
    List<RazonModel> provListRazones = [];
    RxVariables.errorMessage = '';
    DtRazonesModel provDtRazon = DtRazonesModel(reasonsList: []);
    String url = routes.urlBase + routes.listarRazones;

    try {
      final dio = Dio();
      final result = await dio.get(url, options: headerWithToken);

      provDtRazon = DtRazonesModel.fromJson(result.data);
      RxVariables.gvListRazones = provDtRazon;
      provDtRazon.reasonsList.forEach((element) {
        if (element.estatus!.toLowerCase() == 'activo') {
          provListRazones.add(element);
        }
      });
      rxVariables.gvBeSubListRazones.sink.add(provListRazones);
      return result.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.gvBeSubListRazones.sink.addError(
          "Ocurrio un error, intenta más tarde " + RxVariables.errorMessage);
      return null;
    }
  }
}
