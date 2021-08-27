import 'package:flutter/material.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/models/status_model.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/provider/tinta/tintasProvider.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/app_scaffold.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/widgets/tinta/tinta_dialog.dart';

class TintaEdit extends StatefulWidget {
  const TintaEdit({Key? key}) : super(key: key);

  @override
  _TintaEditState createState() => _TintaEditState();
}

class _TintaEditState extends State<TintaEdit> {
  late Future futureTintas;
  late Future futureFields;
  bool isLoading = false;
  TextEditingController tintaCtrl = TextEditingController();
  TextEditingController codigoGpCtrl = TextEditingController();
  TextEditingController codigoSapCtrl = TextEditingController();
  Plant plant = Plant();
  TintaDialog dialogs = TintaDialog();
  StatusModel status = StatusModel();
  TintasProvider tintasProvider = TintasProvider();
  ListUsersProvider listProvider = ListUsersProvider();

  final GlobalKey<AppExpansionTileState> statusKey = new GlobalKey();

  @override
  void initState() {
    futureTintas = tintasProvider.listTintas();
    tintaCtrl.text = RxVariables.tintaSelected.nombreTinta!;
    codigoGpCtrl.text = RxVariables.tintaSelected.codigoGp!;
    codigoSapCtrl.text = RxVariables.tintaSelected.codigoCliente!;

    futureFields = listProvider.listUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;
    final nombrePlanta = RxVariables.tintaSelected.nombrePlanta!;
    final actualPlant = RxVariables.dataFromUsers.listPlants!
        .where((element) => element.nombrePlanta == nombrePlanta);
    int? idPlanta;
    for (var item in actualPlant) {
      idPlanta = item.idCatPlanta!;
    }

    return AppScaffold(
      pageTitle: 'Catálogos / Tintas / Editar',
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffF5F6F5),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                //height: MediaQuery.of(context).size.width*.8,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                                        hint: 'Tinta', controller: tintaCtrl),
                                    SizedBox(height: 15),
                                    CustomInput(
                                        hint: 'Código GP',
                                        controller: codigoGpCtrl),
                                    SizedBox(height: 15),
                                    CustomInput(
                                        hint: 'Código SAP',
                                        controller: codigoSapCtrl),
                                    SizedBox(height: 15),
                                    CustomButton(
                                      width: MediaQuery.of(context).size.width *
                                          .2,
                                      title: 'Guardar',
                                      isLoading: false,
                                      onPressed: () async {
                                        if (tintaCtrl.text == "" ||
                                            codigoGpCtrl.text == "" ||
                                            codigoSapCtrl.text == "") {
                                          dialogs.showInfoDialog(
                                              context,
                                              "¡Atención!",
                                              "Favor de validar los campos marcados con asterisco (*)");
                                        } else {
                                          await TintasProvider()
                                              .editarTinta(
                                            RxVariables
                                                .tintaSelected.idCatTinta!,
                                            tintaCtrl.text.trim(),
                                            codigoSapCtrl.text.trim(),
                                            codigoGpCtrl.text.trim(),
                                            idPlanta!,
                                          )
                                              .then((value) {
                                            if (value == null) {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Navigator.pop(context);
                                              dialogs.showInfoDialog(
                                                  context,
                                                  "¡Error!",
                                                  "Ocurrió un error al editar la tinta : ${RxVariables.errorMessage}");
                                            } else {
                                              final typeAlert =
                                                  (value["result"])
                                                      ? "¡Éxito!"
                                                      : "¡Error!";
                                              final message = value["message"];
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Navigator.pop(context);
                                              dialogs.showInfoDialog(
                                                  context, typeAlert, message);
                                            }
                                          });
                                        }
                                        // await tintasProvider.editarTinta(
                                        //   RxVariables.tintaSelected.idCatTinta!,
                                        //   tintaCtrl.text.trim(),
                                        //   codigoSapCtrl.text.trim(),
                                        //   codigoGpCtrl.text.trim(),
                                        //   idPlanta!,
                                        // );
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
                                                    hint: 'Tinta',
                                                    controller: tintaCtrl)),
                                            SizedBox(width: 15),
                                            Flexible(
                                                child: CustomInput(
                                                    hint: 'Código GP',
                                                    controller: codigoGpCtrl)),
                                            SizedBox(width: 15),
                                            Flexible(
                                                child: CustomInput(
                                                    hint: 'Código SAP',
                                                    controller: codigoSapCtrl)),
                                            SizedBox(width: 15),
                                            CustomButton(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .2,
                                              title: 'Guardar',
                                              isLoading: false,
                                              onPressed: () async {
                                                if (tintaCtrl.text == "" ||
                                                    codigoGpCtrl.text == "" ||
                                                    codigoSapCtrl.text == "") {
                                                  dialogs.showInfoDialog(
                                                      context,
                                                      "¡Atención!",
                                                      "Favor de validar los campos marcados con asterisco (*)");
                                                } else {
                                                  await TintasProvider()
                                                      .editarTinta(
                                                    RxVariables.tintaSelected
                                                        .idCatTinta!,
                                                    tintaCtrl.text.trim(),
                                                    codigoSapCtrl.text.trim(),
                                                    codigoGpCtrl.text.trim(),
                                                    idPlanta!,
                                                  )
                                                      .then((value) {
                                                    if (value == null) {
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      Navigator.pop(context);
                                                      dialogs.showInfoDialog(
                                                          context,
                                                          "¡Error!",
                                                          "Ocurrió un error al editar la tinta : ${RxVariables.errorMessage}");
                                                    } else {
                                                      final typeAlert =
                                                          (value["result"])
                                                              ? "¡Éxito!"
                                                              : "¡Error!";
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
