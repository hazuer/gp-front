import 'package:flutter/material.dart';
import 'package:general_products_web/constants/route_names.dart';
//import 'package:general_products_web/models/login_response.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/provider/settings/parametros_provider.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/general_dialog.dart';

class PantallaDeAcceso extends StatefulWidget {
  @override
  _PantallaDeAccesoState createState() => _PantallaDeAccesoState();
}

class _PantallaDeAccesoState extends State<PantallaDeAcceso> {
  final currentUser = RxVariables.loginResponse.data!;
  late Future params;

  @override
  void initState() {
    if (currentUser.catProfile!.profileId == 1) {
      params =
          ParametrosProvider().getAllParameters(currentUser.catPlant!.plantId!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool displayMobileLayout = size.width < 1000;

    return Scaffold(
      backgroundColor: Color(0xff2b3e54),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            displayMobileLayout
                ? Expanded(
                    child: ListView(
                      // shrinkWrap: true,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(height: 10),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 50),
                              Image(
                                height: size.height * 0.10,
                                image:
                                    AssetImage('assets/images/logo_login.png'),
                              ),
                              Expanded(child: SizedBox()),
                              ElevatedButton(
                                  onPressed: () {
                                    GeneralDialog().logoutDialog(context);
                                    ListUsersProvider().logOut();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                      side: BorderSide(color: Colors.white),
                                    ),
                                    primary: Colors.white,
                                  ),
                                  child: Icon(Icons.arrow_back,
                                      color: Color(0xff2b3e54))),
                              SizedBox(width: 50),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            SelectionBox(
                              size: size,
                              icon: Icons.account_circle,
                              buttonText: 'Mi Cuenta',
                              description: 'Detalles de mi cuenta',
                              onPressed: () => Navigator.pushReplacementNamed(
                                  context, RouteNames.home),
                            ),
                            SizedBox(height: 20),

                            (currentUser.catProfile!.profileId == 1)
                                // Administrador
                                ? SelectionBox(
                                    size: size,
                                    icon: Icons.account_circle,
                                    buttonText: 'Administrar',
                                    description: 'Permisos de usuarios',
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, RouteNames.home);
                                    },
                                  )
                                : Container(),
                            SizedBox(height: 20),
                            (currentUser.catProfile!.profileId == 1)
                                // Administrador
                                ? SelectionBox(
                                    size: size,
                                    icon: Icons.dashboard,
                                    buttonText: 'Catálogos',
                                    description: 'Ver catálogos',
                                    onPressed: () =>
                                        Navigator.pushReplacementNamed(
                                            context, RouteNames.paisesIndex),
                                  )
                                : Container(),
                            // Expanded(child: SizedBox()),
                            SizedBox(height: 20),

                            // SizedBox(width: 20),
                            (currentUser.catProfile!.profileId == 1)
                                // Administrador
                                ? SelectionBox(
                                    size: size,
                                    icon: Icons.settings,
                                    buttonText: 'Configurar',
                                    description: 'Parametrizar sistema',
                                    onPressed: () =>
                                        Navigator.pushReplacementNamed(
                                            context, RouteNames.settings),
                                  )
                                : Container(),
                            SizedBox(height: 20),
                            (currentUser.catProfile!.profileId == 1 ||
                                    currentUser.catProfile!.profileId == 4 ||
                                    currentUser.catProfile!.profileId == 5)
                                // Administrador, supervisor y consulta
                                ? SelectionBox(
                                    size: size,
                                    icon: Icons.description,
                                    buttonText: 'Generar',
                                    description: 'Reportes',
                                    onPressed: () =>
                                        Navigator.pushReplacementNamed(
                                            context, RouteNames.reports),
                                  )
                                : Container(),
                            SizedBox(height: 20),
                            (currentUser.catProfile!.profileId == 2 ||
                                    currentUser.catProfile!.profileId == 3 ||
                                    currentUser.catProfile!.profileId == 4)
                                // Operador, op. cliente y supervisor
                                ? SelectionBox(
                                    size: size,
                                    icon: Icons.assignment_turned_in,
                                    buttonText: 'Generar',
                                    description: 'Ordenes de entrega',
                                    onPressed: () =>
                                        Navigator.pushReplacementNamed(
                                            context, RouteNames.oeIndex),
                                  )
                                : Container(),
                            SizedBox(height: 20),
                            (currentUser.catProfile!.profileId == 2 ||
                                    currentUser.catProfile!.profileId == 3 ||
                                    currentUser.catProfile!.profileId == 4)
                                // Operador, op. cliente y supervisor
                                ? SelectionBox(
                                    size: size,
                                    icon: Icons.post_add,
                                    buttonText: 'Aditivos',
                                    description: 'OE Adiciones',
                                    onPressed: () =>
                                        Navigator.pushReplacementNamed(context,
                                            RouteNames.oeAdicionesIndex),
                                  )
                                : Container(),
                          ],
                        ),
                        // Expanded(child: SizedBox()),
                        SizedBox(height: size.height * .2),
                      ],
                    ),
                  )
                : Column(children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 50),
                          Image(
                            height: size.height * 0.10,
                            image: AssetImage('assets/images/logo_login.png'),
                          ),
                          Expanded(child: SizedBox()),
                          SelectionBox(
                            size: size,
                            icon: Icons.account_circle,
                            buttonText: 'Mi Cuenta',
                            description: 'Detalles de mi cuenta',
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, RouteNames.home),
                          ),
                          Expanded(child: SizedBox()),
                          ElevatedButton(
                              onPressed: () {
                                GeneralDialog().logoutDialog(context);
                                ListUsersProvider().logOut();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                  side: BorderSide(color: Colors.white),
                                ),
                                primary: Colors.white,
                              ),
                              child: Icon(Icons.arrow_back,
                                  color: Color(0xff2b3e54))),
                          SizedBox(width: 50),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height / 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: SizedBox()),
                        (currentUser.catProfile!.profileId == 1)
                            // Administrador
                            ? SelectionBox(
                                size: size,
                                icon: Icons.account_circle,
                                buttonText: 'Administrar',
                                description: 'Permisos de usuarios',
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, RouteNames.home);
                                },
                              )
                            : Container(),
                        SizedBox(width: 20),
                        (currentUser.catProfile!.profileId == 1)
                            // Administrador
                            ? SelectionBox(
                                size: size,
                                icon: Icons.dashboard,
                                buttonText: 'Catálogos',
                                description: 'Ver catálogos',
                                onPressed: () => Navigator.pushReplacementNamed(
                                    context, RouteNames.paisesIndex),
                              )
                            : Container(),
                        SizedBox(width: 20),
                        (currentUser.catProfile!.profileId == 1)
                            // Administrador
                            ? SelectionBox(
                                size: size,
                                icon: Icons.settings,
                                buttonText: 'Configurar',
                                description: 'Parametrizar sistema',
                                onPressed: () {
                                  // ParametrosProvider().getAllParameters(8);
                                  Navigator.pushReplacementNamed(
                                      context, RouteNames.settings);
                                },
                              )
                            : Container(),
                        SizedBox(width: 20),
                        (currentUser.catProfile!.profileId == 1 ||
                                currentUser.catProfile!.profileId == 4 ||
                                currentUser.catProfile!.profileId == 5)
                            // Administrador, supervisor y consulta
                            ? SelectionBox(
                                size: size,
                                icon: Icons.description,
                                buttonText: 'Generar',
                                description: 'Reportes',
                                onPressed: () => Navigator.pushReplacementNamed(
                                    context, RouteNames.reports),
                              )
                            : Container(),
                        SizedBox(width: 20),
                        (currentUser.catProfile!.profileId == 2 ||
                                currentUser.catProfile!.profileId == 3 ||
                                currentUser.catProfile!.profileId == 4)
                            // Operador, op. cliente y supervisor
                            ? SelectionBox(
                                size: size,
                                icon: Icons.assignment_turned_in,
                                buttonText: 'Generar',
                                description: 'Ordenes de entrega',
                                onPressed: () => Navigator.pushReplacementNamed(
                                    context, RouteNames.oeIndex),
                              )
                            : Container(),
                        SizedBox(width: 20),
                        (currentUser.catProfile!.profileId == 2 ||
                                currentUser.catProfile!.profileId == 3 ||
                                currentUser.catProfile!.profileId == 4)
                            // Operador, op. cliente y supervisor
                            ? SelectionBox(
                                size: size,
                                icon: Icons.post_add,
                                buttonText: 'Aditivos',
                                description: 'OE Adiciones',
                                onPressed: () => Navigator.pushReplacementNamed(
                                    context, RouteNames.oeAdicionesIndex),
                              )
                            : Container(),
                        Expanded(child: SizedBox()),
                      ],
                    )
                  ])
          ],
        ),
      ),
    );
  }
}

class SelectionBox extends StatelessWidget {
  IconData icon;
  void Function()? onPressed;
  String buttonText;
  String description;

  SelectionBox({
    Key? key,
    required this.size,
    required this.icon,
    required this.onPressed,
    required this.buttonText,
    required this.description,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.25,
      width: size.height * 0.25,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Icon(icon, color: Colors.white, size: 50),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                side: BorderSide(color: Colors.white),
              ),
              primary: Color(0xff2b3e54),
            ),
            child: Text(
              buttonText,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          SizedBox(height: 20),
          Text(
            description,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
