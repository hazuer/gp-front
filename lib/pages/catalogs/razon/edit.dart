import 'package:flutter/material.dart';
import 'package:general_products_web/app/auth/login.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/models/status_model.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/provider/catalogs/razon/razonesProvider.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/app_scaffold.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/widgets/catalogs/razon/razonDialog.dart';

class RazonEdit extends StatefulWidget {
  const RazonEdit({Key? key}) : super(key: key);

  @override
  _RazonEditState createState() => _RazonEditState();
}

class _RazonEditState extends State<RazonEdit> {
  late Future futureFields;
  bool isLoading = false;
  TextEditingController razonCtrl = TextEditingController();
  RazonDialog dialogs = RazonDialog();
  Plant plant = Plant();
  StatusModel status = StatusModel();
  RazonesProvider razonesProvider = RazonesProvider();
  ListUsersProvider listProvider = ListUsersProvider();

  final GlobalKey<AppExpansionTileState> plantKey = new GlobalKey();
  final GlobalKey<AppExpansionTileState> statusKey = new GlobalKey();

  final currentUser = RxVariables.loginResponse.data!;

  @override
  void initState() {
    futureFields = listProvider.listUsers();
    razonCtrl.text = RxVariables.gvRazonSelected.razon!;
    plant.idCatPlanta = RxVariables.gvRazonSelected.idCatPlanta!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;

    if (currentUser.catProfile!.profileId != 1) {
      ListUsersProvider().logOut();

      return LoginPage();
    } else {
      return AppScaffold(
        pageTitle: 'Cat??logos / Razones / Editar',
        backButton: true,
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xffF5F6F5),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  //height: MediaQuery.of(context).size.width*.8,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xffffffff),
                        padding: EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Editar',
                              style: TextStyle(
                                  color: Color(0xff313945),
                                  fontSize: 13.00,
                                  fontWeight: FontWeight.w200),
                            ),
                            Divider(),
                            SizedBox(height: 10),
                            displayMobileLayout
                                ? ListView(
                                    shrinkWrap: true,
                                    children: [
                                      CustomInput(
                                          hint: '* Raz??n',
                                          controller: razonCtrl),
                                      SizedBox(height: 15),
                                      listPlants(),
                                      SizedBox(height: 15),
                                      CustomButton(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        title: 'Guardar',
                                        isLoading: false,
                                        onPressed: () async {
                                          if (razonCtrl.text == "" ||
                                              plant.idCatPlanta == null) {
                                            dialogs.showInfoDialog(
                                                context,
                                                "??Atenci??n!",
                                                "Favor de validar los campos marcados con asterisco (*)");
                                          } else {
                                            await RazonesProvider()
                                                .editarRazon(
                                                    RxVariables.gvRazonSelected
                                                        .idCatRazon!,
                                                    razonCtrl.text.trim(),
                                                    plant.idCatPlanta!)
                                                .then((value) {
                                              if (value == null) {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                                Navigator.pop(context);
                                                dialogs.showInfoDialog(
                                                    context,
                                                    "??Error!",
                                                    "Ocurri?? un error al editar la raz??n : ${RxVariables.errorMessage}");
                                              } else {
                                                final typeAlert =
                                                    (value["result"])
                                                        ? "????xito!"
                                                        : "??Error!";
                                                final message =
                                                    value["message"];
                                                setState(() {
                                                  isLoading = false;
                                                });
                                                Navigator.pop(context);
                                                dialogs.showInfoDialog(context,
                                                    typeAlert, message);
                                              }
                                            });
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  )
                                : Container(
                                    height:
                                        MediaQuery.of(context).size.height * .7,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                  child: CustomInput(
                                                controller: razonCtrl,
                                                hint: '* Raz??n',
                                              )),
                                              SizedBox(width: 15),
                                              Flexible(child: listPlants()),
                                              SizedBox(width: 15),
                                              CustomButton(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .2,
                                                title: 'Guardar',
                                                isLoading: false,
                                                onPressed: () async {
                                                  if (razonCtrl.text == "" ||
                                                      plant.idCatPlanta ==
                                                          null) {
                                                    dialogs.showInfoDialog(
                                                        context,
                                                        "??Atenci??n!",
                                                        "Favor de validar los campos marcados con asterisco (*)");
                                                  } else {
                                                    await RazonesProvider()
                                                        .editarRazon(
                                                            RxVariables
                                                                .gvRazonSelected
                                                                .idCatRazon!,
                                                            razonCtrl.text
                                                                .trim(),
                                                            plant.idCatPlanta!)
                                                        .then((value) {
                                                      if (value == null) {
                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                        Navigator.pop(context);
                                                        dialogs.showInfoDialog(
                                                            context,
                                                            "??Error!",
                                                            "Ocurri?? un error al editar la raz??n : ${RxVariables.errorMessage}");
                                                      } else {
                                                        final typeAlert =
                                                            (value["result"])
                                                                ? "????xito!"
                                                                : "??Error!";
                                                        final message =
                                                            value["message"];
                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                        Navigator.pop(context);
                                                        dialogs.showInfoDialog(
                                                            context,
                                                            typeAlert,
                                                            message);
                                                      }
                                                    });
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget listPlants() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: AppExpansionTile(
        key: plantKey,
        initiallyExpanded: false,
        title: Text(
          plant.nombrePlanta ?? RxVariables.gvRazonSelected.nombrePlanta!,
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
        children: [
          Container(
            //height: MediaQuery.of(context).size.height*.2,
            child: FutureBuilder(
              future: futureFields,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    //physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: RxVariables.dataFromUsers.listPlants!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            plant =
                                RxVariables.dataFromUsers.listPlants![index];
                            plantKey.currentState!.collapse();
                          });
                        },
                        child: Container(
                          color: Colors.grey[100],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                    RxVariables.dataFromUsers.listPlants![index]
                                        .nombrePlanta!,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13)),
                              ),
                              Container(
                                width: double.infinity,
                                height: .5,
                                color: Colors.grey[300],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
