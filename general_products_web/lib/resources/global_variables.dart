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
  static String token = "";
  

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
