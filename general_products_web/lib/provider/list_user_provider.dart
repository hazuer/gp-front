import 'package:dio/dio.dart';
import 'package:general_products_web/models/data_list_user_model.dart';
import 'package:general_products_web/models/list_users_model.dart';
import 'package:general_products_web/models/search_user_response.dart';
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

  //POST EXAMPLE
  /*Future dataListUser(String email,  String password)async {
   
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
        options: headerWithToken
      );
      print(resp.data);
     
      return resp.data;

    }on DioError catch (e) {      
      RxVariables.errorMessage =  e.response!.data.toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      return  null;
    }

  }*/

  Future dataListUser()async {
    RxVariables.errorMessage = "";
    DataListUserModel dataListUserModel = DataListUserModel();
   
    String url = routes.urlBase+routes.dataListUser;
  
    try {
      final dio = Dio();
      final resp = await dio.get(
        url,
        options: headerWithToken
      );
      print("statusCode: ${resp.statusCode}");
      dataListUserModel = DataListUserModel.fromJson(resp.data);
      print(dataListUserModel.listProfiles!.length);
     
      return resp.data;

    }on DioError catch (e) {      
      RxVariables.errorMessage =  e.response!.data.toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      return  null;
    }
  }
  
  Future listUsers()async {
    RxVariables.errorMessage = "";
    ListUsersModel listUserModel = ListUsersModel(userList: []);
   
    String url = routes.urlBase+routes.listUsers;
  
    try {
      final dio = Dio();

      final resp = await dio.get(
        url,
        options: headerWithToken
      );
      print("statusCode: ${resp.statusCode}");
      listUserModel = ListUsersModel.fromJson(resp.data);
      print(listUserModel.userList.length);
     
      return resp.data;

    }on DioError catch (e) {      
      RxVariables.errorMessage =  e.response!.data.toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      return  null;
    }

  }

  Future searchUserId(String id)async {
    RxVariables.errorMessage = "";
    SearchUserResponse searchUser =SearchUserResponse ();
    String url = routes.urlBase+routes.searchUser+id;
  
    try {
      final dio = Dio();

      final resp = await dio.get(
        url,
        options: headerWithToken
      );
      print("statusCode: ${resp.statusCode}");
      searchUser = SearchUserResponse.fromJson(resp.data);
      print(searchUser.user!.nombre);
     
      return resp.data;

    }on DioError catch (e) {      
      RxVariables.errorMessage =  e.response!.data.toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      return  null;
    }

  }
  
  
}

