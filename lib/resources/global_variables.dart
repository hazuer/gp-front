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
  static String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiODgzM2RiN2U1MzdlMWU5OWE2MDcxZjllNzgzYmEyZjZiNmM1YzRmOTZmNGMyZGQwZjY5NzA0YTc5ZGQyYWM3ZjdjOGZlZjMxNjJkYTJlMzciLCJpYXQiOjE2MzAwMDY4ODAsIm5iZiI6MTYzMDAwNjg4MCwiZXhwIjoxNjMwMDEwNDgwLCJzdWIiOiIxNiIsInNjb3BlcyI6W119.DIK72gljy7No_8Mj3NUQpecN0LvcFrym1B-NnKhEl0YUnTSEtAGM01AEOEf4UVIsdbjO9lI756yCloM4CC_lBcHwNz0r05mDmMc_TD5pdEbNPxrfhxCt4b4C_GRUAaVLQ0AY6iZjSQyvu0MspOhFQ0SQB52jz8iSS2l9LTb67kQC3ML0nCUtkcuumupc9wGU6-XAqklPpBToVV--oIKQekqWEfVmng8siIuZtjqJBH1bsO5khovUC4s_rS_5eszig7xjl0ZLq9TnXmi3iX628F190hUlwBuMPeAq9SreAQiXS0-s71eDIdgiYQXXbejTaZQNYmTCzlTaSNmTB2k4CJ0liatIBszpYIVzMyOZ3-pBcglxNnTaf99IdBO2l3IGa8lzJ-pFI4Mm0USE7NI0W4xmOqYOB1BehYMh4_2RHe2odOMx183UT941ZFONZh2o3IrTHqTO3uZhvb_im20becBZ7XMmZ3ozo2l7UOoLJIHDDNarskq2f-TIz95pluwv3z4yQQNMehUYX0-I4ysRnpKEFqc0j9VYbhKisCDl8OJ5li_o4AlPVOhdFCRduoIpKru4qysE1VLMLZvSOWsG1lxb4uAXBmdXeaQAx7McsdedM3J1UZwiKM_GPxN-HKNM3C-SKGsMEorDxQok-TUDwmnvgIwNTjuQMEC1I8oteyk";

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

  //Maquinas
  static CatMachineModel gvMachineSelectedById = CatMachineModel();
  static DtMachineModel gvListMachines = DtMachineModel( machinesList: []);
  final gvBeSubListMachines = BehaviorSubject<List<CatMachineModel>>();
  Stream<List<CatMachineModel>> get lsMachinesFiltrosStream => gvBeSubListMachines.stream;

  //Plantas
  static CatPlantModel gvPlantSelectedById = CatPlantModel();
  static DtPlantModel gvListPlants = DtPlantModel( plantsList: []);
  final gvBeSubListPlants = BehaviorSubject<List<CatPlantModel>>();
  Stream<List<CatPlantModel>> get lsPlantsFiltrosStream => gvBeSubListPlants.stream;

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
  }
}

final rxVariables = RxVariables();
