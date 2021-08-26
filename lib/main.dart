import 'package:flutter/material.dart';
import 'package:general_products_web/app/auth/recovery_password.dart';
import 'package:general_products_web/app/auth/register_page.dart';
import 'package:general_products_web/pages/authorize_user.dart';
import 'package:general_products_web/pages/cliente/edit.dart';
import 'package:general_products_web/pages/cliente/index.dart';
import 'package:general_products_web/pages/cliente/store.dart';
import 'package:general_products_web/pages/edit_country_page.dart';
import 'package:general_products_web/pages/edit_user.dart';
import 'package:general_products_web/pages/forms_page.dart';
import 'package:general_products_web/pages/paises_page.dart';
import 'package:general_products_web/pages/razon/edit.dart';
import 'package:general_products_web/pages/razon/index.dart';
import 'package:general_products_web/pages/razon/store.dart';
import 'package:general_products_web/pages/tintas/index.dart';
import 'package:general_products_web/resources/colors.dart';
import 'app/auth/login.dart';
import 'constants/route_names.dart';
import 'pages/order_work_page.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';
import 'pages/slideshow_page.dart';
import 'widgets/app_route_observer.dart';
import 'pages/catalogs/tara/index.dart';
import 'pages/catalogs/tara/create.dart';
import 'pages/catalogs/tara/edit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final prefs = new UserPreferences();
  //await prefs.initPrefs();

  runApp(GeneralProductsApp());
}

class GeneralProductsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      initialRoute: RouteNames.login,
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
        RouteNames.editUser     : (_) => EditUserPage(),
        RouteNames.paises       : (_) => PaisesPage(),
        RouteNames.editCountry  : (_) => EditCountryPage(),
        RouteNames.taraIndex    : (_) => TaraIndex(),
        RouteNames.taraCreate   : (_) => TaraCreate(),
        RouteNames.taraEdit     : (_) => TaraEdit(),
        RouteNames.clienteIndex : (_) => ClientesIndex(),
        RouteNames.clienteUpdate: (_) => ClienteEdit(),
        RouteNames.clienteStore: (_) => ClienteStore(),
        RouteNames.razonIndex: (_) => RazonesIndex(),
        RouteNames.razonUpdate: (_) => RazonEdit(),
        RouteNames.razonStore: (_) => RazonStore(),
        RouteNames.tintaIndex: (_) => TintasIndex(),
        // RouteNames.tintaUpdate: (_) => TintasIndex(),
        // RouteNames.tintaStore: (_) => TintasIndex(),
        // RouteNames.tintaImport: (_) => TintasIndex(),
      },
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
