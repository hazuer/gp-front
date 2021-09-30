import 'package:flutter/material.dart';
import 'package:general_products_web/app/auth/loading_page.dart';
import 'package:general_products_web/app/auth/recovery_password.dart';
import 'package:general_products_web/app/auth/register_page.dart';
import 'package:general_products_web/pages/admin/pantalla_de_acceso.dart';
import 'package:general_products_web/pages/authorize_user.dart';
import 'package:general_products_web/pages/ordenes_de_trabajo/oe_adiciones/index.dart';
import 'package:general_products_web/pages/ordenes_de_trabajo/oe_recepcion/index.dart';
import 'package:general_products_web/pages/ordenes_de_trabajo/oe_recepcion/recepcion.dart';
import 'package:general_products_web/pages/ordenes_de_trabajo/ordenes_de_entrega/edit.dart';
import 'package:general_products_web/provider/ordenes_de_trabajo/calcularPesoProvider.dart';
import 'package:general_products_web/provider/ordenes_de_trabajo/guardarDatosProvider.dart';
import 'package:provider/provider.dart';
import 'pages/catalogs/pais/create.dart';
import 'pages/catalogs/pais/edit.dart';
import 'pages/catalogs/pais/index.dart';
import 'package:general_products_web/pages/catalogs/cliente/edit.dart';
import 'package:general_products_web/pages/catalogs/cliente/index.dart';
import 'package:general_products_web/pages/catalogs/cliente/store.dart';
import 'package:general_products_web/pages/edit_user.dart';
import 'package:general_products_web/pages/forms_page.dart';
import 'package:general_products_web/pages/ordenes_de_trabajo/ordenes_de_entrega/create.dart';
import 'package:general_products_web/pages/ordenes_de_trabajo/ordenes_de_entrega/index.dart';
import 'package:general_products_web/pages/catalogs/razon/edit.dart';
import 'package:general_products_web/pages/catalogs/razon/index.dart';
import 'package:general_products_web/pages/catalogs/razon/create.dart';
import 'package:general_products_web/pages/catalogs/tintas/edit.dart';
import 'package:general_products_web/pages/catalogs/tintas/import.dart';
import 'package:general_products_web/pages/catalogs/tintas/index.dart';
import 'package:general_products_web/pages/catalogs/tintas/store.dart';
import 'package:general_products_web/resources/colors.dart';
import 'app/auth/login.dart';
import 'constants/route_names.dart';
import 'pages/order_work_page.dart';
import 'pages/home_page.dart';
import 'pages/admin/settings_page.dart';
import 'pages/slideshow_page.dart';
import 'widgets/app_route_observer.dart';
import 'pages/catalogs/tara/index.dart';
import 'pages/catalogs/tara/create.dart';
import 'pages/catalogs/tara/edit.dart';
//Plantas
import 'pages/catalogs/plant/index.dart';
import 'pages/catalogs/plant/create.dart';
import 'pages/catalogs/plant/edit.dart';
//Maquina
import 'pages/catalogs/machine/index.dart';
import 'pages/catalogs/machine/create.dart';
import 'pages/catalogs/machine/edit.dart';
//Diseño
import 'pages/catalogs/design/index.dart';
import 'pages/catalogs/design/create.dart';
import 'pages/catalogs/design/edit.dart';
import 'pages/catalogs/design/import.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final prefs = new UserPreferences();
  //await prefs.initPrefs();

  runApp(GeneralProductsApp());
}

class GeneralProductsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CalcularPeso(),
        ),
        ChangeNotifierProvider(
          create: (_) => GuardarDatos(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'General Products',
        theme: ThemeData(
          textTheme: TextTheme(
              subtitle1: TextStyle(
            color: Color(0xffE7E7E7),
            fontSize: 14,
          )),
          iconTheme:
              new IconThemeData(color: Colors.black, opacity: 1.0, size: 30.0),
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
            color: GPColors.BreadcrumBackgroud,
          ),
          primaryTextTheme: TextTheme(
            headline1: TextStyle(
              color: Color(0xff73879C),
              fontWeight: FontWeight.bold,
            ),
          ),
          // primaryColor: Color(0xff2A3F54),
          pageTransitionsTheme: PageTransitionsTheme(
            // makes all platforms that can run Flutter apps display routes without any animation
            builders: Map<TargetPlatform,
                    _InanimatePageTransitionsBuilder>.fromIterable(
                TargetPlatform.values.toList(),
                key: (dynamic k) => k,
                value: (dynamic _) => const _InanimatePageTransitionsBuilder()),
          ),
        ),
        initialRoute: RouteNames.oeIndex,
        navigatorObservers: [AppRouteObserver()],
        routes: {
          RouteNames.login: (_) => LoginPage(),
          RouteNames.home: (_) => HomePage(),
          RouteNames.ordersWork: (_) => const OrdersWorkPage(),
          RouteNames.catalogs: (_) => const CatalogPage(),
          RouteNames.settings: (_) => const SettingsPage(),
          RouteNames.reports: (_) => ReportsPage(),
          RouteNames.recoveryPwd: (_) => RecoveryPasswordPage(),
          RouteNames.register: (_) => RegisterPage(),
          RouteNames.authorizeUser: (_) => AuthorizeUserPage(),
          RouteNames.editUser: (_) => EditUserPage(),
          // Acceso
          RouteNames.access: (_) => PantallaDeAcceso(),
          RouteNames.loading: (_) => LoadingPage(),
          // Paises
          RouteNames.paisesIndex: (_) => PaisesIndex(),
          RouteNames.paisCreate: (_) => PaisCreate(),
          RouteNames.paisEdit: (_) => PaisEdit(),
          RouteNames.taraIndex: (_) => TaraIndex(),
          RouteNames.taraCreate: (_) => TaraCreate(),
          RouteNames.taraEdit: (_) => TaraEdit(),
          RouteNames.clienteIndex: (_) => ClientesIndex(),
          RouteNames.clienteEdit: (_) => ClienteEdit(),
          RouteNames.clienteCreate: (_) => ClienteCreate(),
          RouteNames.razonIndex: (_) => RazonesIndex(),
          RouteNames.razonEdit: (_) => RazonEdit(),
          RouteNames.razonCreate: (_) => RazonCreate(),
          RouteNames.tintaIndex: (_) => TintasIndex(),
          RouteNames.tintaEdit: (_) => TintaEdit(),
          RouteNames.tintaCreate: (_) => TintaStore(),
          RouteNames.tintaImport: (_) => TintaImport(),
          //Plantas
          RouteNames.plantsIndex: (_) => PlantIndex(),
          RouteNames.plantsCreate: (_) => PlantCreate(),
          RouteNames.plantsEdit: (_) => PlantEdit(),
          //Maquinas
          RouteNames.machineIndex: (_) => MachineIndex(),
          RouteNames.machineCreate: (_) => MachineCreate(),
          RouteNames.machineEdit: (_) => MachineEdit(),

          //Diseños
          RouteNames.designIndex: (_) => DesignIndex(),
          RouteNames.designCreate: (_) => DesignCreate(),
          RouteNames.designEdit: (_) => DesignEdit(),
          RouteNames.designImport: (_) => DesignImport(),

          // Ordenes de entrega
          RouteNames.oeIndex: (_) => OrdenesEntregaIndex(),
          RouteNames.oeCreate: (_) => OrdenesEntregaCreate(),
          RouteNames.oeEdit: (_) => OrdenesEntregaEdit(),

          // OE Adiciones
          RouteNames.oeAdicionesIndex: (_) => OrdenesEntregaAdicionesIndex(),

          // OE Recepcion
          RouteNames.oeRecepcionIndex: (_) => OrdenesEntregaRecepcionIndex(),
          RouteNames.oeRecepcionRecibir: (_) =>
              OrdenesEntregaRecepcionRecibir(),
        },
      ),
    );
  }
}

/// This class is used to build page transitions that don't have any animation
class _InanimatePageTransitionsBuilder extends PageTransitionsBuilder {
  const _InanimatePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return child;
  }
}
