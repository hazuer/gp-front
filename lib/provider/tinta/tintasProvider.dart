// import 'dart:html';
import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:general_products_web/models/tinta/tintasModel.dart';
import 'package:general_products_web/provider/routes_provider.dart';
// import 'package:gx_file_picker/gx_file_picker.dart';
import 'package:general_products_web/resources/global_variables.dart';
import 'package:grizzly_io/io_loader.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

class TintasProvider {
  RoutesProvider routes = RoutesProvider();
  final Options headerWithToken = new Options(headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Requested-With': "XMLHttpRequest",
    "Authorization": "Bearer ${RxVariables.token}"
  });

  Future listTintas() async {
    List<InkList> listActives = [];
    RxVariables.errorMessage = '';
    ListTintasModel listTintasModel = ListTintasModel(inkList: []);

    String url = routes.urlBase + routes.listarTintas;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listTintasModel = ListTintasModel.fromJson(resp.data);
      listTintasModel.inkList.forEach((element) {
        if (element.estatus!.toLowerCase() == 'activo') {
          listActives.add(element);
        }
      });
      rxVariables.listTintasFilter.sink.add(listActives);
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listTintasFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future listTintasWithFiltter(String path) async {
    List<InkList> listFilters = [];
    RxVariables.errorMessage = '';
    ListTintasModel listTintasModel = ListTintasModel(inkList: []);

    String url = routes.urlBase + routes.listarTintas + path;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listTintasModel = ListTintasModel.fromJson(resp.data);
      listTintasModel.inkList.forEach((element) {
        listFilters.add(element);
      });
      rxVariables.listTintasFilter.sink.add(listFilters);
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listTintasFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future crearTinta(String nombreTinta, String codigoCliente, String codigoGp,
      int idPlanta) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.crearTintas;

    try {
      final dio = Dio();
      final data = {
        'nombre_tinta': nombreTinta,
        'codigo_cliente': codigoCliente,
        'codigo_gp': codigoGp,
        'id_cat_planta': idPlanta,
      };

      final resp = await dio.post(url, data: data, options: headerWithToken);

      await listTintas();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listTintasFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future editarTinta(int idTinta, String nombreTinta, String codigoCliente,
      String codigoGp, int idPlanta) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.editarTintas;

    try {
      final dio = Dio();
      final data = {
        'id_cat_tinta': idTinta,
        'nombre_tinta': nombreTinta,
        'codigo_cliente': codigoCliente,
        'codigo_gp': codigoGp,
        'id_cat_planta': idPlanta,
      };

      final resp = await dio.post(url, data: data, options: headerWithToken);

      await listTintas();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listTintasFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future editarEstatusTinta(int idTinta, int idStatus) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.changeEstatusTintas;

    try {
      final dio = Dio();

      final data = {'id_cat_tinta': idTinta, 'id_cat_estatus': idStatus};

      final resp = await dio.post(url, data: data, options: headerWithToken);

      await listTintas();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      return null;
    }
  }

  // Los prints de aquí aun están siendo utilizados
  Future loadFromStorage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['csv'],
      type: FileType.custom,
    );
    // print(result!.files.first.name);
    final values = CsvToListConverter().convert(result!.files.first.name);
    String csv = encodeCsv(values);
    // print(csv);
    // print(values.first);

    List<List<dynamic>> cvsList = CsvToListConverter().convert(csv);
    // print(csv);
    String path = result.files.first.path!;
    // print(path);

    // final csvFile = File(path).openRead();
    // print(csvFile);
    // final fields = await csvFile
    //     .transform(utf8.decoder)
    //     .transform(CsvToListConverter())
    //     .toList();

    // print(fields);
  }

  late PlatformFile selectedFile;
  Future importCvsFile() async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles(
    //   allowMultiple: false,
    //   withData: true,
    //   type: FileType.custom,
    //   allowedExtensions: ['csv'],
    // );

    // if (result != null) {
    //   selectedFile = result.files.first;
    // }
    // print('${result!.names}');
    // print(selectedFile.name);

    // final input = File(file.path)

    // final data = await rootBundle.loadString('Prueba1.csv');
    final data = await rootBundle.loadString('Prueba1.csv');
    // print(data);
    List<List<dynamic>> csvTable = CsvToListConverter().convert(data);
    // print(csvTable);
  }

  late List csvList;
  List csvFileContentList = [];
  List csvModuleList = [];

  Future importCsv(int idPlanta, FilePickerResult file) async {
    // FilePickerResult? file = await FilePicker.platform.pickFiles();
    // print('Print en Provider ${file.names}');
    // print('Print del Id $idPlanta');

    final tsv = await readCsv('$file');
    // print('PRint de prueba');

    // print(tsv);
    // print('PRint de prueba');

    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.importarTintas;

    try {
      final dio = Dio();
      final data = {
        'id_cat_planta': idPlanta,
        'archivo_tintas_importar': file,
      };

      final resp = await dio.post(url, data: data, options: headerWithToken);

      // print(resp.data);
      await listTintas();
      // return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listTintasFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }
}
