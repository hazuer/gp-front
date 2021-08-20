import 'package:flutter/material.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/general_dialog.dart';
import '../constants/page_titles.dart';
import '../constants/route_names.dart';
import 'app_route_observer.dart';

/// The navigation drawer for the app.
/// This listens to changes in the route to update which page is currently been shown
class AppDrawer extends StatefulWidget {
  const AppDrawer({required this.permanentlyDisplay, Key? key})
      : super(key: key);

  final bool permanentlyDisplay;

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with RouteAware {
  String? _selectedRoute;
  AppRouteObserver? _routeObserver;
  @override
  void initState() {
    super.initState();
    _routeObserver = AppRouteObserver();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _routeObserver!.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    _routeObserver!.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    _updateSelectedRoute();
  }

  @override
  void didPop() {
    _updateSelectedRoute();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff2A3F54),
        child: Drawer(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: Color(0xff2A3F54),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        //padding: EdgeInsets.zero,
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 15.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  height: 130,
                                ),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/gp_dash.png"),
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )),
                                SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  child: Stack(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text('Bienvenido',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xffBAB8B8))),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 48,
                                          ),
                                          Text(
                                            "Administrador",
                                            //"${RxVariables.loginResponse.data!.user!.name} ${RxVariables.loginResponse.data!.user!.lastName}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffECF0F1)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff2A3F54),
                        ),
                      ),
                      ListTileTheme(
                        iconColor: Color(0xffE7E7E7),
                        child: ListTile(
                          leading: const Icon(Icons.admin_panel_settings),
                          title: const Text(
                            PageTitles.admin,
                          ),
                          onTap: () async {
                            await _navigateTo(context, RouteNames.home);
                          },
                          selected: _selectedRoute == RouteNames.home,
                        ),
                      ),
                      ListTileTheme(
                          iconColor: Color(0xffE7E7E7),
                          child: ListTile(
                            leading: const Icon(Icons.settings),
                            title: const Text(
                              PageTitles.settings,
                            ),
                            onTap: () async {
                              await _navigateTo(context, RouteNames.settings);
                            },
                            selected: _selectedRoute == RouteNames.settings,
                          )),
                      ListTileTheme(
                          iconColor: Color(0xffE7E7E7),
                          child: ListTile(
                            leading: const Icon(Icons.assignment),
                            title: const Text(
                              PageTitles.formWorks,
                            ),
                            onTap: () async {
                              await _navigateTo(context, RouteNames.ordersWork);
                            },
                            selected: _selectedRoute == RouteNames.ordersWork,
                          )),
                      ListTileTheme(
                        iconColor: Color(0xffE7E7E7),
                        child: AppExpansionTile(
                          backgroundColor: Colors.white10,
                          title: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.menu_book),
                            title: const Text(
                              PageTitles.catalogs,
                            ),
                            onTap: () async {
                              await _navigateTo(context, RouteNames.catalogs);
                            },
                            selected: _selectedRoute == RouteNames.catalogs,
                          ),
                          children: [
                            ListTile(
                              // contentPadding: EdgeInsets.only(left: 16.0),
                              leading: const Icon(Icons.public),
                              title: const Text(
                                PageTitles.paises,
                              ),
                              onTap: () async {
                                await _navigateTo(context, RouteNames.paises);
                              },
                              selected: _selectedRoute == RouteNames.paises,
                            ),
                            // TODO: Crear cada pagina y ponerlas con el estandar
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 16.0),
                              leading: const Icon(Icons.brush),
                              title: const Text('Diseños'),
                              onTap: () async {
                                // await _navigateTo(context, RouteNames.paises);
                              },
                              // selected: _selectedRoute == RouteNames.paises,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 16.0),
                              leading: const Icon(Icons.color_lens),
                              title: const Text('Tintas'),
                              onTap: () async {
                                // await _navigateTo(context, RouteNames.paises);
                              },
                              // selected: _selectedRoute == RouteNames.paises,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 16.0),
                              leading: const Icon(Icons.corporate_fare),
                              title: const Text('Plantas'),
                              onTap: () async {
                                // await _navigateTo(context, RouteNames.paises);
                              },
                              // selected: _selectedRoute == RouteNames.paises,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 16.0),
                              leading: const Icon(Icons.topic),
                              title: const Text('Razones'),
                              onTap: () async {
                                // await _navigateTo(context, RouteNames.paises);
                              },
                              // selected: _selectedRoute == RouteNames.paises,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 16.0),
                              leading: const Icon(Icons.groups),
                              title: const Text('Clientes'),
                              onTap: () async {
                                // await _navigateTo(context, RouteNames.paises);
                              },
                              // selected: _selectedRoute == RouteNames.paises,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 16.0),
                              leading:
                                  const Icon(Icons.precision_manufacturing),
                              title: const Text('Maquinas'),
                              onTap: () async {
                                // await _navigateTo(context, RouteNames.paises);
                              },
                              // selected: _selectedRoute == RouteNames.paises,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 16.0),
                              leading: const Icon(Icons.format_color_fill),
                              title: const Text('Taras'),
                              onTap: () async {
                                // await _navigateTo(context, RouteNames.paises);
                              },
                              // selected: _selectedRoute == RouteNames.paises,
                            ),
                          ],
                        ),
                      ),
                      /*const Divider(
                    color: Color(0xffF5F6F5),
                  ),*/
                      ListTileTheme(
                          iconColor: Color(0xffE7E7E7),
                          child: ListTile(
                            leading: const Icon(Icons.bar_chart),
                            title: const Text(
                              PageTitles.reports,
                            ),
                            onTap: () async {
                              await _navigateTo(context, RouteNames.reports);
                            },
                            selected: _selectedRoute == RouteNames.reports,
                          )),
                      ListTileTheme(
                          iconColor: Color(0xffE7E7E7),
                          child: ListTile(
                            leading: const Icon(Icons.logout),
                            title: const Text(
                              "Cerrar sesión",
                            ),
                            onTap: () {
                              GeneralDialog().logoutDialog(context);
                              ListUsersProvider().logOut();
                            },
                            //selected: _selectedRoute == RouteNames.settings,
                          )),
                    ],
                  ),
                ),
              ),
              if (widget.permanentlyDisplay)
                const VerticalDivider(
                  width: 1,
                )
            ],
          ),
        ));
  }

  /// Closes the drawer if applicable (which is only when it's not been displayed permanently) and navigates to the specified route
  /// In a mobile layout, the a modal drawer is used so we need to explicitly close it when the user selects a page to display
  Future<void> _navigateTo(BuildContext context, String routeName) async {
    if (widget.permanentlyDisplay) {
      Navigator.pop(context);
    }
    await Navigator.pushNamed(context, routeName);
  }

  void _updateSelectedRoute() {
    setState(() {
      _selectedRoute = ModalRoute.of(context)!.settings.name;
    });
  }
}
