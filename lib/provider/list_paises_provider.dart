import 'package:dio/dio.dart';
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
    List<PaisesList> listActives = [];
    RxVariables.errorMessage = '';
    ListPaisesModel listPaisesModel = ListPaisesModel(paisesList: []);

    String url = routes.urlBase + routes.listPaises;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      print('StatusCode: ${resp.statusCode}');
      listPaisesModel = ListPaisesModel.fromJson(resp.data);
      print(listPaisesModel.paisesList.length);
      print(RxVariables.listPaises.paisesList.length);
      listPaisesModel.paisesList.forEach((element) {
        if (element.estatus.toLowerCase() == 'activo') {
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

  // Future dataListPaises() async {
  //   RxVariables.errorMessage = '';

  //   String url = routes.urlBase + routes.listPaises;

  //   try {
  //     final dio = Dio();

  //     final resp = await dio.get(url, options: headerWithToken);
  //     print("statusCode: ${resp.statusCode}");
  //     listPaisesModel = ListPaisesModel.fromJson(resp.data);
  //     print(listPaisesModel.paisesList.length);
  //     RxVariables.listPaises = listPaisesModel;
  //     print(RxVariables.listPaises.paisesList.length);
  //     listPaisesModel.paisesList.forEach((item) {
  //       if (item.estatus.toLowerCase() == 'activo') {
  //         listActives.add(item);
  //       }
  //     });
  //     print(listActives.length);
  //     rxVariables.listPaisesFilter.sink.add(listActives);

  //     return resp.data;
  //   } on DioError catch (e) {
  //     RxVariables.errorMessage = e.response!.data["message"]
  //         .toString()
  //         .replaceAll("{", "")
  //         .replaceAll("[", "")
  //         .replaceAll("}", "")
  //         .replaceAll("]", "");
  //     rxVariables.listPaisesFilter.sink.addError(RxVariables.errorMessage +
  //         " Por favor contacta con el administrador");
  //     return null;
  //   }
  // }
}
