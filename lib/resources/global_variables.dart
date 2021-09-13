import 'package:general_products_web/models/catalogs/design/designsModel.dart';
import 'package:general_products_web/models/cliente/list_clientes_model.dart';
import 'package:general_products_web/models/customer_model.dart';
import 'package:general_products_web/models/data_list_user_model.dart';
import 'package:general_products_web/models/catalogs/pais/catPaisesModel.dart';
import 'package:general_products_web/models/catalogs/pais/dtPaisModel.dart';
import 'package:general_products_web/models/list_users_model.dart';
import 'package:general_products_web/models/login_response.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catCustomersOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catDesignsOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catMachinesOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catOperatorsOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catStatusOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catalogsFieldsModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/ordenesEntregaModel.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/models/catalogs/razon/dtRazonModel.dart';
import 'package:general_products_web/models/catalogs/razon/catRazonModel.dart';
import 'package:general_products_web/models/search_user_response.dart';
import 'package:general_products_web/models/settings/ParametrosModel.dart';
import 'package:general_products_web/models/catalogs/tinta/catTintasModel.dart';
import 'package:general_products_web/models/catalogs/tinta/dtTintasModel.dart';
import 'package:rxdart/rxdart.dart';
//Taras
import 'package:general_products_web/models/catalogs/tara/dtTaraModel.dart';
import 'package:general_products_web/models/catalogs/tara/catTaraModel.dart';
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
  //static String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZDE5N2ZiOGI4MWRlNmJiZjA0YTkwYmU3NWE4NWEzMjU1OTg3N2VjNzdmNTAxMjQ2NTc4Mjg1MDBkNGQ3ODNlNTViNTQzMWI4N2E1MGZjMjEiLCJpYXQiOjE2MzExOTMwNDgsIm5iZiI6MTYzMTE5MzA0OCwiZXhwIjoxNjMxMTk2NjQ4LCJzdWIiOiIxNiIsInNjb3BlcyI6W119.ernZZO78zhjrg1VFAtp7L6xoYpJDcY-5SwumX6And3HowITIyw7rxfHxGqCH6y_hd9IjreVvLoX7rLjYYF9-Ww3l8S4vIKO0i3VYPI1iDY2gXywv-gVQzBw6gUD1q9oXfda9i7YNNb_lW6i2yykNx9IHUbZBBwPZ3sgIFSZL5VlcZR0AH3vxLnx_0emiz8_lfKKIFEH1z0q3YAtqrkIRqA7MBXJWkVOrcCLlgez7uI3Wj_gtRKR8Uxv2JFEMQv6trNl7kCqVkO_ZYOXWtB_7Fc35y-aB2Ow_Gv4khWj5LKHZleU4n3kWbs7aWdKc7B_tl6I-G9QRUCcRuwKPvu9KSNDnRKM9Fc2Zb6DlstSwRpj6H6Y_mIHaVX4JEwubL3UT4bvQz4UzJM-4OMUSOXiJd32pJmsh1i2SSU-POyZDRQKzvtePOG8lR0QPjQDh8hZYfGzITavbTaHmiDv0yycKoju6dbsMJ02NuyCDivJOLZvieG06bJ7yQvUvtCJnZ9e9J58gDPeKtmcNlrksargskUO71iOj93WHlrvW_-c1d8g6zg4V5xmLtBdPkZIodoHLZBLOaOiRrXJdAhv1jDd0amIDqGyy821gZK6Q1nlWbTfWHWk2mgbq8Jw3ay-WHffS-1CQhN8yljENTiPBgqf_4YUDrD7xs9l1fLw7AXnHT1s";

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

  // Parametrizar sistema
  static Map<String, dynamic> initialParameters = Map<String, dynamic>();
  final listParametersFilter = BehaviorSubject<List<SystemParams>>();
  Stream<List<SystemParams>> get listParametersStream =>
      listParametersFilter.stream;

  // Ordenes de entrega
  static DeliveryOrdersList orderSelected = DeliveryOrdersList();
  static OrdenesDeEntregaModel listOrdenesEntrega =
      OrdenesDeEntregaModel(deliveryOrdersList: []);
  final listOrdersFilter = BehaviorSubject<List<DeliveryOrdersList>>();
  Stream<List<DeliveryOrdersList>> get listOrdersStream =>
      listOrdersFilter.stream;

  // Catalogos en las ordenes de entrega, tienen modelos propios para
  // manejar el tema de las validaciónes por perfil desde el back
  static CatalogsFieldsModel gvListCatalogsFields = CatalogsFieldsModel(
    operatorsList: [],
    customersList: [],
    statusOwList: [],
    machinesList: [],
    designsList: [],
  );
  final gvSubListOperators = BehaviorSubject<List<CatOperatorsOEModel>>();
  final gvSubListCustomers = BehaviorSubject<List<CatCustomersOEModel>>();
  final gvSubListStatus = BehaviorSubject<List<CatStatusOEModel>>();
  final gvSubListMachines = BehaviorSubject<List<CatMachinesOEModel>>();
  final gvSubListDesigns = BehaviorSubject<List<CatDesignsOEModel>>();
  Stream<List<CatOperatorsOEModel>> get lsOperatorsOEFiltrosStream =>
      gvSubListOperators.stream;
  Stream<List<CatCustomersOEModel>> get lsCustomersOEFiltrosStream =>
      gvSubListCustomers.stream;
  Stream<List<CatStatusOEModel>> get lsStatusOEFiltrosStream =>
      gvSubListStatus.stream;
  Stream<List<CatMachinesOEModel>> get lsMachinesOEFiltrosStream =>
      gvSubListMachines.stream;
  Stream<List<CatDesignsOEModel>> get lsDesignsOEFiltrosStream =>
      gvSubListDesigns.stream;

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
    listParametersFilter.close();
    listOrdersFilter.close();
    gvSubListOperators.close();
    gvSubListCustomers.close();
    gvSubListStatus.close();
    gvSubListMachines.close();
    gvSubListDesigns.close();
  }
}

final rxVariables = RxVariables();
