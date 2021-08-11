import 'package:dio/dio.dart';
import 'package:general_products_web/provider/routes_provider.dart';
import 'package:general_products_web/resources/global_variables.dart';


class ListUsersProvider{
  RoutesProvider routes = RoutesProvider();
  final Options headerWithToken = new Options(
    headers: {
      'Content-Type':'application/json',
      'Accept':'application/json',
      'X-Requested-With': "XMLHttpRequest",
      "Authorization": "Bearer ${RxVariables.token}"
    }
  );


  Future login(String email,  String password)async {
   
    String url = routes.urlBase+routes.login;
  
    try {
      final dio = Dio();

      final data ={
       "correo": email,
       "password": password,
      };

      final resp = await dio.post(
        url,
        data: data,
        options: RoutesProvider().headerOptions
      );
      print(resp.data);
      //LoginResponse? loginReponse = LoginResponse.fromJson(resp.data);
      ////RxVariables.loginResponse = loginReponse;
      //print(loginReponse.data.user.name);
     
      return resp.data;

    }on DioError catch (e) {      
      RxVariables.errorMessage =  e.response!.data.toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      return  null;
    }

  }

  
  
}

