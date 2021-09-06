
import 'package:flutter/material.dart';
import 'package:general_products_web/constants/route_names.dart';
import 'package:general_products_web/models/plant_model.dart';
import 'package:general_products_web/provider/list_user_provider.dart';
import 'package:general_products_web/provider/tinta/tintasProvider.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:general_products_web/widgets/app_scaffold.dart';
import 'package:general_products_web/widgets/custom_button.dart';
import 'package:general_products_web/widgets/custom_expansio_tile.dart';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
//import 'package:web_upload/apps/main_app.dart';
import 'package:general_products_web/widgets/tinta/tinta_dialog.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/provider/routes_provider.dart';



class TintaImport extends StatefulWidget {
  const TintaImport({Key? key}) : super(key: key);

  @override
  _TintaImportState createState() => _TintaImportState();
}

class _TintaImportState extends State<TintaImport> {
  TintaDialog tintaDialog = TintaDialog();
  RoutesProvider routes = RoutesProvider();
  
  late Future futureTintas;
  late Future futureFields;
  bool isLoading = false;
  Plant plant = Plant();
  TintasProvider tintasProvider = TintasProvider();
  ListUsersProvider listProvider = ListUsersProvider();

  final GlobalKey<AppExpansionTileState> plantsKey = new GlobalKey();
  late List<int> _selectedFile;
  late Uint8List _bytesData;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result!);
      });
      reader.readAsDataUrl(file);
    });
  }

  void _handleResult(Object result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
  }

  Future<String> makeRequest() async {
   // print(_selectedFile);
 
    var url = Uri.parse(routes.urlBase + routes.importarTintas);
    //String url = ;
    var request = new http.MultipartRequest("POST", url);
    request.headers.addAll({
          "Authorization": "Bearer ${RxVariables.token}"
      });

      request.fields['_method'] = "PUT";
      request.fields['id_cat_planta'] = "1";



      request.files.add(await http.MultipartFile.fromBytes(
        'file', _selectedFile,
        contentType: new MediaType('application', 'text/csv'),
        filename: "file_up"));

    request.send().then((response) {
      print("test");
      print(response.statusCode);
      if (response.statusCode == 200) print("Uploaded!");
    });

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
          title: Center(
              child: Text(
            "demo",//title,
            textAlign: TextAlign.center,
          )),
          content: SingleChildScrollView(
            child: Center(
                child: Column(
              children: [
                Text(
                  "data",//detail,
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width < 600
                          ? MediaQuery.of(context).size.width * .5
                          : MediaQuery.of(context).size.width * .3,
                      child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Aceptar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            // Navigator.pushReplacementNamed(
                            //     context, RouteNames.tintaIndex);
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 2,
                              primary: GPColors.PrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    )),
              ],
            )),
          ),
        );
        }
        );
        return "";
  }


  @override
  void initState() {
    futureFields = listProvider.listUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 1000;

    return AppScaffold(
      pageTitle: 'Catálogos / Tintas / Importar',
      backButton: true,
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
                            'Importar Tintas Mediante Archivo .CSV',
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
                                                child:
                                            CustomButton(
                                              width: MediaQuery.of(context).size.width *.2,
                                              title: 'Selecciona un archivo',
                                              isLoading: false,
                                              onPressed: () {
                                                startWebFilePicker();
                                              },
                                            ),),
                                            SizedBox(width: 15),
                                            Flexible(child: listPlants()),
                                             SizedBox(width: 15),
                                            CustomButton(
                                              width: MediaQuery.of(context).size.width *.2,
                                              title: 'Importar',
                                              isLoading: false,
                                              onPressed: () {
                                              makeRequest();
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

  Widget listPlants() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey[100]),
      child: AppExpansionTile(
        key: plantsKey,
        initiallyExpanded: false,
        title: Text(
          plant.nombrePlanta ?? "Planta",
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
                            plantsKey.currentState!.collapse();
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
