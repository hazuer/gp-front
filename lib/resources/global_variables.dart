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
  //static String token ="";
  static String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiY2U4NGU1YTA3YjdkY2RjNjRiZDRlOTcwNTlmMmEyNjk4ZmFkMGYyMDM1OGExNGQxMDllYTg4ZjU5ODVlYjNmNGMwZTYwMzdiNjcwMmE5NzEiLCJpYXQiOjE2MzAwNzkwNDEsIm5iZiI6MTYzMDA3OTA0MSwiZXhwIjoxNjMwMDgyNjQxLCJzdWIiOiIxNiIsInNjb3BlcyI6W119.Qmo1sld_7TD3eNQcezSaY4QBqD0UIq-RjGVCtU0zGyXlrh172A19KZbMOIknMWTJNYRo6zjNJGWyD5NZHolduvw_Xl4VPxQLeKaVpolnLcpDabG9hby-ZpvU_HIyLKUBnEO90rsO8fBJC3h_ZKraRPlyOMFxW0r-gIXhdRG1Dn6MmpHgqS0_lvtvaJRx7icb36j0TrQI33ZdNaC67vpi1IoD7qly1ayKnL8QRe2t-HJZo310Ivy75YFCgg1I1ct-TUE6lRb4o23hZAGZVLHo9mqFVxKfWqgj1Fv6MWGSsP7cLn6369k0JUq7LxBQr9Sxdv_Rl_j3xksNpK6PnW6_ZKLzc_EyKul-RhildsOleR6FhZ3heoWihTZShxCegx22605i_B7oR_EM0wIROROmR29wI-qKYra3Ul17e-OfY0ZVIabOlZw821QIZCxpjovw5KdMUFFKh2mJ4e3M0hDcSUJ1G97yFv1GnwRIRFgrLXRoYiu1HOb6OrdI-28uiEh13AWp_GPBI-HFppPmyayg8Odb0x3blbvp2yscSSYbeYUUZfltcbsASwUqzib3tauBzJNifFHTnGUdo_1uFP6L75vVextceD4Ig-VkreREaZ5pdnBA0v8N4cJysWAaYABwP1CXRle5SBKTY5crdHEbBUw_yT5zJRoHR6DxTCFbI50";

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
