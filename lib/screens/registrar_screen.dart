import 'package:flutter/material.dart';
import 'package:qad_tarjas/local_models/local_models.dart';
import 'package:qad_tarjas/providers/providers.dart';
import 'package:qad_tarjas/services/services.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RegistrarScreen extends StatefulWidget {
  @override
  State<RegistrarScreen> createState() => _RegistrarScreenState();
}

class _RegistrarScreenState extends State<RegistrarScreen> {
  final _controllerFecha = TextEditingController();

  final _controllerFundo = TextEditingController();

  final _controllerEmpleado = TextEditingController();

  final _controllerOperacion = TextEditingController();

  final _controllerTipoPago = TextEditingController();

  final _controllerTipoHora = TextEditingController();

  final _controllerJornada = TextEditingController();

  final _controllerHextra = TextEditingController();

  final _controllerBuscar = TextEditingController();

  final _controllerCantidad = TextEditingController();

  List<TfundoLocalModel> fundos_temp = [];
  List<TempleadoLocalModel> empleados_temp = [];
  List<ToperacionLocalModel> operaciones_temp = [];
  List<TtpagoLocalModel> tpago_temp = [];
  List<TthoraLocalModel> thora_temp = [];

  int _selectedIndex = 0;

  bool _validateFecha = false;
  bool _validateFundo = false;
  bool _validateEmp = false;
  bool _validateOp = false;
  bool _validateTp = false;
  bool _validateTh = false;
  bool _validateJornada = false;
  bool _validateJornadaFormat = false;
  bool _validateHextra = false;
  bool _validateCantidad = false;

  final DateTime now = DateTime.now();

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final DateFormat formatter2 = DateFormat('dd MMMM yyyy', 'es_ES');

  @override
  Widget build(BuildContext context) {
    //String fechaHoy = formatter2.format(now); //dd MMMM yyyy
    //String fecha = formatter.format(now); //yyyy-MM-dd
    //_controllerFecha.text = fechaHoy;

    final dbProvider = Provider.of<LocalListProvider>(context);
    final TarjaProv = Provider.of<TarjaProvider>(context);
    //final fundosApi = Provider.of<FundosServices>(context);

    _controllerJornada.text = TarjaProv.jornada.toString();
    _controllerFundo.text = Preferences.fundo.toString();

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Color(0xFF5A87C6),
            title: Container(
                child: Text(
              'Registrar Tarja',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            leading: IconButton(
                padding: EdgeInsets.only(left: 5),
                onPressed: () {
                  //Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, 'tarja');
                },
                icon: Icon(Icons.arrow_back_outlined, size: 26)),
          )),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 20),
        //color: Colors.red,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              children: [
                Container(
                  //color: Colors.blue,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 80,
                          alignment: Alignment.centerLeft,
                          //color: Colors.green,
                          child: Text('Fundo:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: _TextFieldFundo(_controllerFundo, dbProvider),
                        ),
                      ),
                      /* Expanded(
                        flex: 1,
                        child: Container(),
                      ),*/
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  //color: Colors.green,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 80,
                          alignment: Alignment.centerLeft,
                          //color: Colors.green,
                          child: Text('Fecha:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: Container(
                          //color: Colors.blue,

                          height: 80,
                          alignment: Alignment.center,
                          //color: Colors.green,
                          child: _TextFieldFecha(_controllerFecha),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: IconButton(
                              icon: Icon(Icons.search_rounded),
                              iconSize: 35,
                              color: Color(0xFF5A87C6),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        locale: Locale('es', ''),
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2030))
                                    .then((value) {
                                  setState(() {
                                    String fechaHoy = formatter2
                                        .format(value!); //dd MMMM yyyy
                                    String fecha =
                                        formatter.format(value); //yyyy-MM-dd

                                    _controllerFecha.text = fechaHoy;

                                    TarjaProv.fecha = fecha;

                                    dbProvider.cargarValEmpleadoJornada(
                                        fecha,
                                        TarjaProv.empleado,
                                        'N',
                                        Preferences.dominio);

                                    dbProvider.cargarValEmpleadoHE(
                                        fecha,
                                        TarjaProv.empleado,
                                        'E',
                                        Preferences.dominio);
                                  });
                                  print('TarjaProv.fecha: ' + TarjaProv.fecha);
                                  print('ControllerFecha: ' +
                                      _controllerFecha.text);
                                  //final DateTime now = DateTime.now();
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 80,

                          alignment: Alignment.centerLeft,
                          //color: Colors.green,
                          child: Text('Empleado:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: 80,
                          alignment: Alignment.center,
                          //color: Colors.green,
                          child: _TextFieldEmpleado(
                              _controllerEmpleado, dbProvider),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            //height: 80,
                            //alignment: Alignment.center,
                            child: IconButton(
                                icon: Icon(Icons.search_rounded),
                                iconSize: 35,
                                color: Color(0xFF5A87C6),
                                onPressed: () {
                                  _showDialogEmpleado(
                                      context,
                                      dbProvider,
                                      _controllerBuscar,
                                      TarjaProv,
                                      TarjaProv.fecha);
                                  empleados_temp = dbProvider.empleados;
                                })),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 80,
                          alignment: Alignment.centerLeft,
                          child: Text('Operación:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: _TextFieldOperacion(
                              _controllerOperacion, dbProvider),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            //height: 80,
                            //alignment: Alignment.center,
                            child: IconButton(
                                icon: Icon(Icons.search_rounded),
                                iconSize: 35,
                                color: Color(0xFF5A87C6),
                                onPressed: () {
                                  _showDialogOperacion(context, dbProvider,
                                      _controllerBuscar, TarjaProv);
                                  operaciones_temp = dbProvider.operaciones;
                                })),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  //height: 100,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                            alignment: Alignment.centerLeft,
                            //color: Colors.green,
                            child: TarjaProv.opManual == 0
                                ? Text('Cantidad:',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal))
                                : null),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: Container(
                            //color: Colors.blue,
                            child: TarjaProv.opManual == 0
                                ? _TextFieldCantidad(_controllerCantidad)
                                : null),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 80,
                          alignment: Alignment.centerLeft,
                          child: Text('Tipo Pago:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: _TextFieldTipoPago(
                              _controllerTipoPago, dbProvider),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            //height: 80,
                            //alignment: Alignment.center,
                            child: IconButton(
                                icon: Icon(Icons.search_rounded),
                                iconSize: 35,
                                color: Color(0xFF5A87C6),
                                onPressed: () {
                                  _showDialogTPago(context, dbProvider,
                                      _controllerBuscar, TarjaProv);
                                  tpago_temp = dbProvider.tpago;
                                  /*for(int i=0; i<dbProvider.Alltpago.length; i++) {
                                print(dbProvider.Alltpago[i].tpagoNombre);
                              }*/
                                })),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 80,
                          child: Text('Tipo Hora:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: _TextFieldTipoHora(
                              _controllerTipoHora, dbProvider),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            //height: 80,
                            //alignment: Alignment.center,
                            child: IconButton(
                                icon: Icon(Icons.search_rounded),
                                iconSize: 35,
                                color: Color(0xFF5A87C6),
                                onPressed: () {
                                  _showDialogTHora(context, dbProvider,
                                      _controllerBuscar, TarjaProv);
                                  thora_temp = dbProvider.thora;
                                })),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  //height: 100,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                            alignment: Alignment.centerLeft,
                            //color: Colors.green,
                            child: dbProvider.selectedThora == 'N'
                                ? Text('Jornada:',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal))
                                : dbProvider.selectedThora == 'E'
                                    ? Text('Horas Extras:',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal))
                                    : null),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: Container(
                            //color: Colors.blue,
                            child: dbProvider.selectedThora == 'N'
                                ? _TextFieldJornada(
                                    _controllerJornada, TarjaProv)
                                : dbProvider.selectedThora == 'E'
                                    ? _TextFieldHextra(_controllerHextra)
                                    : null),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                MaterialButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    TarjaProv.fundo = Preferences.fundoCod;
                    TarjaProv.fundoNombre = Preferences.fundo;
                    TarjaProv.dominio = Preferences.dominio;
                    // ignore: unused_local_variable
                    TtarjaLocalModel tarjaCreada;

                    //int cont = 0;

                    await dbProvider.cargarTarjasFundoFecha(
                        TarjaProv.fecha, TarjaProv.dominio, TarjaProv.fundo);

                    print('Last Linea: ' + dbProvider.lastLinea.toString());

                    dbProvider.lastLinea == 0
                        ? TarjaProv.linea = 1
                        : TarjaProv.linea = dbProvider.lastLinea + 1;

                    //dbProvider.cargarTarjas(Preferences.dominio);

                    /* for (int i = 0; i < dbProvider.tarjas.length; i++) {
                      if (dbProvider.tarjas[i].ttarjaFecha == TarjaProv.fecha) {
                        if (dbProvider.tarjas[i].ttarjaFundo ==
                            TarjaProv.fundo) {
                          cont = cont + 1;
                        }
                      }
                    }

                    print('Cont: ' + cont.toString());
                    cont == 0
                        ? TarjaProv.linea = 1
                        : TarjaProv.linea = cont + 1;*/

                    //print(dbProvider.valEmpJor[0].ttarjaJornada);
                    print('Length Jornada: ' +
                        dbProvider.valEmpJor.length.toString());

                    double count = 0;
                    double? sumJornada;

                    if (dbProvider.valEmpJor.length == 0) {
                      sumJornada = 0;
                    } else {
                      for (int i = 0; i < dbProvider.valEmpJor.length; i++) {
                        count = count + dbProvider.valEmpJor[i].ttarjaJornada;
                      }
                    }

                    //print('Jornada: '+ count.toString());
                    sumJornada = count + double.parse(_controllerJornada.text);
                    print('Total Jornada: ' + sumJornada.toString());

                    sumJornada <= 1 || sumJornada == 0
                        ? print('Válido')
                        : print('error');

                    //dbProvider.cargarTarjas();
                    //TarjaProv.fecha = fecha;
                    if (dbProvider.selectedThora == 'N') {
                      TarjaProv.jornada = double.parse(_controllerJornada.text);
                    } else {
                      _controllerJornada.clear();
                    }

                    setState(() {
                      _controllerFecha.text.isEmpty
                          ? _validateFecha = true
                          : _validateFecha = false;

                      _controllerFundo.text.isEmpty
                          ? _validateFundo = true
                          : _validateFundo = false;

                      _controllerEmpleado.text.isEmpty
                          ? _validateEmp = true
                          : _validateEmp = false;

                      _controllerOperacion.text.isEmpty
                          ? _validateOp = true
                          : _validateOp = false;

                      _controllerTipoPago.text.isEmpty
                          ? _validateTp = true
                          : _validateTp = false;

                      _controllerTipoHora.text.isEmpty
                          ? _validateTh = true
                          : _validateTh = false;

                      _controllerJornada.text.isEmpty
                          ? _validateJornada = true
                          : _validateJornada = false;

                      _controllerHextra.text.isEmpty
                          ? _validateHextra = true
                          : _validateHextra = false;
                    });

                    //print('Val Jornada: ' + dbProvider.valEmpJor.length.toString());

                    //if(dbProvider.valEmpJor.length == 0) {

                    if (_controllerFecha.text.isNotEmpty &&
                        _controllerFundo.text.isNotEmpty &&
                        _controllerEmpleado.text.isNotEmpty &&
                        _controllerOperacion.text.isNotEmpty &&
                        _controllerTipoPago.text.isNotEmpty &&
                        _controllerTipoHora.text.isNotEmpty &&
                        (((_controllerJornada.text.isNotEmpty &&
                                    _controllerHextra.text.isEmpty) ||
                                (_controllerHextra.text.isNotEmpty &&
                                    _controllerJornada.text.isEmpty)) ||
                            _controllerTipoHora.text == 'Bono')) {
                      //print('If validador');

                      if (dbProvider.selectedThora == 'N') {
                        if (sumJornada <= 1 || sumJornada == 0) {
                          //print('If N');
                          if (_controllerJornada.text.contains(',')) {
                            setState(() {
                              _validateJornadaFormat = true;
                            });
                          } else {
                            setState(() {
                              _validateJornadaFormat = false;
                            });

                            if (double.parse(_controllerJornada.text) <= 1 &&
                                double.parse(_controllerJornada.text) >= -1 &&
                                double.parse(_controllerJornada.text) != 0) {
                              setState(() {
                                _validateJornada = false;
                              });

                              TarjaProv.hextra = 0;
                              TarjaProv.jornada =
                                  double.parse(_controllerJornada.text);

                              /*print('Cont: ' + cont.toString());
                              if (cont == 0) {
                                 TarjaProv.linea = 1;
                               } else {
                                 TarjaProv.linea = cont + 1;
                               }*/

                              TarjaProv.estado = 'Pendiente';
                              TarjaProv.procesado = 0;

                              if (TarjaProv.opManual == 1) {
                                dbProvider.cargarCuartelesByFundoOp(
                                    TarjaProv.fundo, TarjaProv.operacion);

                                Navigator.pushNamed(context, 'cuarteles');
                              } else {
                                setState(() {
                                  _controllerCantidad.text.isEmpty
                                      ? _validateCantidad = true
                                      : _validateCantidad = false;
                                });

                                if (_controllerCantidad.text.isNotEmpty) {
                                  TarjaProv.cantidad =
                                      double.parse(_controllerCantidad.text);
                                  final tempTarja = new TtarjaLocalModel(
                                    ttarjaDomain: TarjaProv.dominio,
                                    ttarjaFundo: TarjaProv.fundo,
                                    ttarjaFundoNombre: TarjaProv.fundoNombre,
                                    ttarjaFecha: TarjaProv.fecha,
                                    ttarjaLinea: TarjaProv.linea,
                                    ttarjaEmpleado: TarjaProv.empleado,
                                    ttarjaEmpleadoNombre:
                                        TarjaProv.empleadoNombre,
                                    ttarjaEstado: TarjaProv.estado,
                                    ttarjaHextra: TarjaProv.hextra,
                                    ttarjaHora: TarjaProv.hora,
                                    ttarjaHoraNombre: TarjaProv.horaNombre,
                                    ttarjaJornada: TarjaProv.jornada,
                                    ttarjaOperacion: TarjaProv.operacion,
                                    ttarjaOperacionNombre:
                                        TarjaProv.operacionNombre,
                                    ttarjaOperacionUM: TarjaProv.operacionUM,
                                    ttarjaPago: TarjaProv.pago,
                                    ttarjaPagoNombre: TarjaProv.pagoNombre,
                                    ttarjaProcesado: TarjaProv.procesado,
                                    ttarjaRegistro: TarjaProv.registro,
                                    ttarjaOpManual: TarjaProv.opManual,
                                    ttarjaCantidad: TarjaProv.cantidad,
                                    ttarjaServidor: Preferences.ambiente,
                                    ttarjaSelected: 0,
                                  );
                                  tarjaCreada = await DBProvider.db
                                      .nuevoTtarjaRaw(tempTarja, dbProvider);

                              /*    print('Tarja Registrada: ' +
                                      tarjaCreada.toString());

                                  print('Tarja Cabecera: ' +
                                      tarjaCreada.ttarjaLinea.toString() +
                                      ' ' +
                                      tarjaCreada.ttarjaFecha); */


                                  //dbProvider.cargarTarjas(Preferences.dominio);
                                  TarjaProv.jornada = 1;

                                  _showDialogResult(context, dbProvider);
                                }
                              }
                            } else {
                              setState(() {
                                _validateJornada = true;
                              });
                            }
                          }
                        } else {
                          _showDialogErrorValEmpJor(context);
                        }
                      } else {
                        if (dbProvider.selectedThora == 'E') {
                          //print('If E');
                          double _totalHE =
                              double.parse(_controllerHextra.text) +
                                  dbProvider.count;

                          if (_totalHE <= dbProvider.maxHE) {
                            TarjaProv.hextra =
                                double.parse(_controllerHextra.text);
                            TarjaProv.jornada = 0;

                            /*  print('Cont: ' + cont.toString());
                            if (cont == 0) {
                              TarjaProv.linea = 1;
                            } else {
                              TarjaProv.linea = cont + 1;
                            }*/

                            TarjaProv.estado = 'Pendiente';
                            TarjaProv.procesado = 0;

                            if (TarjaProv.opManual == 1) {
                              dbProvider.cargarCuartelesByFundoOp(
                                  TarjaProv.fundo, TarjaProv.operacion);

                              Navigator.pushNamed(context, 'cuarteles');
                            } else {
                              setState(() {
                                _controllerCantidad.text.isEmpty
                                    ? _validateCantidad = true
                                    : _validateCantidad = false;
                              });

                              if (_controllerCantidad.text.isNotEmpty) {
                                TarjaProv.cantidad =
                                    double.parse(_controllerCantidad.text);
                                final tempTarja = new TtarjaLocalModel(
                                    ttarjaDomain: TarjaProv.dominio,
                                    ttarjaFundo: TarjaProv.fundo,
                                    ttarjaFundoNombre: TarjaProv.fundoNombre,
                                    ttarjaFecha: TarjaProv.fecha,
                                    ttarjaLinea: TarjaProv.linea,
                                    ttarjaEmpleado: TarjaProv.empleado,
                                    ttarjaEmpleadoNombre:
                                        TarjaProv.empleadoNombre,
                                    ttarjaEstado: TarjaProv.estado,
                                    ttarjaHextra: TarjaProv.hextra,
                                    ttarjaHora: TarjaProv.hora,
                                    ttarjaHoraNombre: TarjaProv.horaNombre,
                                    ttarjaJornada: TarjaProv.jornada,
                                    ttarjaOperacion: TarjaProv.operacion,
                                    ttarjaOperacionNombre:
                                        TarjaProv.operacionNombre,
                                    ttarjaOperacionUM: TarjaProv.operacionUM,
                                    ttarjaPago: TarjaProv.pago,
                                    ttarjaPagoNombre: TarjaProv.pagoNombre,
                                    ttarjaProcesado: TarjaProv.procesado,
                                    ttarjaRegistro: TarjaProv.registro,
                                    ttarjaOpManual: TarjaProv.opManual,
                                    ttarjaCantidad: TarjaProv.cantidad,
                                    ttarjaServidor: Preferences.ambiente,
                                    ttarjaSelected: 0);
                                tarjaCreada = await DBProvider.db
                                    .nuevoTtarjaRaw(tempTarja, dbProvider);

                               /* print('Tarja Registrada: ' +
                                    tarjaCreada.toString());

                                print('Tarja Cabecera: ' +
                                    tarjaCreada.ttarjaLinea.toString() +
                                    tarjaCreada.ttarjaFecha); */


                                dbProvider.cargarTarjas(Preferences.dominio);
                                TarjaProv.jornada = 1;

                                _showDialogResult(context, dbProvider);
                              }
                            }
                          } else {
                            _showDialogErrorValEmpHE(context, dbProvider);
                          }
                        } else {
                          //print('Else E');
                          TarjaProv.hextra = 0;
                          TarjaProv.jornada = 0;

                          /*      print('Cont: ' + cont.toString());
                          if (cont == 0) {
                            TarjaProv.linea = 1;
                          } else {
                            TarjaProv.linea = cont + 1;
                          } */

                          TarjaProv.estado = 'Pendiente';
                          TarjaProv.procesado = 0;

                          if (TarjaProv.opManual == 1) {
                            dbProvider.cargarCuartelesByFundoOp(
                                TarjaProv.fundo, TarjaProv.operacion);

                            Navigator.pushNamed(context, 'cuarteles');
                          } else {
                            setState(() {
                              _controllerCantidad.text.isEmpty
                                  ? _validateCantidad = true
                                  : _validateCantidad = false;
                            });

                            if (_controllerCantidad.text.isNotEmpty) {
                              TarjaProv.cantidad =
                                  double.parse(_controllerCantidad.text);
                              final tempTarja = new TtarjaLocalModel(
                                  ttarjaDomain: TarjaProv.dominio,
                                  ttarjaFundo: TarjaProv.fundo,
                                  ttarjaFundoNombre: TarjaProv.fundoNombre,
                                  ttarjaFecha: TarjaProv.fecha,
                                  ttarjaLinea: TarjaProv.linea,
                                  ttarjaEmpleado: TarjaProv.empleado,
                                  ttarjaEmpleadoNombre:
                                      TarjaProv.empleadoNombre,
                                  ttarjaEstado: TarjaProv.estado,
                                  ttarjaHextra: TarjaProv.hextra,
                                  ttarjaHora: TarjaProv.hora,
                                  ttarjaHoraNombre: TarjaProv.horaNombre,
                                  ttarjaJornada: TarjaProv.jornada,
                                  ttarjaOperacion: TarjaProv.operacion,
                                  ttarjaOperacionNombre:
                                      TarjaProv.operacionNombre,
                                  ttarjaOperacionUM: TarjaProv.operacionUM,
                                  ttarjaPago: TarjaProv.pago,
                                  ttarjaPagoNombre: TarjaProv.pagoNombre,
                                  ttarjaProcesado: TarjaProv.procesado,
                                  ttarjaRegistro: TarjaProv.registro,
                                  ttarjaOpManual: TarjaProv.opManual,
                                  ttarjaCantidad: TarjaProv.cantidad,
                                  ttarjaServidor: Preferences.ambiente,
                                  ttarjaSelected: 0);
                              tarjaCreada = await DBProvider.db
                                  .nuevoTtarjaRaw(tempTarja, dbProvider);

                              /*print('Tarja Registrada: ' +
                                  tarjaCreada.toString());
                              print('Tarja Cabecera: ' +
                                  tarjaCreada.ttarjaLinea.toString() +
                                  tarjaCreada.ttarjaFecha);*/


                              dbProvider.cargarTarjas(Preferences.dominio);
                              TarjaProv.jornada = 1;

                              _showDialogResult(context, dbProvider);
                            }
                          }
                        }
                      }
                    }

                /*    await dbProvider.cargarTDetCuartelesByCabecera(
                                  TarjaProv.linea,
                                  TarjaProv.dominio,
                                  TarjaProv.fundo,
                                  TarjaProv.fecha); */
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Color(0xFF5A87C6),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Text('Guardar',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container searchFieldThora(
      BuildContext context,
      TextEditingController _controllerTipoHora,
      LocalListProvider dbProvider,
      TarjaProvider TarjaProv) {
    return _controllerTipoHora.text.isNotEmpty && thora_temp.isNotEmpty
        ? Container(
            //margin: EdgeInsets.only(top: 140),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 70,

            //color: Colors.red,
            child: ListView.builder(
              itemCount: thora_temp.length,
              itemBuilder: (context, index) {
                //final book = books[index];

                return Container(
                  //width: MediaQuery.of(context).size.width * 0.8,
                  color:
                      _selectedIndex == index ? Colors.grey[300] : Colors.white,
                  child: ListTile(
                    //selected: index == _selectedIndex,
                    title: Text(thora_temp[index].thoraNombre),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        _selectedIndex = index;
                      });
                      _controllerTipoHora.text = thora_temp[index].thoraNombre;
                      dbProvider.selectedThora = thora_temp[index].thoraCod;
                      TarjaProv.hora = thora_temp[index].thoraCod;
                      TarjaProv.horaNombre = thora_temp[index].thoraNombre;

                      _controllerJornada.clear();
                      _controllerHextra.clear();

                      thora_temp.clear();

                      //parts.clear();

                      //Navigator.pushReplacementNamed(
                      //  context, 'document');
                    },
                  ),
                );
              },
            ),
          )
        : Container();
  }

  TextFormField _TextFieldFecha(TextEditingController _controllerFecha) {
    return TextFormField(
      readOnly: true,
      controller: _controllerFecha,
      autocorrect: false,
      decoration: InputDecoration(
        //prefixIcon: Icon(Icons.search_outlined),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //filled: true,
        errorText: _validateFecha ? 'Debe Seleccionar una Fecha' : null,
        labelText: 'Fecha',
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      /*validator: (value) {
        return (value != null && value.length > 0) ? null : 'Seleccione Fecha';
      },*/
    );
  }

  TextFormField _TextFieldFundo(
      TextEditingController _controllerFundo, LocalListProvider dbProvider) {
    return TextFormField(
      readOnly: true,
      controller: _controllerFundo,
      //initialValue: Preferences.dominio,
      autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //filled: true,
        labelText: 'Fundo',
        errorText: _validateFundo ? 'Campo Vacío' : null,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
      //onChanged: (value) => buscarFundo(value, dbProvider),
    );
  }

  TextFormField _TextFieldEmpleado(
      TextEditingController _controllerEmpleado, LocalListProvider dbProvider) {
    return TextFormField(
      readOnly: true,
      controller: _controllerEmpleado,
      //initialValue: Preferences.dominio,
      autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //filled: true,
        labelText: 'Empleado',
        errorText: _validateEmp ? 'Campo Vacío' : null,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
      //onChanged: (value) => buscarEmpleado(value, dbProvider),
    );
  }

  TextFormField _TextFieldOperacion(TextEditingController _controllerOperacion,
      LocalListProvider dbProvider) {
    return TextFormField(
      readOnly: true,
      controller: _controllerOperacion,
      //initialValue: Preferences.dominio,
      autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //filled: true,
        labelText: 'Operación',
        errorText: _validateOp ? 'Campo Vacío' : null,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
      //onChanged: (value) => buscarOperacion(value, dbProvider),
    );
  }

  TextFormField _TextFieldTipoPago(
      TextEditingController _controllerTipoPago, LocalListProvider dbProvider) {
    return TextFormField(
      readOnly: true,
      controller: _controllerTipoPago,
      //initialValue: Preferences.dominio,
      autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //filled: true,
        labelText: 'Tipo Pago',
        errorText: _validateTp ? 'Campo Vacío' : null,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
      //onChanged: (value) => buscarTpago(value, dbProvider),
    );
  }

  TextFormField _TextFieldTipoHora(
      TextEditingController _controllerTipoHora, LocalListProvider dbProvider) {
    return TextFormField(
      readOnly: true,
      controller: _controllerTipoHora,
      //initialValue: Preferences.dominio,
      autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //filled: true,
        labelText: 'Tipo Hora',
        errorText: _validateTh ? 'Campo Vacío' : null,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
      //onChanged: (value) => buscarThora(value, dbProvider),
    );
  }

  TextFormField _TextFieldJornada(
      TextEditingController _controllerJornada, TarjaProvider TarjaProv) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) {
        TarjaProv.jornada = double.parse(value);
        print(TarjaProv.jornada);
      },
      controller: _controllerJornada,
      keyboardType: TextInputType.number,
      autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //filled: true,
        labelText: 'Ej: 0.6',
        errorText: _validateJornadaFormat
            ? 'Formato Inválido'
            : _validateJornada
                ? 'Campo Vacío \nDebe ser > -1, < 1, != 0'
                : null,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
      onChanged: (text) {
        //_controllerJornada.clear();
        //TarjaProv.jornada = double.parse(value);
        //_controllerJornada.text = TarjaProv.jornada.toString();
        print(text);
      },
    );
  }

  TextFormField _TextFieldHextra(TextEditingController _controllerHextra) {
    return TextFormField(
      controller: _controllerHextra,
      //initialValue: Preferences.dominio,
      keyboardType: TextInputType.number,
      autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //filled: true,
        labelText: 'Hora Extra',
        errorText: _validateHextra ? 'Campo Vacío' : null,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
      //onChanged: (value) => buscarThora(value, dbProvider),
    );
  }

  TextFormField _TextFieldCantidad(TextEditingController _controllerCantidad) {
    return TextFormField(
      controller: _controllerCantidad,
      //initialValue: Preferences.dominio,
      keyboardType: TextInputType.number,
      autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //filled: true,
        labelText: 'Cantidad',
        errorText: _validateCantidad ? 'Campo Vacío' : null,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
      //onChanged: (value) => buscarThora(value, dbProvider),
    );
  }

  Future<String?> _showDialogResult(
      BuildContext context, LocalListProvider dbProvider) async {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title:
            Text('Tarja Almacenada Correctamente', textAlign: TextAlign.center),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrarScreen()),
                  ModalRoute.withName("registrar"));
              //dbProvider.cargarTarjas();
              dbProvider.selectedThora = '';
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<String?> _showDialogErrorValEmpJor(BuildContext context) async {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Icon(Icons.info_outlined, color: Colors.red),
        content: Text('Empleado ya tiene registrada una Jornada del dia actual',
            textAlign: TextAlign.center),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<String?> _showDialogErrorValEmpHE(
      BuildContext context, LocalListProvider dbProvider) async {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Icon(Icons.info_outlined, color: Colors.red),
        content: Text(
            'Cantidad de Horas Extras Ingresadas supera al máximo Diario permitido por Empleado. (Máx. ' +
                dbProvider.maxHE.toInt().toString() +
                ' Horas)',
            textAlign: TextAlign.center),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<String?> showDialogFundo(
      BuildContext context,
      LocalListProvider dbProvider,
      TextEditingController _controllerBuscar,
      TarjaProvider TarjaProv) async {
    return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          void buscarFundo(String query) {
            final suggestions = dbProvider.fundos.where((tmp) {
              final tempTitle = tmp.tfundoNombre.toLowerCase();
              final input = query.toLowerCase();
              return tempTitle.contains(input);
            }).toList();
            setState(() => fundos_temp = suggestions);
          }

          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: Center(child: Text('Fundos')),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 65,
                      child: TextFormField(
                        controller: _controllerBuscar,
                        autocorrect: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.grey[300],
                          //filled: true,
                          labelText: 'Buscar',
                          //errorText: _validateHextra ? 'Campo Vacío' : null,
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) =>
                            setState(() => buscarFundo(value)),
                      ),
                    ),
                    SizedBox(height: 1),
                    Container(
                      //width: 100,
                      height: 250,
                      /*decoration: BoxDecoration(
              border: Border.all(color: Colors.black38)
            ),*/
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 200,
                        child: ListView.builder(
                          itemCount: fundos_temp.length,
                          itemBuilder: (context, index) {
                            return Container(
                              color: _selectedIndex == index
                                  ? Colors.grey[300]
                                  : Colors.white,
                              child: ListTile(
                                leading: Text(fundos_temp[index].tfundoCod),
                                title: Text(fundos_temp[index].tfundoNombre),
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                  _controllerFundo.text =
                                      fundos_temp[index].tfundoNombre;
                                  TarjaProv.fundo =
                                      fundos_temp[index].tfundoCod;
                                  TarjaProv.fundoNombre =
                                      fundos_temp[index].tfundoNombre;
                                  TarjaProv.dominio =
                                      fundos_temp[index].tfundoDominio;
                                  dbProvider.cargarEmpleadosByFundo(
                                      1,
                                      Preferences.dominio,
                                      fundos_temp[index].tfundoCod);
                                  dbProvider.cargarOperaciones(
                                      fundos_temp[index].tfundoCod,
                                      Preferences.dominio);

                                  dbProvider.cargarMaxHEByFundo(
                                      fundos_temp[index].tfundoCod);

                                  _controllerBuscar.clear();

                                  _controllerEmpleado.clear();
                                  _controllerOperacion.clear();
                                  _controllerTipoPago.clear();
                                  _controllerTipoHora.clear();

                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    MaterialButton(
                        onPressed: () {
                          _controllerBuscar.clear();
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: Color(0xFF5A87C6),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            child: Text('Cerrar',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)))),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<String?> _showDialogEmpleado(
      BuildContext context,
      LocalListProvider dbProvider,
      TextEditingController _controllerBuscar,
      TarjaProvider TarjaProv,
      String fecha) async {
    return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          void buscarEmpleado(String query) {
            final suggestions = dbProvider.empleados.where((tmp) {
              final tempTitle = tmp.templeadoNombre.toLowerCase();
              final input = query.toLowerCase();
              return tempTitle.contains(input);
            }).toList();
            setState(() => empleados_temp = suggestions);
          }

          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: Center(child: Text('Empleados')),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 65,
                      child: TextFormField(
                        controller: _controllerBuscar,
                        autocorrect: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.grey[300],
                          //filled: true,
                          labelText: 'Buscar',
                          //errorText: _validateHextra ? 'Campo Vacío' : null,
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) =>
                            setState(() => buscarEmpleado(value)),
                      ),
                    ),
                    SizedBox(height: 1),
                    Container(
                      height: 250,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 200,
                        child: ListView.builder(
                          itemCount: empleados_temp.length,
                          itemBuilder: (context, index) {
                            return Container(
                              color: _selectedIndex == index
                                  ? Colors.grey[300]
                                  : Colors.white,
                              child: ListTile(
                                title:
                                    Text(empleados_temp[index].templeadoNombre),
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                  _controllerEmpleado.text =
                                      empleados_temp[index].templeadoNombre;
                                  TarjaProv.empleado =
                                      empleados_temp[index].templeadoCod;
                                  TarjaProv.empleadoNombre =
                                      empleados_temp[index].templeadoNombre;
                                  TarjaProv.contratista = empleados_temp[index]
                                      .templeadoContratista;
                                  dbProvider.cargarValEmpleadoJornada(
                                      fecha,
                                      empleados_temp[index].templeadoCod,
                                      'N',
                                      Preferences.dominio);
                                  print('fecha: ' + fecha);
                                  dbProvider.cargarValEmpleadoHE(
                                      fecha,
                                      empleados_temp[index].templeadoCod,
                                      'E',
                                      Preferences.dominio);
                                  if (empleados_temp[index]
                                          .templeadoContratista ==
                                      1) {
                                    print('Contratista: ' +
                                        empleados_temp[index]
                                            .templeadoContratista
                                            .toString());
                                  } else {
                                    print('No Contratista: ' +
                                        empleados_temp[index]
                                            .templeadoContratista
                                            .toString());
                                  }
                                  if (empleados_temp[index]
                                          .templeadoContratista ==
                                      1) {
                                    dbProvider.operaciones.clear();
                                    dbProvider
                                        .cargarOpManual(Preferences.dominio);
                                    dbProvider.cargarTpagoTrato(
                                        Preferences.fundoCod,
                                        Preferences.dominio);
                                  } else {
                                    dbProvider.operaciones.clear();
                                    dbProvider.cargarOperaciones(
                                        Preferences.fundoCod,
                                        Preferences.dominio);
                                    dbProvider.cargarTpago(Preferences.fundoCod,
                                        Preferences.dominio);
                                  }

                                  _controllerBuscar.clear();

                                  _controllerOperacion.clear();
                                  _controllerTipoPago.clear();
                                  _controllerTipoHora.clear();
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    MaterialButton(
                        onPressed: () {
                          _controllerBuscar.clear();
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: Color(0xFF5A87C6),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            child: Text('Cerrar',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)))),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<String?> _showDialogOperacion(
      BuildContext context,
      LocalListProvider dbProvider,
      TextEditingController _controllerBuscar,
      TarjaProvider TarjaProv) async {
    return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          void buscarOperacion(String query) {
            final suggestions = dbProvider.operaciones.where((tmp) {
              final tempTitle = tmp.toperacionNombre.toLowerCase();
              final input = query.toLowerCase();
              return tempTitle.contains(input);
            }).toList();
            setState(() => operaciones_temp = suggestions);
          }

          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: Center(child: Text('Operaciones')),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 65,
                      child: TextFormField(
                        controller: _controllerBuscar,
                        autocorrect: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.grey[300],
                          //filled: true,
                          labelText: 'Buscar',
                          //errorText: _validateHextra ? 'Campo Vacío' : null,
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) =>
                            setState(() => buscarOperacion(value)),
                      ),
                    ),
                    SizedBox(height: 1),
                    Container(
                      height: 250,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 200,
                        child: ListView.builder(
                          itemCount: operaciones_temp.length,
                          itemBuilder: (context, index) {
                            return Container(
                              color: _selectedIndex == index
                                  ? Colors.grey[300]
                                  : Colors.white,
                              child: ListTile(
                                leading:
                                    Text(operaciones_temp[index].toperacionOp),
                                title: Text(
                                    operaciones_temp[index].toperacionNombre),
                                trailing:
                                    Text(operaciones_temp[index].toperacion_um),
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                  _controllerOperacion.text =
                                      operaciones_temp[index].toperacionNombre;
                                  TarjaProv.operacion =
                                      operaciones_temp[index].toperacionOp;
                                  TarjaProv.operacionNombre =
                                      operaciones_temp[index].toperacionNombre;
                                  TarjaProv.opManual =
                                      operaciones_temp[index].toperacionManual;
                                  TarjaProv.operacionUM =
                                      operaciones_temp[index].toperacion_um;

                                  if (operaciones_temp[index]
                                          .toperacionManual ==
                                      1) {
                                    print('Op Manual');
                                  } else {
                                    print('Op Automatica');
                                  }

                                  _controllerBuscar.clear();

                                  _controllerTipoPago.clear();
                                  _controllerTipoHora.clear();
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    MaterialButton(
                        onPressed: () {
                          _controllerBuscar.clear();
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: Color(0xFF5A87C6),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            child: Text('Cerrar',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)))),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<String?> _showDialogTPago(
      BuildContext context,
      LocalListProvider dbProvider,
      TextEditingController _controllerBuscar,
      TarjaProvider TarjaProv) async {
    return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          void buscarTpago(String query) {
            final suggestions = dbProvider.tpago.where((tmp) {
              final tempTitle = tmp.tpagoNombre.toLowerCase();
              final input = query.toLowerCase();
              return tempTitle.contains(input);
            }).toList();
            setState(() => tpago_temp = suggestions);
          }

          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: Center(child: Text('Tipo Pago')),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 65,
                      child: TextFormField(
                        controller: _controllerBuscar,
                        autocorrect: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.grey[300],
                          //filled: true,
                          labelText: 'Buscar',
                          //errorText: _validateHextra ? 'Campo Vacío' : null,
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) =>
                            setState(() => buscarTpago(value)),
                      ),
                    ),
                    SizedBox(height: 1),
                    Container(
                      height: 250,
                      child: Container(
                        //margin: EdgeInsets.only(top: 140),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 200,

                        //color: Colors.red,
                        child: ListView.builder(
                          itemCount: tpago_temp.length,
                          itemBuilder: (context, index) {
                            //final book = books[index];

                            return Container(
                              //width: MediaQuery.of(context).size.width * 0.8,
                              color: _selectedIndex == index
                                  ? Colors.grey[300]
                                  : Colors.white,
                              child: ListTile(
                                leading: Text(tpago_temp[index].tpagoCod),
                                title: Text(tpago_temp[index].tpagoNombre),
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                  _controllerTipoPago.text =
                                      tpago_temp[index].tpagoNombre;
                                  TarjaProv.pago = tpago_temp[index].tpagoCod;
                                  TarjaProv.pagoNombre =
                                      tpago_temp[index].tpagoNombre;
                                  TarjaProv.pagoTipo =
                                      tpago_temp[index].tpagoTrato;

                                  if (tpago_temp[index].tpagoTrato == 2) {
                                    print('Trato');
                                  } else {
                                    print('Dia');
                                  }

                                  if (tpago_temp[index].tpagoTrato == 2) {
                                    dbProvider
                                        .cargarThoraTrato(Preferences.dominio);
                                  } else {
                                    if (TarjaProv.contratista == 0 &&
                                        TarjaProv.opManual == 1 &&
                                        tpago_temp[index].tpagoTrato == 1) {
                                      dbProvider.cargarThoraNormalHE(
                                          Preferences.dominio);
                                    } else {
                                      dbProvider.cargarThoraNormalBono(
                                          Preferences.dominio);
                                    }
                                  }

                                  _controllerBuscar.clear();

                                  _controllerTipoHora.clear();
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    MaterialButton(
                        onPressed: () {
                          _controllerBuscar.clear();
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: Color(0xFF5A87C6),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            child: Text('Cerrar',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)))),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<String?> _showDialogTHora(
      BuildContext context,
      LocalListProvider dbProvider,
      TextEditingController _controllerBuscar,
      TarjaProvider TarjaProv) async {
    return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          // ignore: unused_element
          void buscarThora(String query) {
            final suggestions = dbProvider.thora.where((tmp) {
              final tempTitle = tmp.thoraNombre.toLowerCase();
              final input = query.toLowerCase();
              return tempTitle.contains(input);
            }).toList();
            setState(() => thora_temp = suggestions);
          }

          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: Center(child: Text('Tipo Hora')),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 250,
                      child: Container(
                        //margin: EdgeInsets.only(top: 140),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 70,

                        //color: Colors.red,
                        child: ListView.builder(
                          itemCount: thora_temp.length,
                          itemBuilder: (context, index) {
                            //final book = books[index];

                            return Container(
                              //width: MediaQuery.of(context).size.width * 0.8,
                              color: _selectedIndex == index
                                  ? Colors.grey[300]
                                  : Colors.white,
                              child: ListTile(
                                //selected: index == _selectedIndex,
                                title: Text(thora_temp[index].thoraNombre),
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                  _controllerTipoHora.text =
                                      thora_temp[index].thoraNombre;
                                  dbProvider.selectedThora =
                                      thora_temp[index].thoraCod;
                                  TarjaProv.hora = thora_temp[index].thoraCod;
                                  TarjaProv.horaNombre =
                                      thora_temp[index].thoraNombre;

                                  _controllerJornada.clear();
                                  _controllerHextra.clear();

                                  _controllerBuscar.clear();
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    MaterialButton(
                        onPressed: () {
                          _controllerBuscar.clear();
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: Color(0xFF5A87C6),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            child: Text('Cerrar',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)))),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
