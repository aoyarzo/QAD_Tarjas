import 'package:flutter/material.dart';

class TarjaProvider with ChangeNotifier {

  String _dominio = 'dom';
  String _fundo = '';
  String _fundoNombre = '';
  String _fecha = '';
  int _linea = 0;
  String _empleado = '';
  String _empleadoNombre = '';
  String _operacion = '';
  String _operacionNombre = '';
  String _operacionUM = '';
  String _pago = '';
  String _pagoNombre = '';
  int _pagoTipo = 0;
  String _hora = '';
  String _horaNombre = '';
  double _jornada = 1;
  double _registro = 0;
  double _hextra = 0;
  int _procesado = 0;
  String _estado = '';
  int _opManual = 0;
  int _contratista = 0;
  double _cantidad = 0;
  bool _hasInternet = false;
   

  String get dominio => _dominio;
  set dominio(String value) {
    _dominio = value;
    notifyListeners();
  }

  String get fundo => _fundo;
  set fundo(String value) {
    _fundo = value;
    notifyListeners();
  }

  String get fundoNombre => _fundoNombre;
  set fundoNombre(String value) {
    _fundoNombre = value;
    notifyListeners();
  }

  String get fecha => _fecha;
  set fecha(String value) {
    _fecha = value;
    notifyListeners();
  }

  int get linea => _linea;
  set linea(int value) {
    _linea = value;
    notifyListeners();
  }

  String get empleado => _empleado;
  set empleado(String value) {
    _empleado = value;
    notifyListeners();
  }

  String get empleadoNombre => _empleadoNombre;
  set empleadoNombre(String value) {
    _empleadoNombre = value;
    notifyListeners();
  }

  String get operacion => _operacion;
  set operacion(String value) {
    _operacion = value;
    notifyListeners();
  }

  String get operacionNombre => _operacionNombre;
  set operacionNombre(String value) {
    _operacionNombre = value;
    notifyListeners();
  }

  String get operacionUM => _operacionUM;
  set operacionUM(String value) {
    _operacionUM = value;
    notifyListeners();
  }

  String get pago => _pago;
  set pago(String value) {
    _pago = value;
    notifyListeners();
  }

  String get pagoNombre => _pagoNombre;
  set pagoNombre(String value) {
    _pagoNombre = value;
    notifyListeners();
  }

  int get pagoTipo => _pagoTipo;
  set pagoTipo(int value) {
    _pagoTipo= value;
    notifyListeners();
  }


  String get hora => _hora;
  set hora(String value) {
    _hora = value;
    notifyListeners();
  }

  String get horaNombre => _horaNombre;
  set horaNombre(String value) {
    _horaNombre = value;
    notifyListeners();
  }

  double get jornada => _jornada;
  set jornada(double value) {
    _jornada = value;
    notifyListeners();
  }

  double get registro => _registro;
  set registro(double value) {
    _registro = value;
    notifyListeners();
  }

  double get hextra => _hextra;
  set hextra(double value) {
    _hextra = value;
    notifyListeners();
  }

  int get procesado => _procesado;
  set procesado(int value) {
    _procesado = value;
    notifyListeners();
  }

  String get estado => _estado;
  set estado(String value) {
    _estado = value;
    notifyListeners();
  }

  int get opManual => _opManual;
  set opManual(int value) {
    _opManual = value;
    notifyListeners();
  }

  int get contratista => _contratista;
  set contratista(int value) {
    _contratista = value;
    notifyListeners();
  }

  double get cantidad => _cantidad;
  set cantidad(double value) {
    _cantidad = value;
    notifyListeners();
  }

  bool get hasInternet => _hasInternet;
  set hasInternet(bool value) {
    _hasInternet = value;
    notifyListeners();
  }

}