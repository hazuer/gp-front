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

  //CRUD Taras
  static const String taraIndex  = "/catalogo/taras";
  static const String taraCreate = "/catalogo/taras/create";
  static const String taraEdit   = "/catalogo/taras/edit";
  //static const String taraDestroy = "/catalogo/taras/destroy";

  static const String paises = '/paises';
  static const String editCountry = '/edit-country';

  //CRUD Clientes
  static const String clienteIndex = 'catalogo/clientes';
  static const String clienteUpdate = 'catalogo/clientes/update';
  static const String clienteStore = 'catalogo/clientes/store';

  // CRUD Razones
  static const String razonIndex = 'catalogo/razones';
  static const String razonUpdate = 'catalogo/razones/update';
  static const String razonStore = 'catalogo/razones/store';
}
