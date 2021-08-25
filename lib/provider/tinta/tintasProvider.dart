import 'package:dio/dio.dart';
import 'package:general_products_web/models/tinta/tintasModel.dart';
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

    String url = routes.urlBase + routes.listarTintas;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      print('StatusCode: ${resp.statusCode}');
      listTintasModel = ListTintasModel.fromJson(resp.data);
      print(listTintasModel.inkList.length);
      listTintasModel.inkList.forEach((element) {
        if (element.estatus!.toLowerCase() == 'activo') {
          listActives.add(element);
        }
      });
      print(listActives.length);
      rxVariables.listTintasFilter.sink.add(listActives);
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
      print('StatusCode: ${resp.statusCode}');
      listTintasModel = ListTintasModel.fromJson(resp.data);
      print(listTintasModel.inkList.length);
      listTintasModel.inkList.forEach((element) {
        if (element.estatus!.toLowerCase() == 'activo') {
          listFilters.add(element);
        }
      });
      print(listFilters.length);
      rxVariables.listTintasFilter.sink.add(listFilters);
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
    // print('Planta: $planta');

    try {
      final dio = Dio();
      final data = {
        'nombre_tinta': nombreTinta,
        'codigo_cliente': codigoCliente,
        'codigo_gp': codigoGp,
        'id_cat_planta': idPlanta,
      };

      final resp = await dio.post(url, data: data, options: headerWithToken);

      print(resp.data);
      await listTintas();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listClientesFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  // Future crearTinta(String nombreTinta, String codigoCliente, String codigoGp,
  //     int idPlanta) async {
  //   RxVariables.errorMessage = '';
  //   String url = routes.urlBase + routes.crearTintas;
  //   // print('Planta: $planta');

  //   try {
  //     final dio = Dio();
  //     final data = {
  //       'nombre_tinta': nombreTinta,
  //       'codigo_cliente': codigoCliente,
  //       'codigo_gp': codigoGp,
  //       'id_cat_planta': idPlanta,
  //     };

  //     final resp = await dio.post(url, data: data, options: headerWithToken);

  //     print(resp.data);
  //     await listTintas();
  //     return resp.data;
  //   } on DioError catch (e) {
  //     RxVariables.errorMessage = e.response!.data["message"]
  //         .toString()
  //         .replaceAll("{", "")
  //         .replaceAll("[", "")
  //         .replaceAll("}", "")
  //         .replaceAll("]", "");
  //     rxVariables.listClientesFilter.sink.addError(RxVariables.errorMessage +
  //         " Por favor contacta con el administrador");
  //     return null;
  //   }
  // }

}
