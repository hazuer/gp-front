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

  List<Tinta> _listaDeTintas = [];
  Tinta _tintas = Tinta();

  // Esta es la funcion que utilizo para recibir los datos en el
  // listado de las tintas para la creación de la OE
  // Vienen de manera posicional
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
    // Cada dato se asigna a su campo correspondiente para crear el
    // Mapa de tipo String,dynamic, es decir, su campo y valor correspondiente
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
    };

    // La variable data se asigna a la variable _tintas para que pueda
    // tener el tipado correcto
    _tintas = Tinta.fromJson(data);

    // No hay que dejar los prints, pero aquí siguen porque es donde
    // visualizo los datos y como los estoy recibiendo

    // print('Lista de listas: $_tintas');
    // print('Peso individual: ${_tintas.pesoIndividual}');
    // Se agrega cada tina a un listado de tintas, este es una lista
    // de tipo Tinta
    _listaDeTintas.add(_tintas);
    // print('Lista de tintas: $_listaDeTintas');
    // Esta solo es una comprobación
    _listaDeTintas.forEach((element) {
      // print('Peso individual en foreach: ${element.pesoIndividual}');
    });
  }

  // Este es el getter que se utiliza para el listado de las tintas
  // en la creación de las OE
  // Se utiliza para exponer la propiedad _listaDeTintas
  get listaDeTintas {
    // return _tintas;
    return _listaDeTintas;
  }
}
