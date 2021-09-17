import 'package:dio/dio.dart';

class RoutesProvider {
  final String urlBase = "http://api-dev.generalproducts.com.mx:880/api/";

  final Options headerOptions = new Options(headers: {
    'Content-Type': 'application/json',
    'X-Requested-With': "XMLHttpRequest"
  });

  String login = "login";
  String register = "registrar-usuario";
  String dataUser = "datos-registro";
  String recoverPwd = "recuperar-contraseña";
  String logOut = "cerrar-sesion";

  // Settings
  String listParameters = "administracion/parametrizar-sistema";
  String changeParameters = "administracion/parametrizar-sistema-crear-editar";

  //Services
  String dataListUser = "datos-listar-usuarios";
  String listUsers =
      "listar-usuarios"; //"listar-usuarios?porPagina=20&nombre=&apellido_paterno&apellido_materno&id_cat_estatus&id_cat_perfil&id_cat_planta&id_cat_cliente&ordenarPor&pagina";
  String searchUser = "datos-usuario?id_dato_usuario="; // id
  String authorizeUser = "autorizar-usuarios";
  String editUser = "editar-usuarios-datos";
  String deactivateUsers = "desactivar-usuarios";
  String editUserPermissions = "editar-usuarios-permisos";

  String listPaises = "catalogo/listar-paises";
  String editarPais = "catalogo/editar-paises";
  String crearPais = "catalogo/crear-paises";
  String changeEstatusPais = "catalogo/editar-estatus-paises";

  String listClientes = "catalogo/listar-clientes";
  String editarClientes = "catalogo/editar-clientes";
  String crearClientes = "catalogo/crear-clientes";
  String changeEstatusClientes = "catalogo/editar-estatus-clientes";
  String desactivarClientes = "catalogo/editar-estatus-clientes";
  String eliminarClientes = "catalogo/editar-estatus-clientes";
  String plantasClientes = "datos-plantas-clientes";

  // Diseños
  String listarDisenos = "catalogo/listar-disenos";
  String crearDisenos = "catalogo/crear-disenos";
  String editarDisenos = "catalogo/editar-disenos";
  String changeEstatusDisenos = "catalogo/editar-estatus-disenos";
  String buscarTintas = 'catalogo/datos-diseno';
  String importDesign = 'catalogo/importar-disenos-csv';

  //Taras
  String listarTaras = "catalogo/listar-taras";
  String crearTaras = "catalogo/crear-taras";
  String editarTaras = "catalogo/editar-taras";
  String changeEstatusTaras = "catalogo/editar-estatus-taras";

  // Razones
  String listarRazones = "catalogo/listar-razones";
  String editarRazones = 'catalogo/editar-razones';
  String crearRazones = 'catalogo/crear-razones';
  String changeEstatusRazones = 'catalogo/editar-estatus-razones';
  String activarRazones = 'catalogo/editar-estatus-razones';
  String desactivarRazones = 'catalogo/editar-estatus-razones';
  String eliminarRazones = 'catalogo/editar-estatus-razones';

  // Tintas
  String listarTintas = "catalogo/listar-tintas";
  String editarTintas = "catalogo/editar-tintas";
  String crearTintas = "catalogo/crear-tintas";
  String importarTintas = "catalogo/importar-tintas-csv";
  String changeEstatusTintas = "catalogo/editar-estatus-tintas";

  //Maquinas
  String listarMachines = "catalogo/listar-maquinas";
  String crearMachines = "catalogo/crear-maquinas";
  String editarMachines = "catalogo/editar-maquinas";
  String changeEstatusMachines = "catalogo/editar-estatus-maquinas";

  //Plantas
  String listarPlants = "catalogo/listar-plantas";
  String crearPlants = "catalogo/crear-plantas";
  String editarPlants = "catalogo/editar-plantas";
  String changeEstatusPlants = "catalogo/editar-estatus-planta";
  String paisesEstatusListas = "catalogo/paises-estatus-listas";

  // Ordenes de trabajo
  String listarOE = 'orden-de-entrega/listar';
  String listarCatalogosOE = 'orden-de-entrega/listas-busqueda-oe';
  String crearOE = 'orden-de-entrega/crear-oe';
  String editarOE = 'orden-de-entrega/editar-oe';
  String listarTintasOE = 'orden-de-entrega/diseno-tintas';
}
