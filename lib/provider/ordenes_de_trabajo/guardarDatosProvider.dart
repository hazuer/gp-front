import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/createOrdenesEntregaModel.dart';
import 'package:general_products_web/resources/global_variables.dart';

class GuardarDatos with ChangeNotifier {
  final Options headerWithToken = new Options(headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Requested-With': "XMLHttpRequest",
    "Authorization": "Bearer ${RxVariables.token}"
  });
  // late int id_cat_tinta,
  // late int lote,
  // late int id_cat_tara,
  // late double peso_individual,
  // late bool utiliza_ph,
  // late bool mide_viscosidad,
  // late bool utiliza_filtro,
  // late double porcentaje_variacion,
  // late double peso_individual_gp,
  // late int id_cat_lectura_gp,
  // late int id_cat_razon,
  // late int aditivo_tinta,
  // late int aditivo
  // CreateOrdenesEntregaModel oeModel = CreateOrdenesEntregaModel(tintas: []);
  // List<Tinta> listTintas = [];

  // Future gurardarDatos(
  //     int idCatTinta,
  //     int lote,
  //     int idCatTara,
  //     double pesoIndividual,
  //     bool utilizaPh,
  //     bool mideViscosidad,
  //     bool utilizaFiltro,
  //     double porcentajeVariacion,
  //     double pesoIndividualGp,
  //     int idCatLecturaGp,
  //     int idCatRazon,
  //     String aditivoTinta,
  //     int aditivo) async {
  //   print('Estamos dentro');
  //   final dynamic data = [
  //     idCatTinta,
  //     lote,
  //     idCatTara,
  //     pesoIndividual,
  //     utilizaPh,
  //     mideViscosidad,
  //     utilizaFiltro,
  //     porcentajeVariacion,
  //     pesoIndividualGp,
  //     idCatLecturaGp,
  //     idCatRazon,
  //     aditivoTinta,
  //     aditivo
  //   ];

  //   final data2 = {
  //     'id_cat_tinta': idCatTinta,
  //     'lote': lote,
  //     'id_cat_tara': idCatTara,
  //     'peso_individual': pesoIndividual,
  //     'utiliza_ph': utilizaPh,
  //     'mide_viscosidad': mideViscosidad,
  //     'utiliza_filtro': utilizaFiltro,
  //     'porcentaje_variacion': porcentajeVariacion,
  //     'peso_individual_gp': pesoIndividualGp,
  //     'id_cat_lectura_gp': idCatLecturaGp,
  //     'id_cat_razon': idCatRazon,
  //     'aditivo_tinta': aditivoTinta,
  //     'aditivo': aditivo
  //   };
  //   (data != null)
  //       ? print('Llegó la data')
  //       : print('No hay datos'); // fromModel = Tinta.fromJson(data);
  //   print(data2.length);
  //   oeModel = CreateOrdenesEntregaModel.fromJson(data2);
  //   (oeModel.tintas.isNotEmpty)
  //       ? print('Llegó la data')
  //       : print('No hay datos');
  //   // oeModel = Tinta.fromJson(data) as CreateOrdenesEntregaModel;
  //   print(oeModel.tintas);
  //   oeModel.tintas.forEach((element) {
  //     listTintas.add(element!);
  //   });
  //   print(listTintas);
  //   print(listTintas[0]);
  //   notifyListeners();
  // }

  // Future gurardarDatos2(
  //     int idCatTinta,
  //     int lote,
  //     int idCatTara,
  //     double pesoIndividual,
  //     bool utilizaPh,
  //     bool mideViscosidad,
  //     bool utilizaFiltro,
  //     double porcentajeVariacion,
  //     double pesoIndividualGp,
  //     int idCatLecturaGp,
  //     int idCatRazon,
  //     int aditivoTinta,
  //     int aditivo) async {
  //   final data = {
  //     'id_cat_tinta': idCatTinta,
  //     'lote': lote,
  //     'id_cat_tara': idCatTara,
  //     'peso_individual': pesoIndividual,
  //     'utiliza_ph': utilizaPh,
  //     'mide_viscosidad': mideViscosidad,
  //     'utiliza_filtro': utilizaFiltro,
  //     'porcentaje_variacion': porcentajeVariacion,
  //     'peso_individual_gp': pesoIndividualGp,
  //     'id_cat_lectura_gp': idCatLecturaGp,
  //     'id_cat_razon': idCatRazon,
  //     'aditivo_tinta': aditivoTinta,
  //     'aditivo': aditivo
  //   };
  //   // fromModel = Tinta.fromJson(data);
  //   oeModel = CreateOrdenesEntregaModel.fromJson(data);
  //   oeModel.tintas.forEach((element) {
  //     listTintas.add(element!);
  //   });
  //   notifyListeners();
  // }

  // List<List<dynamic>> _listaDeListas = [];

  // List<List<Tinta>> _listTintas = [];
  // obtenerDatos(List<dynamic> datos) {
  //   datos.forEach((element) {
  //     print(element);
  //   });
  //   _listaDeListas.add(datos);
  //   // _listTintas.add(datos as List<Tinta>);

  //   print('Lista de listas: $_listaDeListas');
  // }

  // get listaDeListas {
  //   return _listaDeListas;
  //   // return _listTintas;
  // }

  // Dejé el resto comentado para que tengas como referencia lo que
  // intenté hacer anteriormente, pero esta es la parte que me pareció
  // más aceptable
  List<Tinta> _listaDeTintas = [];
  Tinta _tintas = Tinta();

  // Esta es la funcion que utilizo para recibir los datos en el
  // listado de las tintas para la creación de la OE
  obtenerDatosComoCampos(
    int idTinta,
    int lote,
    int idTara,
    bool ph,
    bool viscosidad,
    bool filtro,
    double pesos,
    int idLectura,
    int idRazon,
    String aditivoTinta,
    int aditivo,
    // int porcentajeVariacion,
    // int pesoIndividualGp,
  ) {
    final data = {
      'id_cat_tinta': idTinta,
      'lote': lote,
      'id_cat_tara': idTara,
      'utiliza_ph': ph,
      'mide_viscosidad': viscosidad,
      'utiliza_filtro': filtro,
      'peso_individual': pesos,
      'id_cat_lectura_gp': idLectura,
      'id_cat_razpn': idRazon,
      'aditivo_tinta': aditivoTinta,
      'aditivo': aditivo,
      // 'porcentaje_variacion': porcentajeVariacion,
      // 'peso_individual_gp': pesoIndividualGp,
    };

    _tintas = Tinta.fromJson(data);

    // datos.forEach((element) {
    //   print(element);
    // });
    // _listaDeListas.add(datos);
    // _listTintas.add(datos as List<Tinta>);

    // No hay que dejar los prints, pero aquí siguen porque es donde
    // visualizo los datos y como los estoy recibiendo

    print('Lista de listas: $_tintas');
    print('Peso individual: ${_tintas.pesoIndividual}');
    _listaDeTintas.add(_tintas);
    // print('Lista de tintas: $_listaDeTintas');
    _listaDeTintas.forEach((element) {
      print('Peso individual en foreach: ${element.pesoIndividual}');
    });
  }

  // Este es el getter que se utiliza para el listado de las tintas
  // en la creación de las OE
  get listaDeTintas {
    // return _tintas;
    return _listaDeTintas;
  }

  // get tintas {
  //   return _tintas;
  // }

  // get listaDeListas {
  //   return _listaDeListas;
  //   // return _listTintas;
  // }

  // obtenerDatosMap(List<Tinta> datos) {
  //   datos.forEach((element) {
  //     print(element);
  //     print(element.pesoIndividual);
  //     tintas.aditivo = element.idCatTinta;
  //   });
  //   _listaDeListas.add(datos);
  //   // _listTintas.add(datos as List<Tinta>);

  //   print('Lista de listas: $_listaDeListas');
  // }

  // get listaDeListas2 {
  //   return _listaDeListas;
  //   // return _listTintas;
  // }

  // calcularPeso(List<double> pesos) {
  //   double i = 0;

  //   pesos.forEach((element) {
  //     i += element;
  //   });
  //   _pesoCalculado = i;

  //   print(_pesoCalculado);
  //   notifyListeners();
  // }
}
