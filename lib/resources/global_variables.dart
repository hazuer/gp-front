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
  //static String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNjI4YzU3ODM4MDEyMzVhYjA5YjI2NTUzZWUzZmQ2NjU3ZWIwZDY1MWFhNmQ5MDY4OWMxN2YwZDQxMTcxNzJlMGQzODhjMjliMTNmMmU1OTAiLCJpYXQiOjE2MzA0MjQ0ODEsIm5iZiI6MTYzMDQyNDQ4MSwiZXhwIjoxNjMwNDI4MDgxLCJzdWIiOiIxNiIsInNjb3BlcyI6W119.pBwnmtropmklqbv7gBzhIYeVB68QIbXFnxqMh5--8qAB-SOaQJLxZ2Qcy8sGGjpPFmr3ZUWF_bVt-ZNw_OBIUOuXeOYXhlDvT4Yml-Jx-XVAQf9Ke_4r3hyKMgtVa8Urt5qLn6Uef090vHVPTqo5U6TTARe97rl4zuXK_H4HB7q49M4D5OmMaSk4Fo2wLWSNa6buX-RDNpDa4Mwsbc55KtVCx9BWXpzS_3eOZ193qeh0Da8p0pPKMRxq-bHh2PA4wmnljmnDtiIdLDcQSylfwGPsvGCVxd7YcBSqnUucEAuUalXjRg2yx5H4_pZ9_0N-GFLBrMHV6f_QS68eqqp4izkaPg7J_pAR9mEZwvgwaEVIjR8gYU8qxo5twQ6vaw9WskUSUG5Lmi6oZWp0Q8OHdBXXCguczv4jvQag0BhNrwBlAaianDuSnF24sQ7O1VK92kP3kRmuHFgcCF5ei0p0fFaiOTSKT4kjp1LAN_kUPIjqs9ljLI3iu-wwKuBZP2yLCRdq8DQHkWLzWoBUKk2uMMZAN3NL7FFSEEcHjys8CXIrEcO4DSu8qouWiAhJaftuBDsgUjL-f3jybhSnIEhTcxsu5EgYtWcxzTrTCPEmSWgFtHiryR4uPTRnVTz_JnRl0Vtp4cDU_UcvnlX6tkmPROmJ0YieDIMmHBY4AzWCQwc";

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
