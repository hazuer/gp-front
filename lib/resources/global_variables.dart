import 'package:general_products_web/models/catalogs/design/designsModel.dart';
import 'package:general_products_web/models/cliente/list_clientes_model.dart';
import 'package:general_products_web/models/customer_model.dart';
import 'package:general_products_web/models/data_list_user_model.dart';
import 'package:general_products_web/models/catalogs/pais/catPaisesModel.dart';
import 'package:general_products_web/models/catalogs/pais/dtPaisModel.dart';
import 'package:general_products_web/models/list_users_model.dart';
import 'package:general_products_web/models/login_response.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/models/catalogs/razon/dtRazonModel.dart';
import 'package:general_products_web/models/catalogs/razon/catRazonModel.dart';
import 'package:general_products_web/models/search_user_response.dart';
import 'package:general_products_web/models/catalogs/tinta/catTintasModel.dart';
import 'package:general_products_web/models/catalogs/tinta/dtTintasModel.dart';
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
  //static String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZGNiNzhhZDEzZDBiOTlmOWViODIzZTM5NDExNjcwNjgyY2Y4MTQwMWFhY2Y2ZjBmNzUwZjBhMzlhMTA5NWJiOGYxODU4YTM1M2I2OTQzYTkiLCJpYXQiOjE2MzExNTcyMzcsIm5iZiI6MTYzMTE1NzIzNywiZXhwIjoxNjMxMTYwODM3LCJzdWIiOiIxNiIsInNjb3BlcyI6W119.mrrjZgK1iGzidCjvXeaxX3muxeHFgmIkWMwnTdHLns6I5lFNJrV3eqwmnrg_lbH1u9I5svouJtFP_4Dki5LBQwgVHdvOgWwiweOq3KJMkVWIbN_KJshnZNlrKmUXAMFcI-o4jkXiIt2CrdfT6Jt004meHr6lv8ma3FRmibP579scB74DWTjjUmlHaCMLd1CIjxkdAyOMB9RKYbnCeMhOPFPImlbAPP1G0h3gtlmk1CqhuOgaZ5FzEcY-JcAaiL1i0Un-RKVVKj5TTqtMkyIsUvld56b8ZcrS0uNFVYoYHI6U34hhqj9_NUtjb9pF96b-m_hvN2x3YmhKg-ZXTjmHcg2uDmmtzUPL15e8znpop09jhfOwdJmTpbEIbHEPzGviGpgie9Ut57tGx3t0suwUGSNRJSONY90mYVY85fi6BYw-KXF-RE3_BtsP_L7Exnf7OP9v023EI6sxFusiTTUU30O4tgCZuHVfDD2GxCO6hWhQCOUWsniFfhmplKnt8e4tbjofkrru2zPYcx4POeLYR0STlx0ExirEWIzIEZjjniyycV072Tc6wLfc3Ta_1dgyTxnM2wihGuKYBHKkEvRKWOycTUBreOfPWqW-ncjrhjjVRZ9m84afEG1iIecfBMltls3FMj-uCuDTluvSL6Ya7lFPgr-5nUYJELOp41ZJZqU";

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
  static DtRazonesModel gvListRazones = DtRazonesModel(reasonsList: []);
  final gvBeSubListRazones = BehaviorSubject<List<RazonModel>>();
  Stream<List<RazonModel>> get listRazonesStream => gvBeSubListRazones.stream;

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
    listTintasFilter.close();
    gvBeSubListMachines.close();
    gvBeSubListPlants.close();
    gvBeSubListCatPais.close();
  }
}

final rxVariables = RxVariables();
