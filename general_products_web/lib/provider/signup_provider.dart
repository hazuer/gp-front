import 'package:dio/dio.dart';
import 'package:general_products_web/models/customer_model.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/provider/routes_provider.dart';
import 'package:general_products_web/resources/global_variables.dart';


class SignupProvider{
  RoutesProvider routes = RoutesProvider();


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

  Future recoverPassword(String email)async {
   
    String url = routes.urlBase+routes.recoverPwd;
  
    try {
      final dio = Dio();

      final data ={
       "correo": email,
      };

      final resp = await dio.post(
        url,
        data: data,
        options: RoutesProvider().headerOptions
      );
      print(resp.data);
      RxVariables.errorMessage = resp.data.toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
     
      return resp.data;

    } on DioError catch (e) {      
      RxVariables.errorMessage =  e.response!.data["message"].toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      return  null;
    }

  }

  Future logout(String email)async {
   
    String url = routes.urlBase+routes.logOut;
  
    try {
      final dio = Dio();

      

      final resp = await dio.post(
        url,
       // data: data,
        options: RoutesProvider().headerOptions
      );
      print(resp.data);
     
      return resp.data;

    } on DioError catch (e) {      
      RxVariables.errorMessage =  e.response!.data["errors"].toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      return  null;
    }

  }

  Future registerUser(String name, String lastname, String email, String idPlanta, String idCustomer)async {
   
    String url = routes.urlBase+routes.register;
  
    try {
      final dio = Dio();

      final data ={
        "nombre": name,
        "correo": email,
        "apellido_paterno": lastname,
        "id_cat_planta": idPlanta,
        "id_cat_cliente": idCustomer
      };

      final resp = await dio.post(
        url,
        data: data,
        options: RoutesProvider().headerOptions
      );

      print(resp.data);

     //message
     RxVariables.errorMessage = resp.data["message"].toString();
      return resp.data;

    } on DioError catch (e) {      
      RxVariables.errorMessage =  e.response!.data.toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      return  null;
    }

  }

  Future dataUser()async {
    List<Plant> listPlants = [];
    List<Customer> listCustomer = [];
   
    String url = routes.urlBase+routes.dataUser;
  
    try {
      final dio = Dio();

      final resp = await dio.get(
        url,
        options: RoutesProvider().headerOptions
      );


      final decodedDataPlants =resp.data["plants"];

        decodedDataPlants.forEach((item){
          final tempResponse = Plant.fromJson(item);
          listPlants.add( tempResponse );
        });
        print(listPlants.length);
        RxVariables.plantsAvailables = listPlants;

        final decodedDataCustomer =resp.data["customers"];

        decodedDataCustomer.forEach((item){
          final tempResponse = Customer.fromJson(item);
          listCustomer.add( tempResponse );
        });
        print(listCustomer.length);
        RxVariables.customerAvailables = listCustomer;


        

     
      return resp.data;

    } on DioError catch (e) {      
      RxVariables.errorMessage =  e.response!.data["errors"].toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      return  null;
    }

  }

  
  
  
}

