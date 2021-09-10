import 'package:flutter/material.dart';
import 'package:general_products_web/app/auth/login.dart';
import 'package:general_products_web/pages/admin/pantalla_de_acceso.dart';
import 'package:general_products_web/provider/signup_provider.dart';
import 'package:general_products_web/resources/global_variables.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final currentUser = RxVariables.loginResponse.data!;
  late Future params;
  final authService = SignupProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.isLoggedIn(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();

            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => LoginPage(),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
                // Navigator.pushReplacementNamed(context, RouteNames.login);
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => PantallaDeAcceso(),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
                // Navigator.pushReplacementNamed(context, RouteNames.access);
              });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
