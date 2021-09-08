import 'package:dio/dio.dart';
import 'package:general_products_web/models/catalogs/tinta/catTintasModel.dart';
import 'package:general_products_web/models/catalogs/tinta/dtTintasModel.dart';
import 'package:general_products_web/provider/routes_provider.dart';
import 'package:general_products_web/resources/global_variables.dart';

class TintasProvider {
  RoutesProvider routes = RoutesProvider();
  final Options headerWithToken = new Options(headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Requested-With': "XMLHttpRequest",
    "Authorization": "Bearer ${RxVariables.token}"
  });

  Future listTintas() async {
    List<InkList> listActives = [];
    RxVariables.errorMessage = '';
    ListTintasModel listTintasModel = ListTintasModel(inkList: []);

    String url = routes.urlBase + routes.listarTintas + '?porPagina=100';

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listTintasModel = ListTintasModel.fromJson(resp.data);
      RxVariables.gvListTinta = listTintasModel;
      listTintasModel.inkList.forEach((element) {
        if (element.estatus!.toLowerCase() == 'activo') {
          listActives.add(element);
        }
      });
      rxVariables.listTintasFilter.sink.add(listActives);
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listTintasFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future listTintasWithFiltter(String path) async {
    List<InkList> listFilters = [];
    RxVariables.errorMessage = '';
    ListTintasModel listTintasModel = ListTintasModel(inkList: []);

    String url = routes.urlBase + routes.listarTintas + path;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listTintasModel = ListTintasModel.fromJson(resp.data);
      listTintasModel.inkList.forEach((element) {
        listFilters.add(element);
      });
      rxVariables.listTintasFilter.sink.add(listFilters);
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listTintasFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future crearTinta(String nombreTinta, String codigoCliente, String codigoGp,
      int idPlanta) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.crearTintas;

    try {
      final dio = Dio();
      final data = {
        'nombre_tinta': nombreTinta,
        'codigo_cliente': codigoCliente,
        'codigo_gp': codigoGp,
        'id_cat_planta': idPlanta,
      };

      final resp = await dio.post(url, data: data, options: headerWithToken);

      await listTintas();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listTintasFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future editarTinta(int idTinta, String nombreTinta, String codigoCliente,
      String codigoGp, int idPlanta) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.editarTintas;

    try {
      final dio = Dio();
      final data = {
        'id_cat_tinta': idTinta,
        'nombre_tinta': nombreTinta,
        'codigo_cliente': codigoCliente,
        'codigo_gp': codigoGp,
        'id_cat_planta': idPlanta,
      };

      final resp = await dio.post(url, data: data, options: headerWithToken);

      await listTintas();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listTintasFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future editarEstatusTinta(int idTinta, int idStatus) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.changeEstatusTintas;

    try {
      final dio = Dio();

      final data = {'id_cat_tinta': idTinta, 'id_cat_estatus': idStatus};

      final resp = await dio.post(url, data: data, options: headerWithToken);

      await listTintas();
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
