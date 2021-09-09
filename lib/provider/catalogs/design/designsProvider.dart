import 'package:dio/dio.dart';
import 'package:general_products_web/models/catalogs/design/designsDataModel.dart';
import 'package:general_products_web/models/catalogs/design/designsModel.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/provider/routes_provider.dart';

class DesignsProvider {
  RoutesProvider routes = RoutesProvider();
  final Options headerWithToken = new Options(headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Requested-With': "XMLHttpRequest",
    "Authorization": "Bearer ${RxVariables.token}"
  });

  Future getAllDesigns() async {
    List<DesignsList> listActives = [];
    RxVariables.errorMessage = '';
    ListDesignsModel listDesignsModel = ListDesignsModel(designsList: []);

    String url = routes.urlBase + routes.listarDisenos + '?porPagina=100';

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
      return resp.data;
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

  Future headerFilterDesigns(String path) async {
    List<DesignsList> listDesigns = [];
    RxVariables.errorMessage = '';
    ListDesignsModel listDesignsModel = ListDesignsModel(designsList: []);

    String url = routes.urlBase + routes.listarDisenos + path;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listDesignsModel = ListDesignsModel.fromJson(resp.data);
      listDesignsModel.designsList.forEach((element) {
        listDesigns.add(element);
      });
      rxVariables.listDesignsFilter.sink.add(listDesigns);
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

  Future buscarDatosDisenos(int idDiseno) async {
    List<DesignDatum> listActives = [];
    RxVariables.errorMessage = '';
    DesingsDataModel listDesignsDataModel = DesingsDataModel();

    String url =
        routes.urlBase + routes.buscarTintas + '?id_cat_diseno=$idDiseno';
    try {
      final dio = Dio();
      final resp = await dio.get(url, options: headerWithToken);

      listDesignsDataModel = DesingsDataModel.fromJson(resp.data);
      // final resp = await dio.get(url, options: headerWithToken);
      // listDesignsModel = ListDesignsModel.fromJson(resp.data);
      // listDesignsModel.designsList.forEach((element) {
      // if (element.estatus!.toLowerCase() == 'activo') {
      // listActives.add(element);
      // }
      // });
      // rxVariables.listDesignsFilter.sink.add(listActives);

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

  // Future buscarTintas(String tinta, int idPlanta) async {
  //   RxVariables.errorMessage = '';
  //   String url = routes.urlBase + routes.buscarTintas;

  //   try {
  //     final dio = Dio();
  //     final data = {
  //       'nombre_tinta': tinta,
  //       'id_cat_planta': idPlanta,
  //     };

  //     final resp = await dio.post(url, data: data, options: headerWithToken);
  //     return resp.data;
  //   } on DioError catch (e) {
  //     RxVariables.errorMessage = e.response!.data["message"]
  //         .toString()
  //         .replaceAll("{", "")
  //         .replaceAll("[", "")
  //         .replaceAll("}", "")
  //         .replaceAll("]", "");
  //     rxVariables.listDesignsFilter.sink.addError(RxVariables.errorMessage +
  //         " Por favor contacta con el administrador");
  //     return null;
  //   }
  // }

  Future createDesign(String nombreDiseno, String descripcion, int idPlanta,
      List<int> tintas) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.crearDisenos;

    try {
      final dio = Dio();
      final data = {
        'nombre_diseno': nombreDiseno,
        'descripcion': descripcion,
        'id_cat_planta': idPlanta,
        'tintas': tintas
      };

      final resp = await dio.post(url, data: data, options: headerWithToken);

      await getAllDesigns();
      return resp.data;
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

  Future editDesign(int idCatDesign, String nombreDesign, String descripcion,
      int idCatPlanta) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.editarDisenos;

    try {
      final dio = Dio();
      final data = {
        'id_cat_diseno': idCatDesign,
        'nombre_diseno': nombreDesign,
        'descripcion': descripcion,
        'id_cat_planta': idCatPlanta,
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
