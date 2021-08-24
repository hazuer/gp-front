import 'package:dio/dio.dart';
import 'package:general_products_web/models/cliente/list_clientes_model.dart';
import 'package:general_products_web/models/cliente/plants_status_clientes_model.dart';
import 'package:general_products_web/provider/routes_provider.dart';
import 'package:general_products_web/resources/global_variables.dart';

class ClientesProvider {
  RoutesProvider routes = RoutesProvider();
  final Options headerWithToken = new Options(headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Requested-With': "XMLHttpRequest",
    "Authorization": "Bearer ${RxVariables.token}"
  });

  Future listClientes() async {
    List<CustomersList> listActives = [];
    RxVariables.errorMessage = '';
    ListClientesModel listClientesModel = ListClientesModel(customersList: []);

    String url = routes.urlBase + routes.listClientes;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      print('StatusCode: ${resp.statusCode}');
      listClientesModel = ListClientesModel.fromJson(resp.data);
      print(listClientesModel.customersList.length);
      print(RxVariables.listClientes.customersList.length);
      listClientesModel.customersList.forEach((element) {
        if (element.estatus!.toLowerCase() == 'activo') {
          listActives.add(element);
        }
      });
      print(listActives.length);
      rxVariables.listClientesFilter.sink.add(listActives);
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

  Future dataListClientes() async {
    RxVariables.errorMessage = '';
    PlantsStatusCustomersModel listClientesModel = PlantsStatusCustomersModel();

    String url = routes.urlBase + routes.plantasClientes;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      print("statusCode: ${resp.statusCode}");
      listClientesModel = PlantsStatusCustomersModel.fromJson(resp.data);
      // RxVariables.listClientes = listClientesModel;

    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listUsersFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future listClientesWithFilters(String path) async {
    List<CustomersList> listFilters = [];
    RxVariables.errorMessage = '';
    ListClientesModel listClientesModel = ListClientesModel(customersList: []);

    String url = routes.urlBase + routes.listClientes + path;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      print('StatusCode: ${resp.statusCode}');
      listClientesModel = ListClientesModel.fromJson(resp.data);
      print(listClientesModel.customersList.length);
      print(RxVariables.listClientes.customersList.length);
      listClientesModel.customersList.forEach((element) {
        listFilters.add(element);
      });
      print(listFilters.length);
      rxVariables.listClientesFilter.sink.add(listFilters);

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

  Future crearCliente(String nombreCliente, int planta) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.crearClientes;
    print('Planta: $planta');

    try {
      final dio = Dio();
      final data = {'nombre_cliente': nombreCliente, 'id_cat_planta': planta};

      final resp = await dio.post(url, data: data, options: headerWithToken);

      print(resp.data);
      await listClientes();
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

  Future editCliente(int idCliente, String nombreCliente, int idPlanta) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.editarClientes;

    try {
      final dio = Dio();
      final data = {
        'id_cat_cliente': idCliente,
        'nombre_cliente': nombreCliente,
        'id_cat_planta': idPlanta
      };

      final resp = await dio.post(url, data: data, options: headerWithToken);
      print(resp.data);
      await listClientes();
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

  Future desactivarCliente(int idCliente, int idStatus) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.desactivarClientes;

    try {
      final dio = Dio();

      final data = {'id_cat_cliente': idCliente, 'id_cat_estatus': idStatus};

      final resp = await dio.post(url, data: data, options: headerWithToken);

      print(resp.data);
      await listClientes();
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

  Future eliminarCliente(int idCliente, int idStatus) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.eliminarClientes;

    try {
      final dio = Dio();

      final data = {'id_cat_cliente': idCliente, 'id_cat_estatus': idStatus};

      final resp = await dio.post(url, data: data, options: headerWithToken);

      print(resp.data);
      await listClientes();
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
