import 'package:general_products_web/models/cliente/list_clientes_model.dart';
import 'package:general_products_web/models/customer_model.dart';
import 'package:general_products_web/models/data_list_user_model.dart';
import 'package:general_products_web/models/list_paises_model.dart';
import 'package:general_products_web/models/list_users_model.dart';
import 'package:general_products_web/models/login_response.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/models/search_user_response.dart';
import 'package:rxdart/rxdart.dart';
//Taras
import 'package:general_products_web/models/tara/dtTaraModel.dart';
import 'package:general_products_web/models/tara/catTaraModel.dart';

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
  //static String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZjRmNTYzZjI5MGUyYTg2MTRlODI3MDRjMmQxNDc4YzQ1ZmRiZDM1NGFkOWRmZWRkYTY5ZjYxOTcwMDMyZWJiNjI0ZTVjZjRmN2NiY2ZhZTMiLCJpYXQiOjE2Mjk3MzEwNzksIm5iZiI6MTYyOTczMTA3OSwiZXhwIjoxNjI5ODE3NDc4LCJzdWIiOiIyNCIsInNjb3BlcyI6W119.W_XSibTsrrry5ki4kH912e72TQgfUKQ_xB0jHI1CzNVidg0od7l8XNKR2Y7JlR86QCbeZ2sohJba4x2FDqCbiAgot08XVbvt9rNM3z71XNyRu3gSdYurmdGNd_avbgxwJjXW5GcSzwd-I8vxRFH_-RScXavU1Lt2SePQYbGkyUzVcb6XYJqI5Ta8ZPRiy-qCwlAP4fNv00ESIoiaJUVxZ9WAWVA0tdocUakMbuJ66Xnkl5g77e6Fho2cEUUfJRMGgdedMct5pQcYI1bIljp74IkpjSQd3y_rm0stjk7RkozjTGyCTM1hzJonZ8VM4VyW51Dm7hCmB8_6F3ET2ApInbFRfT7W6o5m_3Lo98___E5sFi65eZCEDVVXrSMxkqAFxJycYoYZEbn3CR5IOLstIfzbXgkORCiabEACjQ8JxHaaAxqeD8DmusFEOUZDgI7oSn19WFd5I1w4e_xc8XPLq8khji6aclkEyarbkKaFyfXXKEt-485xRp8oYIgLQ9HdfDIl_GiYxZvDZTLK4PDQKQuPFZwKsC_Rsd8NaTK8PzvqYWtNh_NOCRHByyyOYz6VnzRhJ0XkGLWfdA2C3rI_7VgElstOMIBC1wf9YXcSBcDHAmVR37nQjKCOSSXVyX_QxsI-YXfV5HUnHj896pBTwAQwONvAsd4pqDeTCJRSqzU";
  //"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiY2Y5MTQwM2Q5MjI4MTFiYzZiOWVjOTk0OTdhNzZiNWE0NTVmMGQyOThlOTI3NDU2NWYwOWQxZGRlZTllMDlhZjNiNWQ3NDZjODEyNzQxM2EiLCJpYXQiOjE2Mjg4Nzg1MzcsIm5iZiI6MTYyODg3ODUzNywiZXhwIjoxNjI4OTY0OTM3LCJzdWIiOiIxNSIsInNjb3BlcyI6W119.qXSGVN8lbKvStr6NvFEBzeqNUHNqLFLpW89CkmmM7kAvL9hPQdO10WaSxivIStAyEpGlSn-TPGmrPCuZiySayL6x0HdjEM4QH4ZJpbJlVs4aGqcBK-FsXi9p5O05dUtDmRU1cJTG0ecrKCwAtas2yAoiQeLG_hd5CfOE-H7x4PVBxdD84v-oFmPMuu1ermCU5TcezeHXPO84lTFCMGIYKVwLi2-D_DInoUdLBWmT172V0-ZQx3qX-NXjgdxoJbW7XO-GZec__T3LWGXisIY8-s12piIqn7l6KTYjVOMHJzxYcuyfNwrjqRumUmMx28gLlAyd1L5vyHSOtv6RO3t_-pPeThecT7zoI6Hk5T6IraCrRp8tr4Hms5Oktop1tZnicj2yXk3pZ5tKEPvCjjYYEEPr1pgpMszawrz3L43kPVN0l1HFyeWkVbKkvW2RvWVBPNSWbSaAFZZjrOmZqbRlXbIM1HMEPyL09-TyP71A9G2-JEE7eXOGVtJ5XiCa9K3vpWTpwye1bxayWQQ-tolylV0kzqlhsMyiZ18DO0dG6KOwytS3VDRWOCg0AU0li0PnyZwKi2EyaqJkdw_ohDaHGqSrIx3rcwcYBrEBXZH9t9Ax3__jfsVFoZHb35BkxLGhNyDwBhfpwcqHlLAx7LtGVMp4CNl0TMdVZoz2pkfsbAI";
  static String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNWUyYmExZmI4MTQ1MDFhNjliNzhkZmU0MTIxZTU0YWEyNmViYmU0ZGM3OTA2YjQ5Nzk2YmE4MmI3NDFmYTI2ZGY4N2ZhNjc0MDQ5MTE2Y2QiLCJpYXQiOjE2Mjk4NDUzNzcsIm5iZiI6MTYyOTg0NTM3NywiZXhwIjoxNjI5ODQ4OTc3LCJzdWIiOiIxNiIsInNjb3BlcyI6W119.cBpzoJIcrMKZZBNaqSdlD0FePvHTCibRlcgz5F7WT3Km7ZNH6_R-pHw-jpDJsfMSqQyVkah9djABMLP1DN9b94bg0bcNsk1-MzmV72TOkFRmQOkdYcesrJ-871K_PlJQlxjXisQhcKvY-lt0ORVcE-Mkz2aCHo9djLVt9_XajOH8khjAkR17ciZYox367oNFLpqDqBlp8aD10DEZ6QbLsQnCZFafR4mq8UMX-LEo3qAMFSDDYEjx5ox0NC1TRMh9bos6VusyRFPPpgD5D8MH3REX-tgoXcZYVd8toa31efTwwNpnL8DffK_VXazHwxHLJ-T6Lvs_vT8ur3aYw1-UP1r8dRloutB2LNCaM1JIA0iJ-zwhXnSXYAWsfs8h-up94ouhgnJ1nNOzL4y5RPJTSdEph3XrEUyl55JGJUO9KHnIGWl7ovG8V-uqa0L642li70Gxaqm5ysC5BEgRZuYKyPnx6egFIzA6ijzrOC_ylbDB3Jt0ij3moN9j5i8UBgIkCeAc0oDUkOXV1vCy1v6hIUpAM9eWjkQYIzbWZzo5TNKG4aRB_IphnMhKPRSBMMcpJ1tHHWcO3RlwSCvRbzQjr6spZqUVn-rUHvLHeKjDqBZQ95YGIG5AuNnmd-r6lydqWboKjqgbhz97DoCD1Gq7QJQlf0yj-mJWwY7CIHQgsBI";

  final listUsersFilter = BehaviorSubject<List<UserList>>();
  Stream<List<UserList>> get listWorkZonesSelectedStream =>
      listUsersFilter.stream;

  final listPaisesFilter = BehaviorSubject<List<CountriesList>>();
  Stream<List<CountriesList>> get listPaisesStream => listPaisesFilter.stream;

  final listClientesFilter = BehaviorSubject<List<CustomersList>>();
  Stream<List<CustomersList>> get listClientesStream =>
      listClientesFilter.stream;

  //Taras
  static CatTaraModel gvTaraSelected = CatTaraModel();
  static DtTaraModel gvListTaras     = DtTaraModel(tarassList: []);
  final gvBeSubListTaras             = BehaviorSubject<List<CatTaraModel>>();
  Stream<List<CatTaraModel>> get lsTarasFiltrosStream => gvBeSubListTaras.stream;

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
  }
}

final rxVariables = RxVariables();
