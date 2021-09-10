import 'package:general_products_web/resources/colors.dart';
import 'package:flutter/material.dart';
import 'app_drawer.dart';

/// A responsive scaffold for our application.
/// Displays the navigation drawer alongside the [Scaffold] if the screen/window size is large enough
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    required this.pageTitle,
    // this.actions,
    this.backButton = false,
    Key? key,
  }) : super(key: key);

  final Widget body;
  // final List<Widget>? actions;
  final bool backButton;

  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;
    return Row(
      children: [
        if (!displayMobileLayout)
          const AppDrawer(
            permanentlyDisplay: true,
          ),
        Expanded(
          child: Scaffold(
            //backgroundColor: Color(0xffF5F6F5),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(40.0),
              child: AppBar(
                actions: backButton
                    ? [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back),
                          tooltip: 'Regresar',
                        ),
                        SizedBox(width: 10.0),
                      ]
                    : null,
                // when the app isn't displaying the mobile version of app, hide the menu button that is used to open the navigation drawer
                automaticallyImplyLeading: displayMobileLayout,
                title: Text(pageTitle,
                    style: TextStyle(
                        color: GPColors.BreadcrumTitle,
                        fontSize: 16.00,
                        fontWeight: FontWeight.w100)),
                iconTheme: IconThemeData(color: Color(0xff313945)),
              ),
            ),
            drawer: displayMobileLayout
                ? const AppDrawer(
                    permanentlyDisplay: false,
                  )
                : null,
            body: body,
          ),
        )
      ],
    );
  }
}
