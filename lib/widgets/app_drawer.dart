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
        width: 220.0,
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
                                  height: 100,
                                ),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/gp_dash.png"),
                                      height: 70,
                                      fit: BoxFit.cover,
                                    )),
                                SizedBox(
                                  width: 15,
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
                                            height: 50,
                                          ),
                                          Text(
                                            "Administrador",
                                            //"${RxVariables.loginResponse.data!.user!.name} ${RxVariables.loginResponse.data!.user!.lastName}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
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
                          leading:
                              const Icon(Icons.admin_panel_settings, size: 27),
                          title: const Text(
                            PageTitles.admin,
                            style: TextStyle(
                              fontSize: 13,
                            ),
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
                            leading: const Icon(Icons.settings, size: 27),
                            title: const Text(
                              PageTitles.settings,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            onTap: () async {
                              await _navigateTo(context, RouteNames.settings);
                            },
                            selected: _selectedRoute == RouteNames.settings,
                          )),
                    ListTileTheme(
                        iconColor: Color(0xffE7E7E7),
                        child: AppExpansionTile(
                          backgroundColor: Colors.white10,
                          title: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.assignment, size: 27),
                            title: const Text(
                              PageTitles.formWorks,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            onTap: () async {
                              await _navigateTo(context, RouteNames.ordersWork);
                            },
                            selected: _selectedRoute == RouteNames.ordersWork,
                          ),
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 16.0),
                              leading: const Icon(Icons.delivery_dining, size: 27),
                              title: const Text("Entregas",
                                style: TextStyle(
                                fontSize: 13,
                              )
                              ),
                              onTap: () async {
                                //await _navigateTo(context, RouteNames.paises);
                              },
                              //selected: _selectedRoute == RouteNames.paises,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 16.0),
                              leading: const Icon(Icons.assignment_return, size: 27),
                              title: const Text('Devoluciones',style: TextStyle(
                                fontSize: 13,
                              )),
                              onTap: () async {
                                //await _navigateTo(context, RouteNames.taraIndex);
                              },
                              //selected: _selectedRoute == RouteNames.taraIndex,
                            ),
                          ],
                        ),
                      ),

                      ListTileTheme(
                        iconColor: Color(0xffE7E7E7),
                        child: AppExpansionTile(
                          backgroundColor: Colors.white10,
                          title: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.menu_book, size: 27),
                            title: const Text(
                              PageTitles.catalogs,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            onTap: () async {
                              await _navigateTo(context, RouteNames.catalogs);
                            },
                            selected: _selectedRoute == RouteNames.catalogs,
                          ),
                          children: [
                            ListTile(
                              // contentPadding: EdgeInsets.only(left: 16.0),
                              leading: const Icon(Icons.public, size: 27),
                              title: const Text(
                                PageTitles.paises,style: TextStyle(
                                fontSize: 13,
                              )
                              ),
                              onTap: () async {
                                await _navigateTo(context, RouteNames.paises);
                              },
                              selected: _selectedRoute == RouteNames.paises,
                            ),
                            // TODO: Crear cada pagina y ponerlas con el estandar
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 16.0),
                              leading: const Icon(Icons.brush, size: 27),
                              title: const Text('Diseños',style: TextStyle(
                                fontSize: 13,
                              )),
                              onTap: () async {
                                // await _navigateTo(context, RouteNames.paises);
                              },
                              // selected: _selectedRoute == RouteNames.paises,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 16.0),
                              leading: const Icon(Icons.color_lens, size: 27),
                              title: const Text('Tintas',style: TextStyle(
                                fontSize: 13,
                              )),
                              onTap: () async {
                                // await _navigateTo(context, RouteNames.paises);
                              },
                              // selected: _selectedRoute == RouteNames.paises,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 16.0),
                              leading: const Icon(Icons.corporate_fare, size: 27),
                              title: const Text('Plantas',style: TextStyle(
                                fontSize: 13,
                              )),
                              onTap: () async {
                                // await _navigateTo(context, RouteNames.paises);
                              },
                              // selected: _selectedRoute == RouteNames.paises,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 16.0),
                              leading: const Icon(Icons.topic, size: 27),
                              title: const Text('Razones',style: TextStyle(
                                fontSize: 13,
                              )),
                              onTap: () async {
                                // await _navigateTo(context, RouteNames.paises);
                              },
                              // selected: _selectedRoute == RouteNames.paises,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 16.0),
                              leading: const Icon(Icons.groups, size: 27),
                              title: const Text('Clientes',style: TextStyle(
                                fontSize: 13,
                              )),
                              onTap: () async {
                                // await _navigateTo(context, RouteNames.paises);
                              },
                              // selected: _selectedRoute == RouteNames.paises,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 16.0),
                              leading:
                                  const Icon(Icons.precision_manufacturing, size: 27),
                              title: const Text('Maquinas',style: TextStyle(
                                fontSize: 13,
                              )),
                              onTap: () async {
                                // await _navigateTo(context, RouteNames.paises);
                              },
                              // selected: _selectedRoute == RouteNames.paises,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 16.0),
                              leading: const Icon(Icons.format_color_fill, size: 27),
                              title: const Text('Taras',),
                              onTap: () async {
                                await _navigateTo(context, RouteNames.taraIndex);
                              },
                              selected: _selectedRoute == RouteNames.taraIndex,
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
                            leading: const Icon(Icons.bar_chart, size: 27),
                            title: const Text(
                              PageTitles.reports,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            onTap: () async {
                              await _navigateTo(context, RouteNames.reports);
                            },
                            selected: _selectedRoute == RouteNames.reports,
                          )),
                      ListTileTheme(
                          iconColor: Color(0xffE7E7E7),
                          child: ListTile(
                            leading: const Icon(Icons.logout, size: 27),
                            title: const Text(
                              "Cerrar Sesión",
                              style: TextStyle(
                                fontSize: 13,
                              ),
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
