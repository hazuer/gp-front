import 'package:flutter/material.dart';

class CalcularPeso with ChangeNotifier {
  double _pesoCalculado = 0.0;
  String _titulo = 'Titulo de prueba';
  get tituloDePrueba {
    return _titulo;
  }

  calcularPeso(List<double> pesos) {
    double i = 0;

    pesos.forEach((element) {
      i += element;
    });
    _pesoCalculado = i;

    print(_pesoCalculado);
    notifyListeners();
  }

  get pesoCalculado {
    return _pesoCalculado;
  }
}
