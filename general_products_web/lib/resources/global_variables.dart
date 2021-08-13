import 'package:general_products_web/models/customer_model.dart';
import 'package:general_products_web/models/data_list_user_model.dart';
import 'package:general_products_web/models/list_users_model.dart';
import 'package:general_products_web/models/login_response.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/models/search_user_response.dart';
import 'package:rxdart/rxdart.dart';

class RxVariables{
  
  static LoginResponse loginResponse = LoginResponse();
  static List<Plant> plantsAvailables = [];
  static List<Customer> customerAvailables = [];
  static List<UserList> listFilter = []; 
  static UserList userSelected = UserList(); 
  static ListUsersModel listUsers = ListUsersModel(userList: []);
  static DataListUserModel dataFromUsers = DataListUserModel();
  static String errorMessage="";
  static SearchUserResponse userById = SearchUserResponse();
  //static bool isEdition = false;
  static String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiYzFiY2YyYjVmOWZlMzcxM2UzMTdjMjZkYmRmMmQ5Y2VhYmUzMmVhNTcxMGUyNmU1MzliYzYwYmE2ZWY0OTY4MDE1MDQ2ZTQ2YjIyMzU4NmMiLCJpYXQiOjE2Mjg3OTM3MjcsIm5iZiI6MTYyODc5MzcyNywiZXhwIjoxNjI4ODgwMTI3LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.iiK3Kx_3NCHc0gOvDFi7n7CtL_CGNftdrnItErZn4cgGj_HRBuFrt_NkJMtce-_v6OvxYwhaAqpEHNMD4Hw-L_Bw75M57TYQ0VrypDcDqub3t3fb_Z0C__QTbgNNfSvFPT8QEQjkRAtWNvoF67vcGcjr5H7uKiQtRl-o0yZ7D-9CDEb0cAIIQmyMNUvFfD8jaCjJRjVGzLjac3HLS1T5NoFfehlcdLIDlkNto-bBSEeI9U8z_pCxHm4oe-7p6hQ1UzuwwwLuAiCvMglrpiZpahESEM5XZRk0KQL-BPl8ekSkKaNhloYasY_7oMlU4bes9ZSQHLcElK5Lc7NiPBuZLNcUKDwsYYR7hj2n-79tXuH0fjSZ0NaI-nO4Gr9TmMJsAynRMMyhIcbYdzdgIDzfxbhA7k_qmv1m5dYtEZB2qYB7D7tk1d1TGkNNbH18bFidW5klh9lnmfWhQBBUq6MDe-jArxPAa-TWJr1k_ykkTbriQw2N-j16N6cgtGYJPADuE7egFj65eaRRcqtShGKSAcg1D79DznHf8dIFGvK1r1lIky-0U5ZvCigGXPAebTXioY5LigavzllEg0-KkQukuvVrl7uU4Yu-mC_VFsAMhC_BqEdOoJwqmD3TrhyoTvfZqrj1WvIH9GKTQtCXVtVPtwkNyvYBWEB7YtvmHgD9rEQ";
        
  

  //STREAMS

  final listUsersFilter = BehaviorSubject<List<UserList>>();
  Stream<List<UserList>> get listWorkZonesSelectedStream => listUsersFilter.stream;

 


  static final RxVariables _bloc = new RxVariables._internal();

  factory RxVariables() {
    return _bloc;
  }

  RxVariables._internal();

  void dispose(){
    listUsersFilter.close();
  }
}
final rxVariables = RxVariables();
