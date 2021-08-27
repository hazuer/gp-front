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
  //static String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZGQ0MDg1NTI4YTEwZTkwMWJjZDE0YTk1MWVlMTViMTRjOTkzOTc5YTZlZGE2OWEyOWMwNWFjN2M4ZjA4OTZkZmI1OWUxYjk2ZmE1YjRlZTgiLCJpYXQiOjE2MzAwODI2NTksIm5iZiI6MTYzMDA4MjY1OSwiZXhwIjoxNjMwMDg2MjU5LCJzdWIiOiIxNiIsInNjb3BlcyI6W119.YRCY6NA7a5uGO5VXlN0JinMSZ7aYeTiYmsunyBQt4dvQ3W7QRtNGsMxAfVHDVdmU_n18QL-AXPlJI8JEiDeUfgOQ6CQ_xB9C7oAStCTi4yyHf02JMN4r2GT0qT1QdimKcglUwrlve2FCLgLpr2sZz9PXJhg7K5g7J2Q3hEvy-IazpAn8x1R8q7m0UY-j0RGC3zu9KcgfvfQGQ5lMqLFbTFTmd_QwDIHb_d2sDTijyTzidyBYV00Hv1oWSbs2pS7lxUvzcHAm3hMF0yr4E6iTaAKvS4V-rgn6p2Ww4JbvV0CEtabXiU2XGi2VUFwR4bUl3dcA29y6VYe6rbJ1nlL5oXG2IpJLyw1kk6IKG60CoFRl0Gw38EI2pP7_Akige8R3VNz32qDw87CLaZBbGEX83prpmbDCij7ROs6gG5NBtjNSTBRfQHUK2F6FZkYg3johI9MSkaMK5QWQPZLpcfwTbS0Zhz7ArTgedZGOZBd4_MUG8t5lb1WmW7rwRdsrIomfvggoJ3AOujt9Xge9RlxJmYb1gA_4pxOnzLl4PYY_GI5i5RPC2aE3yUZSbAGdDBqqW_s6_-lc67d9w5dAUPLN9evPn-Rdl__HC2t9sqIVJ8QhHCyfRdwZpdpTMk8xcdeFwg3x7eHWXBJ49_SVJvoCJTLmwKfdGbLudzUizW2EJtM";

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
