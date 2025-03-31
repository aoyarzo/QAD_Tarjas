import 'package:flutter/material.dart';
import 'package:qad_tarjas/local_models/local_models.dart';
import 'package:qad_tarjas/providers/providers.dart';
import 'package:qad_tarjas/screens/screens.dart';
import 'package:qad_tarjas/services/services.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:provider/provider.dart';

class CuartelesScreen extends StatefulWidget {
  @override
  State<CuartelesScreen> createState() => _CuartelesScreenState();
}

class _CuartelesScreenState extends State<CuartelesScreen> {
  //final _controllerCodCuartel = TextEditingController();
  final _controllerPorcentaje = TextEditingController();
  final _controllerCantidad = TextEditingController();

  //List<TcuartelLocalModel> tcuartel_temp = [];

  //int _selectedIndex = 0;

  //bool _validateCuartel = false;
  //bool _validatePorc = false;

  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<LocalListProvider>(context);
    final cuarteles = Provider.of<CuartelesProvider>(context);
    final TarjaProv = Provider.of<TarjaProvider>(context);
    var textStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
    _controllerPorcentaje.text = '0';
    //_controllerCantidad.text = '0';

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Color(0xFF5A87C6),
            title: Container(
                child: Text(
              'Registrar Cuarteles',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            leading: IconButton(
                padding: EdgeInsets.only(left: 5),
                onPressed: () {
                  Navigator.pop(context);
                  //Navigator.pushReplacementNamed(context, 'registrar');
                },
                icon: Icon(Icons.arrow_back_outlined, size: 26)),
          )),
      body: Container(
        //padding: EdgeInsets.only(top: 10),
        //color: Colors.red,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(7),
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        //color: Colors.green,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Código', style: textStyle),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        //color: Colors.blue,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Cuartel', style: textStyle),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        //color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Hilera', style: textStyle),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        //color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Cantidad', style: textStyle),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Lista_Cuarteles(cuarteles, dbProvider)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          FocusScope.of(context).unfocus();
          double sumaPorc = 0;
          int _countVal = 0;
          TtarjaLocalModel tarjaCreada;

          print(TarjaProv.operacionUM);

          //Validación cantidades
          setState(() {
            for (int i = 0; i < dbProvider.cuarteles.length; i++) {
              if (dbProvider.cuarteles[i].tcuartelSelected == 1) {
                if (TarjaProv.operacionUM == 'PL') {
                  if (dbProvider.cuarteles[i].tcuartelCantidad <=
                          dbProvider.cuarteles[i].tcuartelCantPlantas &&
                      dbProvider.cuarteles[i].tcuartelCantidad != 0.0) {
                    /*print(dbProvider.cuarteles[i].tcuartelCantidad.toString() +
                      ' < ' +
                      dbProvider.cuarteles[i].tcuartelCantPlantas.toString());*/
                    dbProvider.cuarteles[i].tcuartelValid = 0;
                    _countVal =
                        _countVal + dbProvider.cuarteles[i].tcuartelValid;
                  } else {
                    dbProvider.cuarteles[i].tcuartelValid = 1;
                    _countVal =
                        _countVal + dbProvider.cuarteles[i].tcuartelValid;
                  }
                } else {}
              }
            }
            print('Validacion: ' + _countVal.toString());
          });

          if (_countVal == 0) {
            //Add cuartelesTemp
            for (int i = 0; i < dbProvider.cuarteles.length; i++) {
              if (dbProvider.cuarteles[i].tcuartelSelected == 1) {
                sumaPorc = dbProvider.cuarteles[i].tcuartelCantidad + sumaPorc;
                final cuartelesTemp = new TDetCuartelLocalModel(
                    tdetcuartelLinea: TarjaProv.linea,
                    tdetcuartelDomain: TarjaProv.dominio,
                    tdetcuartelFundo: TarjaProv.fundo,
                    tdetcuartelFundoNombre: TarjaProv.fundoNombre,
                    tdetcuartelFecha: TarjaProv.fecha,
                    tdetcuartelCuartel: dbProvider.cuarteles[i].tcuartelCuartel,
                    tdetcuartelCuartelNombre:
                        dbProvider.cuarteles[i].tcuartelNombre,
                    tdetcuartelCantidad:
                        dbProvider.cuarteles[i].tcuartelCantidad,
                    tdetcuartelEstado: TarjaProv.estado);
                await cuarteles.agregar(cuartelesTemp);
                //_controllerCuartel.clear();
                //_controllerPorcentaje.clear();
              }
            }

            if (cuarteles.cuarteles.isEmpty) {
              _showDialogError(context);
            } else {
              if (sumaPorc.toStringAsFixed(2) != '0.00') {
                TarjaProv.cantidad = sumaPorc;
                //INSERT Tarja
                final tempTarja = new TtarjaLocalModel(
                  ttarjaDomain: TarjaProv.dominio,
                  ttarjaFundo: TarjaProv.fundo,
                  ttarjaFundoNombre: TarjaProv.fundoNombre,
                  ttarjaFecha: TarjaProv.fecha,
                  ttarjaLinea: TarjaProv.linea,
                  ttarjaEmpleado: TarjaProv.empleado,
                  ttarjaEmpleadoNombre: TarjaProv.empleadoNombre,
                  ttarjaEstado: TarjaProv.estado,
                  ttarjaHextra: TarjaProv.hextra,
                  ttarjaHora: TarjaProv.hora,
                  ttarjaHoraNombre: TarjaProv.horaNombre,
                  ttarjaJornada: TarjaProv.jornada,
                  ttarjaOperacion: TarjaProv.operacion,
                  ttarjaOperacionNombre: TarjaProv.operacionNombre,
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
                tarjaCreada =
                    await DBProvider.db.nuevoTtarjaRaw(tempTarja, dbProvider);

                print('Tarja Registrada: ' + tarjaCreada.toString());

                print('Tarja Cabecera: ' +
                    tarjaCreada.ttarjaLinea.toString() +
                    ' ' +
                    tarjaCreada.ttarjaFecha);

                //dbProvider.cargarTarjas();

                //INSERT Detalle Cuarteles en BD local
                for (int i = 0; i < cuarteles.cuarteles.length; i++) {
                  final detCuartelTemp = new TDetCuartelLocalModel(
                      tdetcuartelLinea: cuarteles.cuarteles[i].tdetcuartelLinea,
                      tdetcuartelDomain:
                          cuarteles.cuarteles[i].tdetcuartelDomain,
                      tdetcuartelFundo: cuarteles.cuarteles[i].tdetcuartelFundo,
                      tdetcuartelFundoNombre:
                          cuarteles.cuarteles[i].tdetcuartelFundoNombre,
                      tdetcuartelFecha: cuarteles.cuarteles[i].tdetcuartelFecha,
                      tdetcuartelCuartel:
                          cuarteles.cuarteles[i].tdetcuartelCuartel,
                      tdetcuartelCuartelNombre:
                          cuarteles.cuarteles[i].tdetcuartelCuartelNombre,
                      tdetcuartelCantidad:
                          cuarteles.cuarteles[i].tdetcuartelCantidad,
                      tdetcuartelEstado:
                          cuarteles.cuarteles[i].tdetcuartelEstado);
                  await DBProvider.db.nuevoDetCuartelRaw(detCuartelTemp);
                }

                sumaPorc = 0;
                cuarteles.cuarteles.clear();
                TarjaProv.jornada = 1;
                _showDialogResult(context, dbProvider);
              } else {
                if (sumaPorc.toStringAsFixed(2) == '0.00') {
                  if (TarjaProv.pagoTipo == 1) {
                    _controllerCantidad.text = '0';
                    _showDialogCantidad(context, _controllerCantidad, cuarteles,
                        TarjaProv, dbProvider);
                  } else {
                    _showDialogCantidad(context, _controllerCantidad, cuarteles,
                        TarjaProv, dbProvider);
                  }
                } else {
                  _showDialogValidate100(context);
                  cuarteles.cuarteles.clear();
                }
              }
            }
          }

        await dbProvider.cargarTDetCuartelesByCabecera(TarjaProv.linea,
                  TarjaProv.dominio, TarjaProv.fundo, TarjaProv.fecha);

              print('Length Det Cuarteles: ' +
                  dbProvider.Detcuarteles.length.toString());

              if (dbProvider.Detcuarteles.length == 0) {
                //INSERT Detalle Cuarteles en BD local
                for (int i = 0; i < cuarteles.cuarteles.length; i++) {
                  final detCuartelTemp = new TDetCuartelLocalModel(
                      tdetcuartelLinea: cuarteles.cuarteles[i].tdetcuartelLinea,
                      tdetcuartelDomain:
                          cuarteles.cuarteles[i].tdetcuartelDomain,
                      tdetcuartelFundo: cuarteles.cuarteles[i].tdetcuartelFundo,
                      tdetcuartelFundoNombre:
                          cuarteles.cuarteles[i].tdetcuartelFundoNombre,
                      tdetcuartelFecha: cuarteles.cuarteles[i].tdetcuartelFecha,
                      tdetcuartelCuartel:
                          cuarteles.cuarteles[i].tdetcuartelCuartel,
                      tdetcuartelCuartelNombre:
                          cuarteles.cuarteles[i].tdetcuartelCuartelNombre,
                      tdetcuartelCantidad:
                          cuarteles.cuarteles[i].tdetcuartelCantidad,
                      tdetcuartelEstado:
                          cuarteles.cuarteles[i].tdetcuartelEstado);
                  await DBProvider.db.nuevoDetCuartelRaw(detCuartelTemp);
                }
              }             


        },
        label: Text('Finalizar', style: TextStyle(fontSize: 16)),
        backgroundColor: Color(0xFF5A87C6),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  TextFormField _TextFieldPorcentaje(
      TextEditingController _controllerPorcentaje,
      LocalListProvider dbProvider,
      int index) {
    return TextFormField(
      controller: TextEditingController()
        ..text = dbProvider.cuarteles[index].tcuartelCantidad.toString(),
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
        errorText: dbProvider.cuarteles[index].tcuartelValid == 1
            ? 'Máx. ' +
                dbProvider.cuarteles[index].tcuartelCantPlantas.toString() +
                ' /No puede ser igual a 0'
            : null,
        errorStyle: TextStyle(fontSize: 9),
        errorMaxLines: 3,
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
      onChanged: (value) {
        dbProvider.cuarteles[index].tcuartelCantidad = double.parse(value);
        /* setState(() {
          if(dbProvider.cuarteles[index].tcuartelCantPlantas > int.parse(value)) {
            dbProvider.cuarteles[index].tcuartelValid = 1;
          } else {
            dbProvider.cuarteles[index].tcuartelValid = 0;
          }
        });     */
      },
    );
  }

  ListView Lista_Cuarteles(
      CuartelesProvider cuarteles, LocalListProvider dbProvider) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: dbProvider.cuarteles.length,
        separatorBuilder: (context, index) => Divider(height: 1),
        itemBuilder: (BuildContext context, int index) {
          var textStyle2 = TextStyle(color: Colors.black, fontSize: 14);
          _controllerPorcentaje.text =
              dbProvider.cuarteles[index].tcuartelCantidad.toString();
          return Padding(
            padding: const EdgeInsets.all(7),
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(2),
              /*decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),*/
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      //color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: dbProvider
                                          .cuarteles[index].tcuartelSelected ==
                                      0
                                  ? false
                                  : true,
                              onChanged: (value) {
                                setState(() {
                                  dbProvider.cuarteles[index].tcuartelSelected =
                                      value! ? 1 : 0;
                                  print('Cant. Plantas: ' +
                                      dbProvider
                                          .cuarteles[index].tcuartelCantPlantas
                                          .toString());
                                });
                              })
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      //color: Colors.yellow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${dbProvider.cuarteles[index].tcuartelCuartel}',
                              style: textStyle2),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      //color: Colors.grey,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${dbProvider.cuarteles[index].tcuartelNombre}',
                              style: textStyle2),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      //color: Colors.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              child: dbProvider
                                          .cuarteles[index].tcuartelSelected ==
                                      1
                                  ? Checkbox(
                                      value: dbProvider.cuarteles[index]
                                                  .tcuartelHilera ==
                                              0
                                          ? false
                                          : true,
                                      onChanged: (value) {
                                        setState(() {
                                          dbProvider.cuarteles[index]
                                              .tcuartelHilera = value! ? 1 : 0;
                                          dbProvider.index_selectedCuartel =
                                              index;
                                          print('index: ' + index.toString());
                                          print('index selected: ' +
                                              dbProvider.cuarteles[index]
                                                  .tcuartelSelected
                                                  .toString());
                                          print(dbProvider
                                              .cuarteles[index].tcuartelHilera);

                                          if (dbProvider.cuarteles[index]
                                                  .tcuartelHilera ==
                                              1) {
                                            dbProvider.hileras.clear();
                                            dbProvider.cargarHilerasByCuartel(
                                                dbProvider.cuarteles[index]
                                                    .tcuartelCuartel);
                                            //_showDialogHileras(context, cuarteles, dbProvider);

                                            Navigator.pushNamed(
                                                context, 'hilera');
                                          }
                                        });
                                      })
                                  : null)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      //color: Colors.green,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 80,
                              //height: 55,
                              child: dbProvider
                                          .cuarteles[index].tcuartelSelected ==
                                      1
                                  ? _TextFieldPorcentaje(
                                      _controllerPorcentaje, dbProvider, index)
                                  : null)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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

              dbProvider.selectedThora = '';
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<String?> _showDialogError(BuildContext context) async {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Icon(Icons.info_outlined, color: Colors.red),
        content: Text('Debe ingresar al menos un Cuartel',
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

  Future<String?> _showDialogErrorCantidad(BuildContext context) async {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Icon(Icons.info_outlined, color: Colors.red),
        content: Text(
            'La Cantidad está vacía o es igual a cero, intente nuevamente',
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

  Future<String?> _showDialogValidate100(BuildContext context) async {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Icon(Icons.info_outlined, color: Colors.red),
        content: Text('La suma de los porcentajes debe ser igual a 100 o 0',
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

  Future<String?> _showDialogCantidad(
      BuildContext context,
      TextEditingController _controllerCantidad,
      CuartelesProvider cuarteles,
      TarjaProvider TarjaProv,
      LocalListProvider dbProvider) async {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Column(
          children: [
            Icon(Icons.info_outlined, color: Color(0xFF5A87C6), size: 30),
            SizedBox(height: 10),
            Text('Debe Ingresar Cantidad Total'),
          ],
        ),
        content: TextFormField(
          controller: _controllerCantidad,
          keyboardType: TextInputType.number,
          autocorrect: false,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Colors.grey[300],
            //filled: true,
            labelText: 'Cantidad Total',
            //errorText: _validateHextra ? 'Campo Vacío' : null,
            labelStyle: TextStyle(
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          //onChanged: (value) => setState(() => buscarEmpleado(value)),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              double _sumaCantPlat = 0;
              TtarjaLocalModel tarjaCreada;

              for (int i = 0; i < dbProvider.cuarteles.length; i++) {
                if (dbProvider.cuarteles[i].tcuartelSelected == 1) {
                  _sumaCantPlat = _sumaCantPlat +
                      dbProvider.cuarteles[i].tcuartelCantPlantas;
                }
              }

              print(_sumaCantPlat);

              //Dia=1 Trato=2
              if (_controllerCantidad.text.isNotEmpty) {
                if (double.parse(_controllerCantidad.text) == 0 &&
                    TarjaProv.pagoTipo == 2) {
                  _showDialogErrorCantidad(context);
                } else {
                  //INSERT Tarja
                  if (double.parse(_controllerCantidad.text) > _sumaCantPlat) {
                    TarjaProv.cantidad = _sumaCantPlat;
                  } else {
                    TarjaProv.cantidad = double.parse(_controllerCantidad.text);
                  }

                  final tempTarja = new TtarjaLocalModel(
                    ttarjaDomain: TarjaProv.dominio,
                    ttarjaFundo: TarjaProv.fundo,
                    ttarjaFundoNombre: TarjaProv.fundoNombre,
                    ttarjaFecha: TarjaProv.fecha,
                    ttarjaLinea: TarjaProv.linea,
                    ttarjaEmpleado: TarjaProv.empleado,
                    ttarjaEmpleadoNombre: TarjaProv.empleadoNombre,
                    ttarjaEstado: TarjaProv.estado,
                    ttarjaHextra: TarjaProv.hextra,
                    ttarjaHora: TarjaProv.hora,
                    ttarjaHoraNombre: TarjaProv.horaNombre,
                    ttarjaJornada: TarjaProv.jornada,
                    ttarjaOperacion: TarjaProv.operacion,
                    ttarjaOperacionNombre: TarjaProv.operacionNombre,
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
                  tarjaCreada =
                      await DBProvider.db.nuevoTtarjaRaw(tempTarja, dbProvider);

                  print('Tarja Registrada: ' + tarjaCreada.toString());

                  print('Tarja Cabecera: ' +
                      tarjaCreada.ttarjaLinea.toString() +
                      ' ' +
                      tarjaCreada.ttarjaFecha);

                  //INSERT Detalle Cuarteles en BD local
                  for (int i = 0; i < cuarteles.cuarteles.length; i++) {
                    final detCuartelTemp = new TDetCuartelLocalModel(
                        tdetcuartelLinea:
                            cuarteles.cuarteles[i].tdetcuartelLinea,
                        tdetcuartelDomain:
                            cuarteles.cuarteles[i].tdetcuartelDomain,
                        tdetcuartelFundo:
                            cuarteles.cuarteles[i].tdetcuartelFundo,
                        tdetcuartelFundoNombre:
                            cuarteles.cuarteles[i].tdetcuartelFundoNombre,
                        tdetcuartelFecha:
                            cuarteles.cuarteles[i].tdetcuartelFecha,
                        tdetcuartelCuartel:
                            cuarteles.cuarteles[i].tdetcuartelCuartel,
                        tdetcuartelCuartelNombre:
                            cuarteles.cuarteles[i].tdetcuartelCuartelNombre,
                        tdetcuartelCantidad:
                            cuarteles.cuarteles[i].tdetcuartelCantidad,
                        tdetcuartelEstado:
                            cuarteles.cuarteles[i].tdetcuartelEstado);
                    await DBProvider.db.nuevoDetCuartelRaw(detCuartelTemp);
                  }

                  cuarteles.cuarteles.clear();
                  TarjaProv.jornada = 1;
                  _showDialogResult(context, dbProvider);
                }
              } else {
                _showDialogErrorCantidad(context);
              }

              await dbProvider.cargarTDetCuartelesByCabecera(TarjaProv.linea,
                  TarjaProv.dominio, TarjaProv.fundo, TarjaProv.fecha);

              print('Length Det Cuarteles: ' +
                  dbProvider.Detcuarteles.length.toString());

              if (dbProvider.Detcuarteles.length == 0) {
                //INSERT Detalle Cuarteles en BD local
                for (int i = 0; i < cuarteles.cuarteles.length; i++) {
                  final detCuartelTemp = new TDetCuartelLocalModel(
                      tdetcuartelLinea: cuarteles.cuarteles[i].tdetcuartelLinea,
                      tdetcuartelDomain:
                          cuarteles.cuarteles[i].tdetcuartelDomain,
                      tdetcuartelFundo: cuarteles.cuarteles[i].tdetcuartelFundo,
                      tdetcuartelFundoNombre:
                          cuarteles.cuarteles[i].tdetcuartelFundoNombre,
                      tdetcuartelFecha: cuarteles.cuarteles[i].tdetcuartelFecha,
                      tdetcuartelCuartel:
                          cuarteles.cuarteles[i].tdetcuartelCuartel,
                      tdetcuartelCuartelNombre:
                          cuarteles.cuarteles[i].tdetcuartelCuartelNombre,
                      tdetcuartelCantidad:
                          cuarteles.cuarteles[i].tdetcuartelCantidad,
                      tdetcuartelEstado:
                          cuarteles.cuarteles[i].tdetcuartelEstado);
                  await DBProvider.db.nuevoDetCuartelRaw(detCuartelTemp);
                }
              }      


            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
