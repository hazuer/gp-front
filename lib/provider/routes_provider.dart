import 'package:dio/dio.dart';

class RoutesProvider{

  final String urlBase = "http://api-dev.generalproducts.com.mx:880/api/";


  final Options headerOptions = new Options(
    headers: {
      'Content-Type':'application/json',
      'X-Requested-With': "XMLHttpRequest"
    }
  );


  
  String login = "login";
  String register = "registrar-usuario";
  String dataUser = "datos-registro";
  String recoverPwd = "recuperar-contraseña";
  String logOut = "cerrar-sesion";

  //Services
  String dataListUser = "datos-listar-usuarios";
  String listUsers = "listar-usuarios";//"listar-usuarios?porPagina=20&nombre=&apellido_paterno&apellido_materno&id_cat_estatus&id_cat_perfil&id_cat_planta&id_cat_cliente&ordenarPor&pagina";
  String searchUser = "datos-usuario?id_dato_usuario=";   // id
  String authorizeUser = "autorizar-usuarios";
  String editUser = "editar-usuarios-datos";
  String deactivateUsers = "desactivar-usuarios";
  String editUserPermissions = "editar-usuarios-permisos";
  
  
  
}
