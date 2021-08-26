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
//Maquinas
import 'package:general_products_web/models/catalogs/machine/dtMachineModel.dart';
import 'package:general_products_web/models/catalogs/machine/catMachineModel.dart';

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
  //static String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZTExYzg4NWY3NTRhZjRkNmZjMWU2YWUyOTJlNWQwYjI2YjhmMTE4ZTJjZjIxMzU3N2VlZTczNTFjNGIwYzQxODcwYjkyMjg5NjBlYjg1ZTQiLCJpYXQiOjE2Mjk5OTU1ODEsIm5iZiI6MTYyOTk5NTU4MSwiZXhwIjoxNjI5OTk5MTgxLCJzdWIiOiIxNiIsInNjb3BlcyI6W119.n_L0qoKcm_y8XiW1QuO8afYKIpDdtwYyGNEpzhp-p7ti4KBUZ566Q_-aS-Usta6KLRON42cK4Jpgxy8hWSRh8MOm2wOkB6lGbiLOraq4UklaurEFunOo2ilNzzZwRas2HO720EEbeOnqljsiN6Y3J0GOmh0g5JI9j2_efyxRhNeTRUpWiYNXlIqrFkeQvQB4FV5kXXyhYblcFJWcznx8SMWuR7y1drglxSJsQdQ5pHVPAsD4GOP9ls3oBPIFabHZ5UTkHweF0_Ke-kqi8z1s3lT-vIujcqFasGhfa4PynS0ibgf6PhRct2O9EPGNOAwnMf1aoGD-Zc6-CjLtv8Vx6VFPlbqn15148iLhHbmZtvwFrTYq2oaVPtaLw0GcfgjF7s-gRqUHiq-DPGd7Oy_kmhyuX6SvxMBT8fHznD0v8jvzFLaS5XHRSPbYFuDGYf-oBtyUmanm8mN8xi09co7mOmfEiK2EM0l3Ln1SbQK3odNcbPA60H3uYP5EANd9oRYDxhRHwQjS6ejClzJrd863Tsw2wC6YvhBmFiHp2JdqVY0gAwc35hy_J3N0vBawwKzi9U84Lei4xhtHvpVNj8AV1R-46wcYqNQixUYemwSyHMgFq4WTYnC-ONyf1KuISEjgUJMgclpDrtegN9kelO96B_CXym_LyR3sLmktEYt_Z00";

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

    //Taras
  static CatMachineModel gvMachineSelectedById = CatMachineModel();
  static DtMachineModel gvListMachines = DtMachineModel( machinesList: []);
  final gvBeSubListMachines = BehaviorSubject<List<CatMachineModel>>();
  Stream<List<CatMachineModel>> get lsMachinesFiltrosStream => gvBeSubListMachines.stream;

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
    gvBeSubListMachines.close();
  }
}

final rxVariables = RxVariables();
