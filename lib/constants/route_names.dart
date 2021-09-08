class RouteNames {
  static const String login = '/login';
  static const String recoveryPwd = '/forgot_password';
  static const String register = '/register';
  static const String home = '/';
  static const String ordersWork = '/orders_work';
  static const String catalogs = '/catalogs';
  static const String settings = '/settings';
  static const String reports = '/reports';
  static const String authorizeUser = "/authorize";
  static const String editUser = "/edit";

  // Acceso
  static const String access = '/access';

  //CRUD Taras
  static const String taraIndex = "/catalog/taras";
  static const String taraCreate = "/catalog/taras/create";
  static const String taraEdit = "/catalog/taras/edit";
  //static const String taraDestroy = "/catalog/taras/destroy";

  static const String paises = '/paises';
  static const String paisCreate = '/catalog/paises/create';
  static const String paisEdit = '/edit-country';

  //CRUD Clientes
  static const String clienteIndex = '/catalog/clientes';
  static const String clienteUpdate = '/catalog/clientes/update';
  static const String clienteStore = '/catalog/clientes/store';

  // CRUD Razones
  static const String razonIndex = '/catalog/razones';
  static const String razonUpdate = '/catalog/razones/update';
  static const String razonStore = '/catalog/razones/store';

  // CRUD Tintas
  static const String tintaIndex = '/catalog/tintas';
  static const String tintaUpdate = '/catalog/tintas/update';
  static const String tintaStore = '/catalog/tintas/store';
  static const String tintaImport = '/catalog/tintas/import';

  //CRUD Plantas
  static const String plantsIndex = "/catalog/plants";
  static const String plantsCreate = "/catalog/plants/create";
  static const String plantsEdit = "/catalog/plants/edit";

  //CRUD Maquinas
  static const String machineIndex = "/catalog/machine";
  static const String machineCreate = "/catalog/machine/create";
  static const String machineEdit = "/catalog/machine/edit";

  //CRUD Maquinas
  static const String designIndex = "/catalog/design";
  static const String designCreate = "/catalog/design/create";
  static const String designEdit = "/catalog/design/edit";

  //CRUD Ordenes de entrega
  static const String oeIndex = '/ordenes-de-trabajo/orden-de-entrega';
  static const String oeCreate = '/ordenes-de-trabajo/orden-de-entrega/create';
  static const String oeEdit = '/ordenes-de-trabajo/orden-de-entrega/edit';
}
