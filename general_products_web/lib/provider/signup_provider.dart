import 'package:dio/dio.dart';
import 'package:general_products_web/provider/routes_provider.dart';


class SignupProvider{


  Future login(String email,  String password)async {
   
    String url = RoutesProvider().urlBase+RoutesProvider().login;
  
    try {
      final dio = Dio();

      final data ={
       "userName": email,
       "password": password,
      };

      final resp = await dio.post(
        url,
        data: data,
        options: RoutesProvider().headerOptions
      );

     
      return resp.data;

    } catch (e) {      
      return  "Error: ${e.toString()}"; 
    }

  }
  
  
}

