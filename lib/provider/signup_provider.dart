import 'package:dio/dio.dart';
import 'package:general_products_web/models/customer_model.dart';
import 'package:general_products_web/models/login_response.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/provider/routes_provider.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupProvider {
  RoutesProvider routes = RoutesProvider();

  Future login(String email, String password) async {
    String url = routes.urlBase + routes.login;

    try {
      final dio = Dio();

      final data = {
        "correo": email,
        "password": password,
      };

      final resp = await dio.post(url,
          data: data, options: RoutesProvider().headerOptions);
      print("Login:");
      print(resp.data.toString());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      LoginResponse loginReponse = LoginResponse.fromJson(resp.data);
      RxVariables.loginResponse = loginReponse;
      String? token = loginReponse.data!.token;
      await prefs.setString('token', token!);
      RxVariables.token = loginReponse.data!.token!;

      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      return null;
    }
  }

  Future recoverPassword(String email) async {
    String url = routes.urlBase + routes.recoverPwd;

    try {
      final dio = Dio();

      final data = {
        "correo": email,
      };

      final resp = await dio.post(url,
          data: data, options: RoutesProvider().headerOptions);
      RxVariables.errorMessage = resp.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");

      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      return null;
    }
  }

  Future registerUser(String name, String lastname, String secondLastname,
      String email, String idPlanta, String idCustomer) async {
    String url = routes.urlBase + routes.register;

    try {
      final dio = Dio();

      final data = {
        "nombre": name,
        "correo": email,
        "apellido_paterno": lastname,
        "apellido_materno": secondLastname,
        "id_cat_planta": idPlanta,
        "id_cat_cliente": idCustomer
      };

      final resp = await dio.post(url,
          data: data, options: RoutesProvider().headerOptions);

      //message
      RxVariables.errorMessage = resp.data["message"].toString();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      return null;
    }
  }

  Future dataUser() async {
    List<Plant> listPlants = [];
    List<Customer> listCustomer = [];

    String url = routes.urlBase + routes.dataUser;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: RoutesProvider().headerOptions);

      final decodedDataPlants = resp.data["plants"];

      decodedDataPlants.forEach((item) {
        final tempResponse = Plant.fromJson(item);
        listPlants.add(tempResponse);
      });
      RxVariables.plantsAvailables = listPlants;

      final decodedDataCustomer = resp.data["customers"];

      decodedDataCustomer.forEach((item) {
        final tempResponse = Customer.fromJson(item);
        listCustomer.add(tempResponse);
      });
      RxVariables.customerAvailables = listCustomer;

      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["errors"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      return null;
    }
  }

  Future<String> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token ?? '';

    // return RxVariables.loginResponse.data!.token;
  }
}
