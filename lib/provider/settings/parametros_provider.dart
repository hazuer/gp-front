import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:general_products_web/models/settings/ParametrosModel.dart';
import 'package:general_products_web/provider/routes_provider.dart';
import 'package:general_products_web/resources/global_variables.dart';

class ParametrosProvider {
  RoutesProvider routes = RoutesProvider();
  final Options headerWithToken = new Options(headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Requested-With': "XMLHttpRequest",
    "Authorization": "Bearer ${RxVariables.token}"
  });

  Future getAllParameters(int idPlanta) async {
    List<SystemParams> listParametros = [];
    RxVariables.errorMessage = '';
    // ParametrosModel listParametrosModel = ParametrosModel(systemParams: []);

    String url =
        routes.urlBase + routes.listParameters + '?id_cat_planta=$idPlanta';

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      // listParametrosModel = ParametrosModel.fromJson(resp.data);
      // listParametrosModel.systemParams.forEach((element) {
      //   listParametros.add(element);
      // });
      rxVariables.listParametersFilter.sink.add(listParametros);
      RxVariables.initialParameters = resp.data;
      // RxVariables.initialParameters = listParametros.first;
      print('RxVariables: ${RxVariables.initialParameters}');
      print('Resp.data: ${resp.data}');
      // final Map<String, dynamic> parametersMap = jsonDecode(resp.data);
      // RxVariables.initialParameters = parametersMap;
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listParametersFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future changeParameters(
      int idPlanta,
      bool campoLote,
      bool cantidadProgramada,
      bool utilizaTara,
      bool campoLinea,
      bool requiereTurno,
      int variacionMaxima,
      int porcentajeAceptacion,
      bool utilizaPH,
      bool viscocidad,
      bool utilizaFiltro) async {
    RxVariables.errorMessage = '';

    String url = routes.urlBase + routes.changeParameters;
    try {
      final dio = Dio();
      final data = {
        'id_cat_planta': idPlanta,
        'campo_lote': campoLote,
        'campo_cantidad_programada': cantidadProgramada,
        'utiliza_tara': utilizaTara,
        'campo_linea': campoLinea,
        'requiere_turno': requiereTurno,
        'variacion_maxima': variacionMaxima,
        'porcentaje_aceptacion': porcentajeAceptacion,
        'utiliza_ph': utilizaPH,
        'mide_viscosidad': viscocidad,
        'utiliza_filtro': utilizaFiltro
      };

      final resp = await dio.post(url, data: data, options: headerWithToken);

      await getAllParameters(idPlanta);
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listParametersFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }
}
