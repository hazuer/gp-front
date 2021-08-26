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
  String desactivarPais = "catalogo/editar-estatus-paises";

  String listClientes = "catalogo/listar-clientes";
  String editarClientes = "catalogo/editar-clientes";
  String crearClientes = "catalogo/crear-clientes";
  String desactivarClientes = "catalogo/editar-estatus-clientes";
  String eliminarClientes = "catalogo/editar-estatus-clientes";
  String plantasClientes = "datos-plantas-clientes";

  //Taras
  String listarTaras        = "catalogo/listar-taras";
  String crearTaras         = "catalogo/crear-taras";
  String editarTaras        = "catalogo/editar-taras";
  String changeEstatusTaras = "catalogo/editar-estatus-taras";

  // Razones
  String listarRazones = "catalogo/listar-razones";
  String editarRazones = 'catalogo/editar-razones';
  String crearRazones = 'catalogo/crear-razones';
  String activarRazones = 'catalogo/editar-estatus-razones';
  String desactivarRazones = 'catalogo/editar-estatus-razones';
  String eliminarRazones = 'catalogo/editar-estatus-razones';
}
