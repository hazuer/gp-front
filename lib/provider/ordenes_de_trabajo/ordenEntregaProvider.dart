import 'package:dio/dio.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/ordenesEntregaModel.dart';
import 'package:general_products_web/provider/routes_provider.dart';
import 'package:general_products_web/resources/global_variables.dart';

class OrdenEntregaProvider {
  RoutesProvider routes = RoutesProvider();
  final Options headerWithToken = new Options(headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Requested-With': "XMLHttpRequest",
    "Authorization": "Bearer ${RxVariables.token}"
  });

  Future getOrdenesDeEntrega() async {
    List<DeliveryOrdersList> listOE = [];
    RxVariables.errorMessage = '';
    OrdenesDeEntregaModel listOEModel =
        OrdenesDeEntregaModel(deliveryOrdersList: []);

    String url = routes.urlBase + routes.listarOE + '?porPagina = 100';

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listOEModel = OrdenesDeEntregaModel.fromJson(resp.data);
      listOEModel.deliveryOrdersList.forEach((element) {
        listOE.add(element);
      });
      rxVariables.listOrdersFilter.sink.add(listOE);
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listOrdersFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future getOrdenesDeEntregaWithFilters(String path) async {
    List<DeliveryOrdersList> listOE = [];
    RxVariables.errorMessage = '';
    OrdenesDeEntregaModel listOEModel =
        OrdenesDeEntregaModel(deliveryOrdersList: []);

    String url = routes.urlBase + routes.listarOE + path;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listOEModel = OrdenesDeEntregaModel.fromJson(resp.data);
      listOEModel.deliveryOrdersList.forEach((element) {
        listOE.add(element);
      });
      rxVariables.listOrdersFilter.sink.add(listOE);
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listOrdersFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }
}