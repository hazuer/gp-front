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
  static String token = "";//"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiY2Y5MTQwM2Q5MjI4MTFiYzZiOWVjOTk0OTdhNzZiNWE0NTVmMGQyOThlOTI3NDU2NWYwOWQxZGRlZTllMDlhZjNiNWQ3NDZjODEyNzQxM2EiLCJpYXQiOjE2Mjg4Nzg1MzcsIm5iZiI6MTYyODg3ODUzNywiZXhwIjoxNjI4OTY0OTM3LCJzdWIiOiIxNSIsInNjb3BlcyI6W119.qXSGVN8lbKvStr6NvFEBzeqNUHNqLFLpW89CkmmM7kAvL9hPQdO10WaSxivIStAyEpGlSn-TPGmrPCuZiySayL6x0HdjEM4QH4ZJpbJlVs4aGqcBK-FsXi9p5O05dUtDmRU1cJTG0ecrKCwAtas2yAoiQeLG_hd5CfOE-H7x4PVBxdD84v-oFmPMuu1ermCU5TcezeHXPO84lTFCMGIYKVwLi2-D_DInoUdLBWmT172V0-ZQx3qX-NXjgdxoJbW7XO-GZec__T3LWGXisIY8-s12piIqn7l6KTYjVOMHJzxYcuyfNwrjqRumUmMx28gLlAyd1L5vyHSOtv6RO3t_-pPeThecT7zoI6Hk5T6IraCrRp8tr4Hms5Oktop1tZnicj2yXk3pZ5tKEPvCjjYYEEPr1pgpMszawrz3L43kPVN0l1HFyeWkVbKkvW2RvWVBPNSWbSaAFZZjrOmZqbRlXbIM1HMEPyL09-TyP71A9G2-JEE7eXOGVtJ5XiCa9K3vpWTpwye1bxayWQQ-tolylV0kzqlhsMyiZ18DO0dG6KOwytS3VDRWOCg0AU0li0PnyZwKi2EyaqJkdw_ohDaHGqSrIx3rcwcYBrEBXZH9t9Ax3__jfsVFoZHb35BkxLGhNyDwBhfpwcqHlLAx7LtGVMp4CNl0TMdVZoz2pkfsbAI";
  //static String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZDJjNDhmMjZkYTgzNjFiYTllNWY1YzllZDIxMWJkMjI4NzQwOTVkZWY3MTEyMzQ1OThlODIwMzk1NWYwZDg0OGZjOTQzNDIzYTBjMTNjNWEiLCJpYXQiOjE2Mjk0NzkyOTUsIm5iZiI6MTYyOTQ3OTI5NSwiZXhwIjoxNjI5NTY1Njk1LCJzdWIiOiIxNiIsInNjb3BlcyI6W119.hSSMwbJG-YM6xFNBj00T1T4ktptsbB6gspAqH6dmcK5z3Wh8-BIPcgmKccUoUcJyLb50pRiaFZfZ3bmwTasvjcqrinZc3KL2aYWHHbWGHB1HGqh8WvtxpQ8x9ADMEbNmD1rXgDy3RNcw-e-YFZXb36RhRKyv7Xd1YUOfGbNR1ZJ3_3Z7H6EHMoCcdxkq6Th0QtSZAb5Gj2XPO8ak4EG8iufNb-8rvIPl-0kVAHhoWj67_hZllPPG1TBH2PJSovsM7X6NNPaFALyifppeVZmLvybCGzvma4UVgv0zUf6pNuHb0tT50YFIxVLQ5LJFWJkXIcyhNm8IEdcqKuF5v5iL69mIaOjHOQNYzb0rM9EA4srt1bJfKRZBe5AMqSEQETwzUeCt1w4Wna4eQRUsH3TpunfIQuJbpGIiysZdNaYEFAuzIOtRIC3-cywuorr6TO9cgAf8Fgp1hqI6F8u71VZToq5Fpbq-OKGPX0yqoO0nt56psXV1NPgqOuL2dYEsyNfIYblIjBXwk7NCoxxGjoolBjnZ47R_vhE1vCa_XiOOQhk_G_OFkbXzBgiteovEQwh9tKNVmu2iU_wYKow0p6xKhwhfx_9sNNTLxPmtd86QTPs_gOA0k3qvDZ4OkO0i2ypW69O5iMNBYHQg2ApcSZ8dJ4MIvf2kHc6U_J_oibd_EL0";

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
