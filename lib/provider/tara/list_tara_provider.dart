import 'package:dio/dio.dart';
//import 'package:general_products_web/models/data_list_user_model.dart';
import 'package:general_products_web/models/tara/list_taras_model.dart';
//import 'package:general_products_web/models/search_user_response.dart';
import 'package:general_products_web/provider/routes_provider.dart';
import 'package:general_products_web/resources/global_variables.dart';


class ListTarasProvider{
  RoutesProvider routes = RoutesProvider();
  final Options headerWithToken = new Options(
    headers: {
      'Content-Type':'application/json',
      'Accept':'application/json',
      'X-Requested-With': "XMLHttpRequest",
      "Authorization": "Bearer ${RxVariables.token}"
    }
  );

 
  
  Future listTaras()async {
    List<TaraList> listActives = [];
    RxVariables.errorMessage = "";
    ListTarasModel listTaraModel = ListTarasModel(tarassList: []);
   
    String url = routes.urlBase+routes.listarTaras;
  
    try {
      final dio = Dio();

      final resp = await dio.get(
        url,
        options: headerWithToken
      );
      print("statusCode: ${resp.statusCode}");
      listTaraModel = ListTarasModel.fromJson(resp.data);
      print(listTaraModel.tarassList.length);
      RxVariables.listTaras = listTaraModel;
      print(RxVariables.listTaras.tarassList.length);
      listTaraModel.tarassList.forEach((item){
        if(item.estatus!.toLowerCase() == "activo"){
          listActives.add( item );
        }
      });
      print(listActives.length);
      rxVariables.lsTarasFiltros.sink.add(listActives);
     
      return resp.data;

    }on DioError catch (e) {      
      RxVariables.errorMessage =  e.response!.data["message"].toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      rxVariables.lsTarasFiltros.sink.addError(RxVariables.errorMessage+" Por favor contacta con el administrador");
      return  null;
    }
  }

}

