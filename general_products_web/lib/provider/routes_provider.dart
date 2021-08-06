import 'package:dio/dio.dart';

class RoutesProvider{

  final String urlBase = "http://api-dev.generalproducts.com.mx:880/api/";


  final Options headerOptions = new Options(
    headers: {
      'Content-Type':'application/json',
      'X-Requested-With': "XMLHttpRequest"
    }
  );

  //final Options headerWithToken = new Options(
  //  headers: {
  //    'Content-Type':'application/json',
  //    'Accept':'application/json',
  //    'X-Requested-With': "XMLHttpRequest",
  //    "Authorization": "Bearer ${RxVariables.loginResponse.data!.token}"
  //  }
  //);
  
  String login = "login";
  String register = "registrar-usuario";
  String dataUser = "datos-registro";
  String recoverPwd = "recuperar-contraseña";
  String logOut = "cerrar-sesion";
  
  
}
