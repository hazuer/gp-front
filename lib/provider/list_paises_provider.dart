import 'package:dio/dio.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/models/list_paises_model.dart';
import 'package:general_products_web/provider/routes_provider.dart';
import 'package:general_products_web/resources/global_variables.dart';

class ListPaisesProvider {
  RoutesProvider routes = RoutesProvider();
  final Options headerWithToken = new Options(headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Requested-With': "XMLHttpRequest",
    "Authorization": "Bearer ${RxVariables.token}"
  });

  Future listPaises() async {
    List<CountriesList> listActives = [];
    RxVariables.errorMessage = '';
    ListPaisesModel listPaisesModel = ListPaisesModel(countriesList: []);

    String url = routes.urlBase + routes.listPaises;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      print('StatusCode: ${resp.statusCode}');
      listPaisesModel = ListPaisesModel.fromJson(resp.data);
      print(listPaisesModel.countriesList.length);
      print(RxVariables.listPaises.countriesList.length);
      listPaisesModel.countriesList.forEach((element) {
        if (element.estatus!.toLowerCase() == 'activo') {
          listActives.add(element);
        }
      });
      print(listActives.length);
      rxVariables.listPaisesFilter.sink.add(listActives);

      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listPaisesFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future listPaisesWithFilters(String path) async {
    List<CountriesList> listFilters = [];
    RxVariables.errorMessage = '';
    ListPaisesModel listPaisesModel = ListPaisesModel(countriesList: []);

    String url = routes.urlBase + routes.listPaises + path;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      print("statusCode: ${resp.statusCode}");
      listPaisesModel = ListPaisesModel.fromJson(resp.data);
      RxVariables.listPaises = listPaisesModel;
      print(RxVariables.listPaises.countriesList.length);
      listPaisesModel.countriesList.forEach((element) {
        listFilters.add(element);
      });
      print(listFilters.length);
      rxVariables.listPaisesFilter.sink.add(listFilters);

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

  Future crearPais(String nombrePais) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.crearPais;

    try {
      final dio = Dio();

      final data = {'nombre_pais': nombrePais};

      final resp = await dio.post(url, data: data, options: headerWithToken);

      print(resp.data);
      await listPaises();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listPaisesFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future editPais(int idPais, String nombrePais) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.editarPais;

    try {
      final dio = Dio();

      final data = {'id_cat_pais': idPais, 'nombre_pais': nombrePais};

      final resp = await dio.post(url, data: data, options: headerWithToken);
      print(resp.data);
      await listPaises();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listPaisesFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future habilitarPais(int idPais, int idStatus) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.desactivarPais;

    try {
      final dio = Dio();

      final data = {'id_cat_pais': idPais, 'id_cat_estatus': idStatus};

      final resp = await dio.post(url, data: data, options: headerWithToken);

      print(resp.data);
      await listPaises();
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

  Future deshabilitarPais(int idPais, int idStatus) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.desactivarPais;

    try {
      final dio = Dio();

      final data = {'id_cat_pais': idPais, 'id_cat_estatus': idStatus};

      final resp = await dio.post(url, data: data, options: headerWithToken);

      print(resp.data);
      await listPaises();
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

  Future eliminarPais(int idPais, int idStatus) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.desactivarPais;

    try {
      final dio = Dio();

      final data = {'id_cat_pais': idPais, 'id_cat_estatus': idStatus};

      final resp = await dio.post(url, data: data, options: headerWithToken);

      print(resp.data);
      await listPaises();
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
