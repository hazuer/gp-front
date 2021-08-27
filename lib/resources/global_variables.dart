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
  // static String token = "";
  static String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiOWFjM2YyZTVlMDNjZTQ0M2JjYzA0NmI3MTRmNjZhOTFlMzcxOTgyMTcwNTgyZDE5ZDZlMmQzMmI1OWNiYzUyYWE2NjQ3YzAwY2FjNjRlNjkiLCJpYXQiOjE2MzAwNjk3NjQsIm5iZiI6MTYzMDA2OTc2NCwiZXhwIjoxNjMwMDczMzY0LCJzdWIiOiIyNCIsInNjb3BlcyI6W119.fpG0LWkT1Wt1PynB9_LF0aP2OE2q_maQYVdsJuh_1CMTmmlFdJeu7dPK4c0-eg-9R8tC7_6WIFjTxu5dRGiCBLZQL4McPjhplEUf0m6ojLgR2zPDAiDjwsksmmmxm_f-IkYzERFOFdt7OY-JSWO1uDXxY7psr-EUZATKTigri-3awLOO95rzDE9EVzUtMYsuE1DcgkgC3sQ65qaDbS9EHRjqHh0-_9AQCq6rqmvBWHgrIftoe0kLJloSu-M6e4mFekUIOJ94KeWX_KEIwE07OztEXuZVzlOVYNTrWN7jpb7ZNH_l1iHxvJ7iZyqpYQ69M3pT2Qemdr1xUQmf0wHOB-n6wyTZSwzZgzXToLQUVNw0TF-_RRkTrdolnxM2g_WNueVEX6kCB38L2XKWTnaXIDp6frNmKpRDRfRXAOX-AJ4KnnjmpcWn0p3FTJtwGCzfuJDjn4byXpiTAOnfO1qTJ4OsSts-Rt1opvemdTlt7A4q4TtvgfxQCjCsK0bt1Zjson4gn1B3t-a9jpDMHYKtjPCMFUhunGEGuIaDy6t3tsgh0bRPzdM-i__5w6QpZMH9OXwzim6bw3h7fq3UMGMUFSc1_KEw3fru-UkTR16EI_ZPsTsmfIBSEjtDLioOBxkUhvnvViEQew-zBFiIoGgTp_dUaIWh1Y0wQ_FtqpOl1M0";

  final listUsersFilter = BehaviorSubject<List<UserList>>();
  Stream<List<UserList>> get listWorkZonesSelectedStream =>
      listUsersFilter.stream;

  final listPaisesFilter = BehaviorSubject<List<CountriesList>>();
  Stream<List<CountriesList>> get listPaisesStream => listPaisesFilter.stream;

  static CustomersList clienteSelected = CustomersList();
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
  static RazonModel gvRazonSelected = RazonModel();
  static ReasonsList razonSelected = ReasonsList();
  static DtRazonesModel gvListRazones = DtRazonesModel(reasonsList: []);
  final gvBeSubListRazones = BehaviorSubject<List<RazonModel>>();
  Stream<List<RazonModel>> get listRazonesStream => gvBeSubListRazones.stream;

  final listRazonesFilter = BehaviorSubject<List<ReasonsList>>();
  Stream<List<ReasonsList>> get listRazonesStream2 => listRazonesFilter.stream;

  // Tintas
  final listTintasFilter = BehaviorSubject<List<InkList>>();
  Stream<List<InkList>> get listTintasStream => listTintasFilter.stream;
  static InkList tintaSelected = InkList();
  static ListTintasModel listTinta = ListTintasModel(inkList: []);
  // Cambiar tintaSelected por el modelo grlobal en lugar de inkList

  //Taras
  static CatMachineModel gvMachineSelectedById = CatMachineModel();
  static DtMachineModel gvListMachines = DtMachineModel(machinesList: []);
  final gvBeSubListMachines = BehaviorSubject<List<CatMachineModel>>();
  Stream<List<CatMachineModel>> get lsMachinesFiltrosStream =>
      gvBeSubListMachines.stream;

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
