import 'package:dio/dio.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/provider/routes_provider.dart';
import 'package:general_products_web/models/tara/taraModel.dart';
import 'package:general_products_web/models/tara/dtTaraModel.dart';

class TarasProvider{
  RoutesProvider routes = RoutesProvider();
  final Options headerWithToken = new Options(
    headers: {
      'Content-Type'    : 'application/json',
      'Accept'          : 'application/json',
      'X-Requested-With': "XMLHttpRequest",
      "Authorization"   : "Bearer ${RxVariables.token}"
    }
  );

  Future getAllTaras()async {
    List<TaraModel> provListTaras = [];
    RxVariables.errorMessage      = "";
    DtTaraModel provDtTara        = DtTaraModel(tarassList: []);
    String url                    = routes.urlBase+routes.listarTaras;

    try {
      final dio               = Dio();
      final result            = await dio.get(url,options: headerWithToken);
      //print("statusCode: ${result.statusCode}");
      provDtTara              = DtTaraModel.fromJson(result.data);
      RxVariables.gvListTaras = provDtTara;
      provDtTara.tarassList.forEach((item){
        if(item.estatus!.toLowerCase() == "activo"){
          provListTaras.add( item );
        }
      });
      rxVariables.gvBeSubListTaras.sink.add(provListTaras);
      return result.data;
    }on DioError catch (e) {
      RxVariables.errorMessage =  e.response!.data["message"].toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      rxVariables.gvBeSubListTaras.sink.addError("Ocurrio un error, intenta más tarde "+RxVariables.errorMessage);
      return  null;
    }
  }
}