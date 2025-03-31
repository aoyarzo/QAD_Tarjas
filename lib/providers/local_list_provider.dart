import 'package:flutter/material.dart';
import 'package:qad_tarjas/local_models/local_models.dart';
import 'package:qad_tarjas/services/db_service.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';

class LocalListProvider extends ChangeNotifier {
  List<UserLocalModel> users = [];
  List<TfundoLocalModel> fundos = [];
  List<TempleadoLocalModel> empleados = [];
  List<ToperacionLocalModel> operaciones = [];
  //List<ToperacionLocalModel> ops = [];
  List<TtpagoLocalModel> tpago = [];
  List<TtpagoLocalModel> Alltpago = [];
  List<TthoraLocalModel> thora = [];
  List<TcuartelLocalModel> cuarteles = [];
  List<TDetCuartelLocalModel> Detcuarteles = [];
  List<ThileraLocalModel> hileras = [];
  //List<MaxHeLocalModel> _maxHE = [];
  double count = 0;
  double maxHE = 0;

  List<TtarjaLocalModel> tarjas = [];
  List<TtarjaLocalModel> tarjasHoy = [];
  List<TtarjaLocalModel> tarjasPend = [];
  List<TtarjaErrorLocalModel> tarjasNoEnviadas = [];
  List<TtarjaLocalModel> tarjasFundoFecha = [];
  List<TtarjaLocalModel> valEmpJor = [];
  bool _isLoading = false;
  bool _isLoadingQAD = false;
  bool _isLoadingLogin = false;
  bool _isLoadingConfig = false;
  String _selectedThora = '';
  int lastLinea = 0;
  int _index_selectedCuartel = 0;
  bool _validateCantPlant = false;
  int _countEnvioQAD = 0;
  int _countErrorEnvioQAD = 0;
  int _tarjaCreada = 0;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoadingQAD => _isLoadingQAD;
  set isLoadingQAD(bool value) {
    _isLoadingQAD = value;
    notifyListeners();
  }

  bool get isLoadingLogin => _isLoadingLogin;
  set isLoadingLogin(bool value) {
    _isLoadingLogin = value;
    notifyListeners();
  }

  bool get isLoadingConfig => _isLoadingConfig;
  set isLoadingConfig(bool value) {
    _isLoadingConfig = value;
    notifyListeners();
  }

  bool get validateCantPlant => _validateCantPlant;
  set validateCantPlant(bool value) {
    _validateCantPlant = value;
    notifyListeners();
  }

  String get selectedThora => _selectedThora;
  set selectedThora(String value) {
    _selectedThora = value;
    notifyListeners();
  }

  int get index_selectedCuartel => _index_selectedCuartel;
  set index_selectedCuartel(int value) {
    _index_selectedCuartel = value;
    notifyListeners();
  }

  int get countEnvioQAD => _countEnvioQAD;
  set countEnvioQAD(int value) {
    _countEnvioQAD = value;
    notifyListeners();
  }

  int get countErrorEnvioQAD => _countErrorEnvioQAD;
  set countErrorEnvioQAD(int value) {
    _countErrorEnvioQAD = value;
    notifyListeners();
  }

  int get tarjaCreada => _tarjaCreada;
  set tarjaCreada(int value) {
    _tarjaCreada = value;
    notifyListeners();
  }

  cargarTarjas(String dominio) async {
    final tarjas = await DBProvider.db.getAllTarjas(dominio);
    /*print(tarjas.length);
    for (int i = 0; i < tarjas.length; i++) {
      print(tarjas[i].ttarjaLinea);
    }*/
    this.tarjas = tarjas;
    notifyListeners();
  }

  cargarTarjasPendientes(String dominio, String estado) async {
    final tarjasPend = await DBProvider.db.getTarjasPendientes(dominio, estado);
    print(tarjasPend.length);
    for (int i = 0; i < tarjasPend.length; i++) {
      print(tarjasPend[i].ttarjaLinea);
    }
    this.tarjasPend = tarjasPend;
    notifyListeners();
  }

  /* cargarTarjasFundoFecha(String dominio, String fundo, String fecha,
      TarjaProvider TarjaProv) async {
    final tarjasFundoFecha =
        await DBProvider.db.getTarjaFundoFecha(dominio, fundo, fecha);
    print('TarjaFundoFecha: ' + tarjasFundoFecha.length.toString());
    TarjaProv.linea = tarjasFundoFecha.length + 1;
    print('Linea: '+TarjaProv.linea.toString());
    /*for (int i = 0; i < tarjasFundoFecha.length; i++) {
      print(tarjasFundoFecha[i].ttarjaLinea);
    }*/
    this.tarjasFundoFecha = tarjasFundoFecha;
    notifyListeners();
  }*/

  cargarValEmpleadoJornada(
      String fecha, String empleado, String thora, String dominio) async {
    final valEmpJor = await DBProvider.db
        .getValEmpleadoJornada(fecha, empleado, thora, dominio);
    this.valEmpJor = valEmpJor;
    notifyListeners();
  }

  cargarValEmpleadoHE(
      String fecha, String empleado, String thora, String dominio) async {
    double count =
        await DBProvider.db.getValEmpleadoHE(fecha, empleado, thora, dominio);
    this.count = count;
    print('Count: ' + count.toString());
    notifyListeners();
  }

  cargarFundos(String dominio) async {
    final fundos = await DBProvider.db.getAllFundos(dominio);
    this.fundos = fundos;
    notifyListeners();
  }

  cargarEmpleados(int activo, String dominio) async {
    final empleados = await DBProvider.db.getEmpleadoActivos(activo, dominio);
    /*print(empleados.length);
    for (int i = 0; i < empleados.length; i++) {
      print(empleados[i].templeadoFundo);
    }*/
    this.empleados = empleados;
    notifyListeners();
  }

  cargarEmpleadosByFundo(int activo, String dominio, String fundo) async {
    final empleados =
        await DBProvider.db.getEmpleadoActivosByFundo(activo, dominio, fundo);
    //print(empleados.length);
    /*for (int i = 0; i < empleados.length; i++) {
      print(empleados[i].templeadoNombre);
    }*/
    this.empleados = empleados;
    notifyListeners();
  }

  cargarOperaciones(String fundo, String dominio) async {
    final operaciones =
        await DBProvider.db.getOperacionesByFundo(fundo, dominio);
    /*for (int i = 0; i < operaciones.length; i++) {
      print(operaciones[i].toperacionNombre);
      print(operaciones[i].toperacionManual);
    }*/
    this.operaciones = operaciones;
    notifyListeners();
  }

  cargarOpManual(String dominio) async {
    final operaciones = await DBProvider.db.getOperacionesByManual(1, dominio);
    /*for (int i = 0; i < operaciones.length; i++) {
      print(operaciones[i].toperacionNombre);
      print(operaciones[i].toperacionManual);
    }*/
    this.operaciones = operaciones;
    notifyListeners();
  }

  cargarAllTpago() async {
    final Alltpago = await DBProvider.db.getAllTpago();
    this.Alltpago = Alltpago;
    notifyListeners();
  }

  cargarTpago(String fundo, String dominio) async {
    final tpago = await DBProvider.db.getTpagoByFundo(fundo, dominio);
    print(tpago.length);
    /*for (int i = 0; i < tpago.length; i++) {
      print(tpago[i].tpagoNombre);
      print(tpago[i].tpagoCod);
    }*/
    this.tpago = tpago;
    notifyListeners();
  }

  cargarTpagoTrato(String fundo, String dominio) async {
    final tpago = await DBProvider.db.getTpagoTrato(fundo, dominio);
    print(tpago.length);
    /*for (int i = 0; i < tpago.length; i++) {
      print(tpago[i].tpagoNombre);
      print(tpago[i].tpagoCod);
    }*/
    this.tpago = tpago;
    notifyListeners();
  }

  cargarThora(String dominio) async {
    final thora = await DBProvider.db.getAllThora(dominio);
    this.thora = thora;
    notifyListeners();
  }

  cargarThoraTrato(String dominio) async {
    final thora = await DBProvider.db.getThoraTrato(dominio);
    this.thora = thora;
    notifyListeners();
  }

  cargarThoraNormalBono(String dominio) async {
    final thora = await DBProvider.db.getThoraNormalBono(dominio);
    this.thora = thora;
    notifyListeners();
  }

  cargarThoraNormalHE(String dominio) async {
    final thora = await DBProvider.db.getThoraNormalHE(dominio);
    this.thora = thora;
    notifyListeners();
  }

  cargarCuarteles() async {
    final cuarteles = await DBProvider.db.getAllCuarteles();
    /*for (int i = 0; i < cuarteles.length; i++) {
      print(cuarteles[i].tcuartelCuartel);
      print(cuarteles[i].tcuartelNombre);
    }*/
    this.cuarteles = cuarteles;
    notifyListeners();
  }

  cargarCuartelesByFundoOp(String fundo, String op) async {
    final cuarteles = await DBProvider.db
        .getCuartelesByFundoOp(fundo, op, Preferences.dominio);
    /*for (int i = 0; i < cuarteles.length; i++) {
      print(cuarteles[i].tcuartelCuartel);
      print(cuarteles[i].tcuartelNombre);
      print(cuarteles[i].tcuartelDominio);
      print(cuarteles[i].tcuartelOp);
    }*/
    this.cuarteles = cuarteles;
    notifyListeners();
  }

  cargarTDetCuartelesByCabecera(
      int linea, String dominio, String fundo, String fecha) async {
    final Detcuarteles = await DBProvider.db
        .getTDetCuartelesByCabecera(linea, dominio, fundo, fecha);
    this.Detcuarteles = Detcuarteles;
    print(Detcuarteles.length);
    notifyListeners();
  }

  cargarTDetCuarteles(int linea, String dominio, String fecha) async {
    final Detcuarteles =
        await DBProvider.db.getTDetCuartelesByLineaFecha(linea, dominio, fecha);
    this.Detcuarteles = Detcuarteles;
    notifyListeners();
  }

  cargarAllTDetCuarteles(String dominio) async {
    final Detcuarteles = await DBProvider.db.getAllTDetCuarteles(dominio);
    print('AllDetCuarteles');
    for (int i = 0; i < Detcuarteles.length; i++) {
      print(Detcuarteles[i].tdetcuartelLinea);
    }
    this.Detcuarteles = Detcuarteles;
    notifyListeners();
  }

  cargarTarjasHoy(String fecha, String dominio) async {
    final tarjasHoy = await DBProvider.db.getTarjaByFecha(fecha, dominio);
    this.tarjasHoy = tarjasHoy;
    notifyListeners();
  }

  Future cargarTarjasFundoFecha(
      String fecha, String dominio, String fundo) async {
    final tarjasFundoFecha =
        await DBProvider.db.getTarjaFundoFecha(dominio, fundo, fecha);
    //for (int i = 0; i < tarjasFundoFecha.length; i++) {
    //print('Last Linea: ' + tarjasFundoFecha.length.toString());
    //this.lastLinea = tarjasFundoFecha.length;
    tarjasFundoFecha.isNotEmpty
        ? this.lastLinea = tarjasFundoFecha.last.ttarjaLinea
        : this.lastLinea = 0;
    print(this.lastLinea);
    //}
    this.tarjasFundoFecha = tarjasFundoFecha;
    notifyListeners();
  }

  cargarHileras() async {
    final hileras = await DBProvider.db.getAllHileras();
    /*for (int i = 0; i < hileras.length; i++) {
      print(hileras[i].thileraFundo);
      print(hileras[i].thileraCuartel);
      print(hileras[i].thileraCodigo);
      print(hileras[i].thileraNombre);
      print(hileras[i].thileraCantidad);
    }*/
    this.hileras = hileras;
    notifyListeners();
  }

  cargarHilerasByCuartel(String cuartel) async {
    final hileras = await DBProvider.db.getHileraByCuartel(cuartel);
    /*for (int i = 0; i < hileras.length; i++) {
      print(hileras[i].thileraFundo);
      print(hileras[i].thileraCuartel);
      print(hileras[i].thileraCodigo);
      print(hileras[i].thileraNombre);
      print(hileras[i].thileraCantidad);
    }*/
    this.hileras = hileras;
    notifyListeners();
  }

  /*cargarMaxHE() async {
    final maxHE = await DBProvider.db.getAllMaxHE();
    for (int i = 0; i < maxHE.length; i++) {
      print(maxHE[i].tmaxheFundo);
      print(maxHE[i].tmaxheHoras);
    }
    this.maxHE = maxHE;
    notifyListeners();
  }*/

  cargarMaxHEByFundo(String fundo) async {
    final maxHE = await DBProvider.db.getMaxHEByFundo(fundo);
    /*for (int i = 0; i < maxHE.length; i++) {
      print(maxHE[i].tmaxheFundo);
      print(maxHE[i].tmaxheHoras);
    }*/
    this.maxHE = maxHE;
    notifyListeners();
  }

  /*eliminarData(int linea) async {
    await DBProvider.db.deleteData();
    this.tarjas = [];
    notifyListeners();
  }*/

  eliminarTarja(String dominio, String fundo, String fecha, int linea) async {
    await DBProvider.db.deleteTarja(dominio, fundo, fecha, linea);
    this.tarjas = [];
    notifyListeners();
  }

  eliminarDetCuarteles(int linea) async {
    await DBProvider.db.deleteDetCuarteles(linea);
    this.Detcuarteles = [];
    notifyListeners();
  }

  cargarUsers() async {
    final users = await DBProvider.db.getAllUsers();
    this.users = users;
    notifyListeners();
  }
}
