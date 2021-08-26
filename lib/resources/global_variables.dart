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
import 'package:general_products_web/models/tinta/tintasModel.dart';
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
  //static String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNmU4NDQ1ZDBmYThmZTg2YzIyYTYxNjg4YzkzMGFlMjY5ZGVlNjc5NTZiMTczNjVlMmRmZGVmNTc1ZThjOWM3NDU5YTM2ZmI4NTM0MjJjYTIiLCJpYXQiOjE2Mjk5NTc0MzAsIm5iZiI6MTYyOTk1NzQzMCwiZXhwIjoxNjI5OTYxMDMwLCJzdWIiOiIxNiIsInNjb3BlcyI6W119.Q3QhwqiWSV36shvSwxjDVj3vGP-tSbmQ_eub_qNnxPHRtxd5vADzVxQF9-QMaqcGQ5Gt1I7UuZisnLtC_-0BGHm2PpUNPq9rCpTSJXDx2AzujCCJcOX8OM0c1WQV_VneKpi3doKIEoP4d4J0WX-faAmRcGkXtMWKCGH2QxeOn_dT8m9galJF3nVJukTqQY3zxj-kx4nOXZZ5iJ7kCgn3__sWVbpApSfuAJ9xF_c7M9C2RkIlvG4rqCYwkpARqX2d42Us8d6UYj6zYeHwvpiAc9prjFs8myIdcOYtUbT7_tXzZmAAD4bUaGwI3SzynDdsha-XvF8FUnC7l2vrRTamS1vXcvpXPIalEND2CJNWaGVUAHBnBsbK12KxXamPdc1c1SorcuWekatQ5kJ8DOxxveZtHzrsdhZvqgBIoHRWmuc2uDiaH96agOdnBQZQU648NQnzmTydWQx175VshnyijARI7gSXZbavCGRiPaSCYF2zKTym-yQ_VAw-iy9L08s37fJpBuUXu-RznikhBj8fRHiqa1fZyDCtl5YGurwN70s2-PskvftXg7bOd-xkrJLVYhPWXTZDfMX3YF7gDyAiSu998_hmhNaoPlWLGxjFW5kPaZUUGB2TPHmIgfzXLUlooIuVXpHAO1cYWAn9feTcFzlPNNdq7s0p3JWBB95nmZ0";

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

  // Tintas
  final listTintasFilter = BehaviorSubject<List<InkList>>();
  Stream<List<InkList>> get listTintasStream => listTintasFilter.stream;

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
    listTintasFilter.close();
  }
}

final rxVariables = RxVariables();
