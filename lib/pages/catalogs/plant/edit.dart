import 'package:flutter/material.dart';
//import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'package:general_products_web/widgets/input_custom.dart';
import 'package:general_products_web/provider/catalogs/plant/plantsProvider.dart';
import 'package:general_products_web/widgets/catalogs/plant/plantaDialog.dart';
import 'package:general_products_web/models/catalogs/plant/catPaisModel.dart';

import '../../../widgets/app_scaffold.dart';

class PlantEdit extends StatefulWidget {
  PlantEdit({Key? key}) : super(key: key);

  @override
  _PlantEditState createState() => _PlantEditState();
}

class _PlantEditState extends State<PlantEdit> {
  late Future futurecatPais;
  bool isLoading                  = false;
  String headerFilter             = "?porPagina = 20";
  TextEditingController plantCtrl = TextEditingController();
  CatPaisModel catPais            = CatPaisModel();
  PlantsProvider plantsProvider   = PlantsProvider();
  PlantDialog dialogs             = PlantDialog();
  final GlobalKey<AppExpansionTileState> catPaisKey    = new GlobalKey();
  final GlobalKey<AppExpansionTileState> catEstatusKey = new GlobalKey();

  @override
  void initState() {
    futurecatPais     = plantsProvider.getAllPais();
    plantCtrl.text    = RxVariables.gvPlantSelectedById.nombrePlanta!;
    catPais.idCatPais = RxVariables.gvPlantSelectedById.idCatPais; //setear el valor del id del catalogo de pais
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;

    return AppScaffold(
      pageTitle: "Catálogos / Plantas / Editar",
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffF5F6F5),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                //height: MediaQuery.of(context).size.width*.8,
                margin:EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child:Column(children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xffffffff),
                    padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text('Editar', style:
                          TextStyle(
                            color: Color(0xff313945),
                            fontSize: 13.00,
                            fontWeight: FontWeight.w200
                          ),
                        ),
                        Divider(),
                        SizedBox(height: 10),
                        // __ __
                        //|  \  \ ___  _ _
                        //|     |/ . \| | |
                        //|_|_|_|\___/|__/
                        displayMobileLayout ? 
                        ListView(
                          shrinkWrap: true,
                          children: [
                            SizedBox(height: 15,),
                            CustomInput(controller: plantCtrl, hint: "* Nombre Planta"),
                            SizedBox(height: 15,),
                            listPais(),
                            SizedBox(height: 15,),
                            CustomButton(
                              width: MediaQuery.of(context).size.width *.2,
                              title: 'Guardar',
                              isLoading: false,
                              onPressed: () async {
                                if(plantCtrl.text =="" || catPais.idCatPais == null){
                                  dialogs.showInfoDialog(context, "¡Atención!", "Favor de validar los campos marcados con asterisco (*)");
                                }else{
                                  await PlantsProvider().editPlant(RxVariables.gvPlantSelectedById.idCatPlanta!,plantCtrl.text.trim(), catPais.idCatPais!,).then((value) {
                                  if (value == null) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.pop(context);
                                    dialogs.showInfoDialog(context, "¡Error!", "Ocurrió un error al crear la planta : ${RxVariables.errorMessage}");
                                    } else {
                                      final typeAlert = (value["result"]) ? "¡Éxito!": "¡Error!";
                                      final message   = value["message"];
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.pop(context);
                                      dialogs.showInfoDialog(context,typeAlert, message);
                                      //Navigator.pushReplacementNamed(context, RouteNames.clienteIndex);
                                    }
                                  });
                                }
                              },
                            ),
                          ],
                        )
                        // _ _ _       _
                        //| | | | ___ | |_
                        //| | | |/ ._>| . \
                        //|__/_/ \___.|___/
                        : 
                        Container(
                          height:MediaQuery.of(context).size.height * .7,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    Flexible(
                                      child: CustomInput(
                                        controller:plantCtrl,
                                        hint: "* Nombre Planta"
                                      )
                                    ),
                                    SizedBox(width: 15,),
                                    Flexible(child: listPais()),
                                    SizedBox(width: 15,),
                                    Flexible(child:
                                    CustomButton(
                                      width: MediaQuery.of(context).size.width *.2,
                                      title: 'Guardar',
                                      isLoading: false,
                                      onPressed: () async {
                                      if(plantCtrl.text =="" || catPais.idCatPais == null){
                                        dialogs.showInfoDialog(context, "¡Atención!", "Favor de validar los campos marcados con asterisco (*)");
                                      }else{
                                        await PlantsProvider().editPlant(RxVariables.gvPlantSelectedById.idCatPlanta!,plantCtrl.text.trim(), catPais.idCatPais!).then((value) {
                                        if (value == null) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.pop(context);
                                          dialogs.showInfoDialog(context, "¡Error!", "Ocurrió un error al crear la planta : ${RxVariables.errorMessage}");
                                          } else {
                                            final typeAlert = (value["result"]) ? "¡Éxito!": "¡Error!";
                                            final message   = value["message"];
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Navigator.pop(context);
                                            dialogs.showInfoDialog(context,typeAlert, message);
                                            //Navigator.pushReplacementNamed(context, RouteNames.clienteIndex);
                                          }
                                        });
                                      }
                                    },
                                    )
                                  ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ])
              )
            ],
          ),
        ),
      )
    );
  }

 Widget listPais() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: AppExpansionTile(
        key: catPaisKey,
        initiallyExpanded: false,
        title: Text(
          catPais.nombrePais ?? RxVariables.gvPlantSelectedById.nombrePais!,  //Seteo de titutlo para mostrar
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
        children: [
          Container(
            //height: MediaQuery.of(context).size.height*.2,
            child: FutureBuilder(
              future: futurecatPais,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    //physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: RxVariables.gvListCatPais.listCountries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            catPais = RxVariables.gvListCatPais.listCountries[index];
                            catPaisKey.currentState!.collapse();
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
                                  RxVariables.gvListCatPais.listCountries[index].nombrePais!,
                                  style: TextStyle(color: Colors.black54, fontSize: 13)
                                ),
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
