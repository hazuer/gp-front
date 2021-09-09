import 'package:general_products_web/models/catalogs/design/designsModel.dart';
import 'package:general_products_web/models/cliente/list_clientes_model.dart';
import 'package:general_products_web/models/customer_model.dart';
import 'package:general_products_web/models/data_list_user_model.dart';
import 'package:general_products_web/models/catalogs/pais/catPaisesModel.dart';
import 'package:general_products_web/models/catalogs/pais/dtPaisModel.dart';
import 'package:general_products_web/models/list_users_model.dart';
import 'package:general_products_web/models/login_response.dart';
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
  // static String token =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNDU3OTc3NTY4NDJkNTlhM2JjMzYzM2VjODkwM2NiNDM3YTE5YjJhZjZlOTI2ZDVmNzQzMGVlOGEyM2IxNmM5MzZiZTNhMDQwYmIzMTZlODgiLCJpYXQiOjE2MzExMjMzNTEsIm5iZiI6MTYzMTEyMzM1MSwiZXhwIjoxNjMxMTI2OTUxLCJzdWIiOiIyNCIsInNjb3BlcyI6W119.WQYnwfApEg3vrFzZcnoQgMQO-l65FuKTA3yWNzxADuLba4qkXDnXGsfYRKaEnIJzwtPJL9T6GD3sz8rFj-Aqb_aZyjr5Txi6MrFsTrWzIrqHNRsRSCwo5Oxl9DY3vQmXU9rmSPyhvmmyODI_ZQkxTA8FvyzAEIHlq62LfXR2Ksx7mCqAGxoIMrAEqf6xKa4HJoHd7oJbnZK2WksZuiYkZ9QWw2dGHKYgjlufRb0VILvPfYmoJQUhhnoxaKuYuCN5iBb0wneqOGAkflme83WUg7a7bPoEtCXDKqBnFTj4p5h_bVVtC-Di6wdQZAdihf-7Vc8FdcJtojszNPCXxYWx4AhNNiip0XgYxyS40VubCIfuC35hBNGcqWwJETIkNU7JMRo1Bz0CHhOda7BjR_K68_l2V274FXAl1F9lX6Cw8smcuZd_7bZ7G7oE66GihX_WTk4qGy8fgbJSopBQBPBpAeJy2iBApRWMT2KWvynJHiLF4uTxM9TSi9RabeQ484p80HNPiOri02qZccQLr71VM1cSox2dubKtk_FDnA7IbP94gdK0ZV03ZmWJtvc6hu9a3kW7bN8stdvCNO7kTQAZdbgjYXQ_4GUdOl72K-3LTYm1kGgvtqiwa4j9ItsZQMr0G2pcJbT0QQboeqmAbR2yBkXIXotw9QIU_t19hkCU4iI";

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

  static DeliveryOrdersList orderSelected = DeliveryOrdersList();
  static OrdenesDeEntregaModel listOrdenesEntrega =
      OrdenesDeEntregaModel(deliveryOrdersList: []);
  final listOrdersFilter = BehaviorSubject<List<DeliveryOrdersList>>();
  Stream<List<DeliveryOrdersList>> get listOrdersStream =>
      listOrdersFilter.stream;

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
  }
}

final rxVariables = RxVariables();
