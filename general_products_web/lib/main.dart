import 'package:flutter/material.dart';
import 'package:general_products_web/app/auth/recovery_password.dart';
import 'package:general_products_web/app/auth/register_page.dart';
import 'package:general_products_web/pages/forms_page.dart';
import 'package:general_products_web/resources/colors.dart';
import 'app/auth/login.dart';
import 'constants/route_names.dart';
import 'pages/order_work_page.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';
import 'pages/slideshow_page.dart';
import 'widgets/app_route_observer.dart';

void main()async{
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
          color: GPColors.PrimaryColor,
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
        RouteNames.home: (_) => const HomePage(),
        RouteNames.ordersWork: (_) => const OrdersWorkPage(),
        RouteNames.catalogs: (_) => const CatalogPage(),
        RouteNames.settings: (_) => const SettingsPage(),
        RouteNames.reports: (_) => ReportsPage(),
        RouteNames.recoveryPwd: (_) => RecoveryPasswordPage(),
        RouteNames.register: (_) => RegisterPage()
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
