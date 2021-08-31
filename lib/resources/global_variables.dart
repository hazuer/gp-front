import 'package:general_products_web/models/catalogs/design/designsModel.dart';
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
//Plantas
import 'package:general_products_web/models/catalogs/plant/dtPlantModel.dart';
import 'package:general_products_web/models/catalogs/plant/catPlantModel.dart';
//cat_pais
import 'package:general_products_web/models/catalogs/plant/dtPaisModel.dart';
import 'package:general_products_web/models/catalogs/plant/catPaisModel.dart';

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
  static String token = "";
  //static String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiOGMyMjVhNjRlZjQ4Y2IyYWNmNzU2NzUwMjVkZDZmNTQwOTJiNDYzOTkwMGZjZTgxNzUzY2UzMDA1OTBiZjg3YmU4NDY2NWYzODZlOWI1ODMiLCJpYXQiOjE2MzA0MzE3NzUsIm5iZiI6MTYzMDQzMTc3NSwiZXhwIjoxNjMwNDM1Mzc1LCJzdWIiOiIxNiIsInNjb3BlcyI6W119.xK-6D-NLlXK0CEWXYAjzLzDHurNt_myiRhezgroFVK67IfA7fFm6PJjp2P2sz_nhCu7w7n_2G7nUlWHO8JgWG0Dzxokff6xpM4EVPYsm62V5MrtRYLLuh_PHfYIJfj88bxO9GB_Zc5lO767rcVEf7HcB1ANMLQeKnNdLIi5_3EU-fE-MVchS0XX-ZmF-oE4mnfpxre1WODnmZz21Oj82Ze1A6gjaYuCCb89ncSecXACcFvCaAzGzWx87RHgyEZ3ixUUshkgx5jO6HirNs73DXMWqjRcnsG-1yK-uPJaSuGUbYftcTy-fjewj3nXzFF_EOLLp3p2HxNt1K4K3tJLzDsEjMzt4WoGzt01Fgr7lZTFUhHFJ6zYn9vvn0qN_S2OeyDFZplrthbBIbpSWlko3oyQCU3SCa76P81e3APxfvKf-tu0eN_a2cAtRudwBDryMVWwuJTN8zvFPXXlASVaBzl6Z4WxYeh39fqjtN7QYjBHtsHg5Dncfg4cHqa8lXwnYoNHnfe9lOCAajvJfLya_2eT-7NiKuL4n8wQdjyt4Z9WhWK2lTGefQzDqWukKaw7o5dx7bQTnpsEbqmKPC_clodZa-mxm5BCspXw8pebAjell8xA0p-9VM0jFdOHuRdO4Ixv1oFJY9IrrHzSYOE3IRAQ1_KNI_1h0TWU4bzBGw48";

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
  static ListTintasModel gvListTinta = ListTintasModel(inkList: []);
  // Cambiar tintaSelected por el modelo grlobal en lugar de inkList

  // Diseños
  final listDesignsFilter = BehaviorSubject<List<DesignsList>>();
  Stream<List<DesignsList>> get listDesignsStream => listDesignsFilter.stream;
  static DesignsList designSelected = DesignsList();
  static ListDesignsModel listDesign = ListDesignsModel(designsList: []);

  //Maquinas
  static CatMachineModel gvMachineSelectedById = CatMachineModel();
  static DtMachineModel gvListMachines = DtMachineModel(machinesList: []);
  final gvBeSubListMachines = BehaviorSubject<List<CatMachineModel>>();
  Stream<List<CatMachineModel>> get lsMachinesFiltrosStream =>
      gvBeSubListMachines.stream;

  //Plantas
  static CatPlantModel gvPlantSelectedById = CatPlantModel();
  static DtPlantModel gvListPlants = DtPlantModel(plantsList: []);
  final gvBeSubListPlants = BehaviorSubject<List<CatPlantModel>>();
  Stream<List<CatPlantModel>> get lsPlantsFiltrosStream =>
      gvBeSubListPlants.stream;

  //cat_pais llamado desde el listado de plantas
  static DtPaisModel gvListCatPais = DtPaisModel(listCountries: []);
  final gvBeSubListCatPais = BehaviorSubject<List<CatPaisModel>>();
  Stream<List<CatPaisModel>> get lsCatPaisFiltrosStream =>
      gvBeSubListCatPais.stream;

  static final RxVariables _bloc = new RxVariables._internal();

  factory RxVariables() {
    return _bloc;
  }

  RxVariables._internal();

  void dispose() {
    listUsersFilter.close();
    listPaisesFilter.close();
    listClientesFilter.close();
    listDesignsFilter.close();
    gvBeSubListTaras.close();
    gvBeSubListRazones.close();
    listRazonesFilter.close();
    listTintasFilter.close();
    gvBeSubListMachines.close();
    gvBeSubListPlants.close();
    gvBeSubListCatPais.close();
  }
}

final rxVariables = RxVariables();
