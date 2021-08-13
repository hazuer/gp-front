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
  Future disabledUser(int idUser,  int idStatus)async {
   RxVariables.errorMessage = "";
    String url = routes.urlBase+routes.deactivateUsers;
  
    try {
      final dio = Dio();

      final data ={
        "id_dato_usuario": idUser,
        "id_cat_estatus": 2
      };

      final resp = await dio.post(
        url,
        data: data,
        options: headerWithToken
      );
      print(resp.data);
      await listUsers();
      return resp.data;

    }on DioError catch (e) {      
      RxVariables.errorMessage =  e.response!.data.toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      return  null;
    }

  }

  Future logOut()async {
   RxVariables.errorMessage = "";
    String url = routes.urlBase+routes.logOut;
  
    try {
      final dio = Dio();

      final resp = await dio.post(
        url,
        //data: data,
        options: headerWithToken
      );
      print(resp.data);
      
      return resp.data;

    }on DioError catch (e) {      
      RxVariables.errorMessage =  e.response!.data.toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      return  null;
    }

  }

  Future authorizeUser(int idUser, int idPerfil, int idCliente, int idPlanta, int idStatus)async {
    RxVariables.errorMessage = "";
    String url = routes.urlBase+routes.authorizeUser;
  
    try {
      final dio = Dio();

      final data ={
        "id_dato_usuario": idUser,
        "correo": RxVariables.userById.user!.correo??"",
        "nombre": RxVariables.userById.user!.nombre??"",
        "apellido_paterno": RxVariables.userById.user!.apellidoPaterno??"",
        "apellido_materno": RxVariables.userById.user!.apellidoMaterno??"",
        "id_cat_perfil": idPerfil,
        "id_cat_cliente": idCliente,
        "id_cat_planta": idPlanta,
        "id_cat_estatus": idStatus
      };

      print(data.toString());

      final resp = await dio.post(
        url,
        data: data,
        options: headerWithToken
      );
      print(resp.data);
      await listUsers();
      return resp.data;

    }on DioError catch (e) {      
      RxVariables.errorMessage =  e.response!.data.toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      return  null;
    }

  }

  Future editUser(int idUser, int idPerfil, int idCliente, int idPlanta, int idStatus)async {
    RxVariables.errorMessage = "";
    String url = routes.urlBase+routes.editUser;
  
    try {
      final dio = Dio();

      final data ={
        "id_dato_usuario": idUser,
        "correo": RxVariables.userById.user!.correo??"",
        "id_cat_perfil": idPerfil,
        "id_cat_cliente": idCliente,
        "id_cat_planta": idPlanta,
        "id_cat_estatus": idStatus
      };


      final resp = await dio.post(
        url,
        data: data,
        options: headerWithToken
      );
      print(resp.data);
      await listUsers();
      return resp.data;

    }on DioError catch (e) {      
      RxVariables.errorMessage =  e.response!.data.toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      return  null;
    }

  }

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
      RxVariables.dataFromUsers = dataListUserModel;
      
     
      return resp.data;

    }on DioError catch (e) {      
      RxVariables.errorMessage =  e.response!.data.toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      return  null;
    }
  }
  
  Future listUsers()async {
    List<UserList> listActives = [];
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
      RxVariables.listUsers = listUserModel;
      print(RxVariables.listUsers.userList.length);
      listUserModel.userList.forEach((item){
        if(item.estatus!.toLowerCase() == "activo"){
          listActives.add( item );
        }
      });
      print(listActives.length);
      rxVariables.listUsersFilter.sink.add(listActives);
     
      return resp.data;

    }on DioError catch (e) {      
      RxVariables.errorMessage =  e.response!.data.toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      return  null;
    }
  }

  Future listUsersWithFilters(String path)async {
    List<UserList> listFilters = [];
    RxVariables.errorMessage = "";
    ListUsersModel listUserModel = ListUsersModel(userList: []);
   
    String url = routes.urlBase+routes.listUsers+path;
  
    try {
      final dio = Dio();

      final resp = await dio.get(
        url,
        options: headerWithToken
      );
      print("statusCode: ${resp.statusCode}");
      listUserModel = ListUsersModel.fromJson(resp.data);
      RxVariables.listUsers = listUserModel;
      print(RxVariables.listUsers.userList.length);
      listUserModel.userList.forEach((item){
        listFilters.add( item );
      });
      print(listFilters.length);
      rxVariables.listUsersFilter.sink.add(listFilters);
     
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
      RxVariables.userById = searchUser;
     
      return resp.data;

    }on DioError catch (e) {      
      RxVariables.errorMessage =  e.response!.data.toString().replaceAll("{", "").replaceAll("[", "").replaceAll("}", "").replaceAll("]", "");
      return  null;
    }

  }
  
  
}

