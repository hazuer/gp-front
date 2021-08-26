import 'package:general_products_web/models/cliente/list_clientes_model.dart';
import 'package:general_products_web/models/customer_model.dart';
import 'package:general_products_web/models/data_list_user_model.dart';
import 'package:general_products_web/models/list_paises_model.dart';
import 'package:general_products_web/models/list_users_model.dart';
import 'package:general_products_web/models/login_response.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/models/razon/dtRazonModel.dart';
import 'package:general_products_web/models/razon/razonModel.dart';
import 'package:general_products_web/models/razon/razonesModel.dart';
import 'package:general_products_web/models/search_user_response.dart';
import 'package:rxdart/rxdart.dart';
//Taras
import 'package:general_products_web/models/tara/dtTaraModel.dart';
import 'package:general_products_web/models/tara/catTaraModel.dart';

class RxVariables {
  static LoginResponse loginResponse = LoginResponse();
  static List<Plant> plantsAvailables = [];
  static List<Customer> customerAvailables = [];
  static List<UserList> listFilter = [];
  //static List<CountriesList> countriesList = [];
  static UserList userSelected = UserList();
  static CountriesList countrySelected = CountriesList();
  static ListUsersModel listUsers = ListUsersModel(userList: []);
  static ListPaisesModel listPaises = ListPaisesModel(countriesList: []);
  static ListClientesModel listClientes = ListClientesModel(customersList: []);

  static DataListUserModel dataFromUsers = DataListUserModel();
  static String errorMessage = "";
  static SearchUserResponse userById = SearchUserResponse();
  static CountriesList countryById = CountriesList();
  //static bool isEdition = false;
  static String token ="";
  //static String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMmE5ZmQ2YTJhODhiZDczOTQxN2UyMjg2Y2VhN2E2N2M2NDYyZTI3OWZlMDA4MGU0YjI2NjRiNGU1YmRjOTE1NjMzYmU3Y2Q3MjdmNzVmMmMiLCJpYXQiOjE2Mjk5NTEwMzgsIm5iZiI6MTYyOTk1MTAzOCwiZXhwIjoxNjI5OTU0NjM4LCJzdWIiOiIxNiIsInNjb3BlcyI6W119.ZmefRpqXBhujkPDQB-0kZXykxO2lebaWsKKLri33ZXXT0xjLvZf_vw0sxjg8eDckhcg9F-s8t6iG3B5br-W9o59-Dw6B9_zh1OF8vxKbKSkTBJeLOgB7vdyYjp36AuAXI2OLKmMy6qwqpw0kxUzm6mT-0FLd3O9x3QINFjQS7y5sWUrS4KcFXsrwG9D3fgORXgVoMeGuygERoiY9rAprRu5K2WzaF0n3h5y2dQhOFuobjvYo3L2h3JUCHCnwh4fLt1pIjOMSfusK2NbaqjVJ-QPOM7Yhq9HZyMJaf3G2iNz94drgWZpCii_IG0HW-WlXXfQKSfEmnB-laXLFUgqxxkS5hfaXZKkP7nIXrz8HTza_k_FQ0i_mGopNzyuomJpgfTV9IVNIDxj-aWiXffEPuVk_o2TQnNU4qchraRtsiX3kRR9_0-f2TrYuxZXsvP0sPxxqaDeLIGdIeEVkdMB94ijiN_SlU-i-ZHBnxom8V_motoNVWUDNav4n8DRGuG7tsSAQSNB3lObXIyY_8mqfiFYdQkEmJ5V45W2bTwkSs0hZwoO375rZ6VhXEqeSP7VLHd0prGvryf3SBMF4qK3NMMh6N54KOTpG-OcWKWGJMZbXHZLx4S13pThjJoRRWI4vw92wY0pLxpfr2uicdyN7C2EELK-3pis-k04GlmRVewY";

  final listUsersFilter = BehaviorSubject<List<UserList>>();
  Stream<List<UserList>> get listWorkZonesSelectedStream =>
      listUsersFilter.stream;

  final listPaisesFilter = BehaviorSubject<List<CountriesList>>();
  Stream<List<CountriesList>> get listPaisesStream => listPaisesFilter.stream;

  final listClientesFilter = BehaviorSubject<List<CustomersList>>();
  Stream<List<CustomersList>> get listClientesStream =>
      listClientesFilter.stream;

  //Taras
  static CatTaraModel gvTaraSelectedById = CatTaraModel();
  static DtTaraModel gvListTaras = DtTaraModel(tarassList: []);
  final gvBeSubListTaras = BehaviorSubject<List<CatTaraModel>>();
  Stream<List<CatTaraModel>> get lsTarasFiltrosStream =>
      gvBeSubListTaras.stream;

  // Razones
  static RazonModel gvRazonSelected   = RazonModel();
  static DtRazonesModel gvListRazones = DtRazonesModel(reasonsList: []);
  final gvBeSubListRazones            = BehaviorSubject<List<RazonModel>>();
  Stream<List<RazonModel>> get listRazonesStream => gvBeSubListRazones.stream;

  final listRazonesFilter = BehaviorSubject<List<ReasonsList>>();
  Stream<List<ReasonsList>> get listRazonesStream2 => listRazonesFilter.stream;

  static final RxVariables _bloc = new RxVariables._internal();

  factory RxVariables() {
    return _bloc;
  }

  RxVariables._internal();

  void dispose() {
    listUsersFilter.close();
    listPaisesFilter.close();
    listClientesFilter.close();
    gvBeSubListTaras.close();
    gvBeSubListRazones.close();
    listRazonesFilter.close();
  }
}

final rxVariables = RxVariables();
