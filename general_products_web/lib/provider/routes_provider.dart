import 'package:dio/dio.dart';

class RoutesProvider{

  final String urlBase = "https://api.nnnnn.com";


  final Options headerOptions = new Options(
    headers: {
      'Content-Type':'application/json',
      'x-api-key': "nnnnn...."
    }
  );
  
  String login = "/security/login/worker";
  
  
}
