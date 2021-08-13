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
  static String token = ""; //"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZDMzNGNhNWM0N2E5YzMwMDQ5NTgwZGNlMTM1OTdkYTBmNjM0MWM3OWI5MTNiMTU1NWZhZTEwMWI2NGMzMjc2OTRkNWRlZjY5YTUzNGQwNGUiLCJpYXQiOjE2Mjg4NzI3NTAsIm5iZiI6MTYyODg3Mjc1MCwiZXhwIjoxNjI4OTU5MTUwLCJzdWIiOiIxNSIsInNjb3BlcyI6W119.HpX3zZKVIelLUoaLscWBmKaRse5iC-6nhoTcfp5om9WLF5sCekTT8wH3qCcr4BXqeoGRPS82NLJyeVS6a24k_aCfZEoaA3OVRa-DeHGgDnoajkff5ERvyVUD3_Q6zaBWZBGr459yV5HsZyT-kyCT4n_Xc81ZwfAxWBp0AiOhSOUzEOVw9PHGdOOysoYHOomc_7hPISyakm3PPJUOAa-joUYwFuVdRrIXoNHX3TERFcZ2J1-m1KaLeAEQlW7fA-hCjtPMcZ4ZZPmPxs2_AC2TD0PKowr1yBavtWZ6yJlvxU6Wc1Us-Q_C8qjg4QovBGT57UkPsLcZbzAxCsXlL3PO8ASDt1tu8dx5eFd_SHHfLLfGVno4N1_T0WK-tz7RTx-tWXRMhxlqkaianDoY2swoIrICMW4-44qhoYEzMjmsp598igiSGop3gRv-l13FlBMpJnSsTgwBmLVeMfjOZ3FgBWFO42CGwtrFAKDpKcBvGuDoWuqJ0cansKhZCv51qtbP51b_1iS521BBVK2Czyv1fHj_kPyriO1i-26L4PNuPT-fy0ndd6DsHpGqAGR9udqeF0uRulCtEoN8rfk1r2EyWmdLx8Parup_ppRJitwmKNCSYoJUwfNYhhfPCgKLoNq8JiAOfIJnZRsKs90x8KEiHoUa6CCSndXQvrigwMT6now";
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
