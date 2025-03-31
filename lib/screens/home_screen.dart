import 'package:flutter/material.dart';
import 'package:qad_tarjas/local_models/local_models.dart';
import 'package:qad_tarjas/providers/providers.dart';
import 'package:qad_tarjas/services/services.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:qad_tarjas/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<LocalListProvider>(context);
    final fundosApi = Provider.of<FundosServices>(context);
    final empleadosApi = Provider.of<EmpleadosServices>(context);
    final operacionesApi = Provider.of<OperacionesServices>(context);
    final tpagoApi = Provider.of<TipoPagoServices>(context);
    final thoraApi = Provider.of<TipoHoraServices>(context);
    final cuartelesApi = Provider.of<CuartelesServices>(context);
    final hilerasApi = Provider.of<HilerasServices>(context);
    final MaxHEApi = Provider.of<MaxHEServices>(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Color(0xFF5A87C6),
            title: Container(
                //alignment: Alignment.centerLeft,
                child: Text(
              'QAD Tarjas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          )),
      drawer: DrawerMenuWidget(),
      body: Stack(
        children: [
          Container(
            //color: Colors.red,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: MaterialButton(
                      onPressed: () async {

                        _confirmarCargaQAD(
                            context,
                            dbProvider,
                            fundosApi,
                            empleadosApi,
                            operacionesApi,
                            tpagoApi,
                            thoraApi,
                            cuartelesApi,
                            hilerasApi,
                            MaxHEApi);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: Color(0xFF5A87C6),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        child: Text('Cargar Datos Maestros QAD',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: MaterialButton(
                      onPressed: () async {
                        _confirmarEnvioQAD(context, dbProvider);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: Color(0xFF5A87C6),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        child: dbProvider.isLoadingQAD
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Espere...',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                ],
                              )
                            : Text('Enviar a QAD',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                      child:
                          //Text(dbProvider.countEnvioQAD.toString()))
                          dbProvider.isLoadingQAD
                              ? Text(dbProvider.countEnvioQAD.toString() +
                                  '/' +
                                  dbProvider.tarjasPend.length.toString() +
                                  ' Datos Enviados...')
                              : Text(''))
                ],
              ),
            ),
          ),
          dbProvider.isLoading
              ? Container(
                  alignment: AlignmentDirectional.center,
                  decoration: new BoxDecoration(
                    color: Colors.white70,
                  ),
                  child: new Container(
                    decoration: new BoxDecoration(
                        color: Colors.black54,
                        borderRadius: new BorderRadius.circular(10.0)),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.9,
                    alignment: AlignmentDirectional.center,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Center(
                          child: new SizedBox(
                            height: 50.0,
                            width: 50.0,
                            child: new CircularProgressIndicator(
                              value: null,
                              strokeWidth: 7.0,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25.0),
                          child: Center(
                            child: Text(
                              "Cargando Datos Maestros QAD",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25.0),
                          child: Center(
                            child: Text(
                              "Espere Por Favor...",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
      bottomNavigationBar: Container(
        height: 90.0,
        child: Center(
          child: Column(
            children: [
              Text(
                'Versión: 20231219',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Conectado a: ' + Preferences.ambiente,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Fundo: ' + Preferences.fundo,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              /* SizedBox(height: 5),
              Text(
                'IdDisp: ' + Preferences.idDevice,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

Future<String?> _showDialogResult(
    BuildContext context, LocalListProvider dbProvider) async {
  return showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('Los Datos se han Cargado Exitosamente',
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

Future<String?> _showDialogResultEnvioQAD(
    BuildContext context, LocalListProvider dbProvider) async {
  return showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('Datos Enviados Exitosamente', textAlign: TextAlign.center),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            dbProvider.countEnvioQAD = 0;
            print('CountErrorEnvioQAD: ' +
                dbProvider.countErrorEnvioQAD.toString());
            print(dbProvider.tarjasNoEnviadas);
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

Future<String?> _showDialogResultErrorEnvioQAD(
    BuildContext context, LocalListProvider dbProvider) async {
  return showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Column(
        children: [
          Icon(Icons.warning_rounded, size: 40, color: Colors.red),
          SizedBox(height: 10),
          Text('Hay Registro que no se Enviaron a QAD:',
              textAlign: TextAlign.center),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Fecha',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                Text('Linea',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                Text('Fundo',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18))
              ],
            ),
            SizedBox(height: 10),
            Container(
              //color: Colors.red,
              width: double.maxFinite,
              height: 200,
              child: ListView.separated(
                itemCount: dbProvider.tarjasNoEnviadas.length,
                separatorBuilder: (context, index) => Divider(height: 5),
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(dbProvider.tarjasNoEnviadas[index].ttarjaFecha),
                      Text(dbProvider.tarjasNoEnviadas[index].ttarjaLinea
                          .toString()),
                      Text(dbProvider.tarjasNoEnviadas[index].ttarjaFundo),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            dbProvider.countEnvioQAD = 0;
            dbProvider.countErrorEnvioQAD = 0;
            dbProvider.tarjasNoEnviadas.clear();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

Future<String?> _showDialogErrorValidacionOpManual(
    BuildContext context, LocalListProvider dbProvider, List<TtarjaLocalModel> tarjasErrorOPManual) async {
  return showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Column(
        children: [
          Icon(Icons.warning_rounded, size: 40, color: Colors.red),
          SizedBox(height: 10),
          Text('Debe Eliminar los Siguientes Registros antes de Enviar a QAD:',
              textAlign: TextAlign.center),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Fecha',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                Text('Linea',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                Text('Fundo',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18))
              ],
            ),
            SizedBox(height: 10),
            Container(
              //color: Colors.red,
              width: double.maxFinite,
              height: 200,
              child: ListView.separated(
                itemCount: tarjasErrorOPManual.length,
                separatorBuilder: (context, index) => Divider(height: 5),
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(tarjasErrorOPManual[index].ttarjaFecha),
                      Text(tarjasErrorOPManual[index].ttarjaLinea
                          .toString()),
                      Text(tarjasErrorOPManual[index].ttarjaFundo),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            dbProvider.countEnvioQAD = 0;
            dbProvider.countErrorEnvioQAD = 0;
            tarjasErrorOPManual.clear();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

Future<String?> _showDialogErrorServer(BuildContext context) async {
  return showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('Servidor Caido', textAlign: TextAlign.center),
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

Future<void> _confirmarCargaQAD(
    BuildContext context,
    LocalListProvider dbProvider,
    FundosServices fundosApi,
    EmpleadosServices empleadosApi,
    OperacionesServices operacionesApi,
    TipoPagoServices tpagoApi,
    TipoHoraServices thoraApi,
    CuartelesServices cuartelesApi,
    HilerasServices hilerasApi,
    MaxHEServices MaxHEApi) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: [
            Icon(Icons.warning_rounded, size: 40, color: Colors.red),
            SizedBox(height: 10),
            Text('Por Favor Confirmar', textAlign: TextAlign.center),
          ],
        ),
        content: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: '¿Desea ',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              TextSpan(
                  text: 'Cargar Datos Maestros QAD ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: '?',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
            ])),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
                backgroundColor: Color(0xFF5A87C6)),
            child: Text('Cargar', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              dbProvider.isLoading = true;

              print(Preferences.servidor);
              print(Preferences.usuario);
              print(Preferences.pass);
              print(Preferences.fundoCod);

              DBProvider.db.database;

              await fundosApi.getFundos();

              //print(fundosApi.fundos.isEmpty);
              print(fundosApi.fundos.length);

              if (fundosApi.fundos.isEmpty) {
                _showDialogErrorServer(context);
              } else {
                DBProvider.db.deleteData();

                await empleadosApi.getEmpleados();
                //print(empleadosApi.empleados.isEmpty);
                print(empleadosApi.empleados.length);
                await operacionesApi.getOperaciones();
                //print(operacionesApi.ops.isEmpty);
                print(operacionesApi.ops.length);
                await tpagoApi.getTipoPago();
                //print(tpagoApi.tpago.isEmpty);
                print(tpagoApi.tpago.length);
                await thoraApi.getTipoHora();
                //print(thoraApi.thora.isEmpty);
                print(thoraApi.thora.length);
                await cuartelesApi.getCuarteles();
                print(cuartelesApi.cuarteles.length);
                //print(cuartelesApi.cuarteles.isEmpty);
                await hilerasApi.getHileras();
                print(hilerasApi.hileras.length);
                await MaxHEApi.getMaxHE();
                print(MaxHEApi.maxHE.length);

                //INSERT Fundos
                for (int i = 0; i < fundosApi.fundos.length; i++) {
                  final tempFundo = new TfundoLocalModel(
                      tfundoCod: fundosApi.fundos[i].siMstrSiSite,
                      tfundoDominio: fundosApi.fundos[i].siMstrSiDomain,
                      tfundoNombre: fundosApi.fundos[i].siMstrSiDesc);
                  await DBProvider.db.nuevoTfundoRaw(tempFundo);
                }

                //INSERT Empleados
                for (int i = 0; i < empleadosApi.empleados.length; i++) {
                  final tempEmp = new TempleadoLocalModel(
                    templeadoDominio:
                        empleadosApi.empleados[i].empMstrEmpDomain,
                    templeadoCod: empleadosApi.empleados[i].empMstrEmpAddr,
                    templeadoFundo: empleadosApi.empleados[i].empMstrEmpChr02,
                    templeadoNombre: empleadosApi.empleados[i].empMstrEmpSort,
                    templeadoRut: empleadosApi.empleados[i].empMstrEmpAddr,
                    templeadoActivo:
                        empleadosApi.empleados[i].empMstrEmpActive ? 1 : 0,
                    templeadoContratista:
                        empleadosApi.empleados[i].xxempMstrXxempUlog10 ? 1 : 0,
                  );
                  await DBProvider.db.nuevoTEmpleadoRaw(tempEmp);
                }

                //INSERT Operaciones
                for (int i = 0; i < operacionesApi.ops.length; i++) {
                  final tempOps = new ToperacionLocalModel(
                      toperacionOp:
                          operacionesApi.ops[i].xxawoMstrXxawoNbr.toString(),
                      toperacionDominio:
                          operacionesApi.ops[i].xxawoMstrXxawoDomain,
                      toperacionFundo: operacionesApi.ops[i].xxawoMstrXxawoSite,
                      toperacionNombre:
                          operacionesApi.ops[i].xxawoMstrXxawoDesc,
                      toperacionManual:
                          operacionesApi.ops[i].xxawoMstrXxawoShare ? 1 : 0,
                      toperacion_um: operacionesApi.ops[i].xxawoMstrXxawoUm);
                  await DBProvider.db.nuevoTOperacionRaw(tempOps);
                }

                //INSERT Tpago
                for (int i = 0; i < tpagoApi.tpago.length; i++) {
                  final tempTpago = new TtpagoLocalModel(
                    tpagoCod: tpagoApi.tpago[i].localVariablesLocalVar00,
                    tpagoDominio: tpagoApi.tpago[i].wcMstrWcDomain,
                    tpagoFundo: tpagoApi.tpago[i].wcMstrWcChr01,
                    tpagoNombre: tpagoApi.tpago[i].wcMstrWcDesc,
                    tpagoTarifa: tpagoApi.tpago[i].localVariablesLocalVar01,
                    tpagoTrato: tpagoApi.tpago[i].wcMstrWcMchOp,
                  );
                  await DBProvider.db.nuevoTtpagoRaw(tempTpago);
                }

                //INSERT Thora
                for (int i = 0; i < thoraApi.thora.length; i++) {
                  final tempThora = new TthoraLocalModel(
                      thoraCod: thoraApi.thora[i].codeMstrCodeValue,
                      thoraDominio: thoraApi.thora[i].codeMstrCodeDomain,
                      thoraNombre: thoraApi.thora[i].codeMstrCodeCmmt);
                  await DBProvider.db.nuevoTthoraRaw(tempThora);
                }

                //INSERT Cuartel
                for (int i = 0; i < cuartelesApi.cuarteles.length; i++) {
                  final tempTcuartel = new TcuartelLocalModel(
                      tcuartelOp: cuartelesApi.cuarteles[i].xxawoMstrXxawoNbr
                          .toString(),
                      tcuartelDominio:
                          cuartelesApi.cuarteles[i].xxawoMstrXxawoDomain,
                      tcuartelFundo:
                          cuartelesApi.cuarteles[i].xxawoMstrXxawoSite,
                      tcuartelCuartel:
                          cuartelesApi.cuarteles[i].xxawodDetXxawodLoc,
                      tcuartelNombre: cuartelesApi.cuarteles[i].locMstrLocDesc,
                      tcuartelSelected: 0,
                      tcuartelHilera: 0,
                      tcuartelCantidad: 0,
                      tcuartelCantPlantas:
                          cuartelesApi.cuarteles[i].xxpadDetXxpadNumPla,
                      tcuartelValid: 0);
                  await DBProvider.db.nuevoTcuartelRaw(tempTcuartel);
                }

                for (int i = 0; i < hilerasApi.hileras.length; i++) {
                  final tempThilera = new ThileraLocalModel(
                      thileraFundo:
                          hilerasApi.hileras[i].xxhileraMstrXxhileraSite,
                      thileraCuartel:
                          hilerasApi.hileras[i].xxhileraMstrXxhileraLoc,
                      thileraCodigo:
                          hilerasApi.hileras[i].xxhileraMstrXxhileraHilera,
                      thileraNombre:
                          hilerasApi.hileras[i].xxhileraMstrXxhileraDesc,
                      thileraCantidad:
                          hilerasApi.hileras[i].xxhileraMstrXxhileraCant,
                      thileraSelected: 0);
                  await DBProvider.db.nuevoTHileraRaw(tempThilera);
                }

                for (int i = 0; i < MaxHEApi.maxHE.length; i++) {
                  final tempMaxHE = new MaxHeLocalModel(
                      tmaxheFundo: MaxHEApi.maxHE[i].xxagCtrlXxagSite,
                      tmaxheHoras: MaxHEApi.maxHE[i].xxagCtrlXxagUdec05);
                  await DBProvider.db.nuevoTMaxHERaw(tempMaxHE);
                }

                fundosApi.fundos.clear();
                empleadosApi.empleados.clear();
                operacionesApi.ops.clear();
                tpagoApi.tpago.clear();
                thoraApi.thora.clear();
                cuartelesApi.cuarteles.clear();
                hilerasApi.hileras.clear();
                MaxHEApi.maxHE.clear();
              }

              dbProvider.isLoading = false;
              _showDialogResult(context, dbProvider);
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
                backgroundColor: Colors.grey),
            child: Text('Cancelar', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _confirmarEnvioQAD(
    BuildContext context, LocalListProvider dbProvider) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: [
            Icon(Icons.warning_rounded, size: 40, color: Colors.red),
            SizedBox(height: 10),
            Text('Por Favor Confirmar', textAlign: TextAlign.center),
          ],
        ),
        content: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: '¿Desea ',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              TextSpan(
                  text: 'Enviar Datos a QAD ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: '?',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
            ])),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
                backgroundColor: Color(0xFF5A87C6)),
            child: Text('Enviar', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));

              dbProvider.isLoadingQAD = true;
              int cont = 0;
              List<TtarjaLocalModel> tarjasErrorOPManual = [];

              await dbProvider.cargarTarjasPendientes(
                  Preferences.dominio, 'Pendiente');

              for (int i = 0; i < dbProvider.tarjasPend.length; i++) {
                if (dbProvider.tarjasPend[i].ttarjaOpManual == 1) {
                  await dbProvider.cargarTDetCuartelesByCabecera(
                      dbProvider.tarjasPend[i].ttarjaLinea,
                      dbProvider.tarjasPend[i].ttarjaDomain,
                      dbProvider.tarjasPend[i].ttarjaFundo,
                      dbProvider.tarjasPend[i].ttarjaFecha);
                  if (dbProvider.Detcuarteles.length == 0) {
                    cont++;
                    final tempTarja = new TtarjaLocalModel(
                        ttarjaDomain: dbProvider.tarjasPend[i].ttarjaDomain,
                        ttarjaFundo: dbProvider.tarjasPend[i].ttarjaFundo,
                        ttarjaFundoNombre:
                            dbProvider.tarjasPend[i].ttarjaFundoNombre,
                        ttarjaFecha: dbProvider.tarjasPend[i].ttarjaFecha,
                        ttarjaLinea: dbProvider.tarjasPend[i].ttarjaLinea,
                        ttarjaEmpleado: dbProvider.tarjasPend[i].ttarjaEmpleado,
                        ttarjaEmpleadoNombre:
                            dbProvider.tarjasPend[i].ttarjaEmpleadoNombre,
                        ttarjaEstado: dbProvider.tarjasPend[i].ttarjaEstado,
                        ttarjaHextra: dbProvider.tarjasPend[i].ttarjaHextra,
                        ttarjaHora: dbProvider.tarjasPend[i].ttarjaHora,
                        ttarjaHoraNombre:
                            dbProvider.tarjasPend[i].ttarjaHoraNombre,
                        ttarjaJornada: dbProvider.tarjasPend[i].ttarjaJornada,
                        ttarjaOperacion:
                            dbProvider.tarjasPend[i].ttarjaOperacion,
                        ttarjaOperacionNombre:
                            dbProvider.tarjasPend[i].ttarjaOperacionNombre,
                        ttarjaOperacionUM:
                            dbProvider.tarjasPend[i].ttarjaOperacionUM,
                        ttarjaPago: dbProvider.tarjasPend[i].ttarjaPago,
                        ttarjaPagoNombre:
                            dbProvider.tarjasPend[i].ttarjaPagoNombre,
                        ttarjaProcesado:
                            dbProvider.tarjasPend[i].ttarjaProcesado,
                        ttarjaRegistro: dbProvider.tarjasPend[i].ttarjaRegistro,
                        ttarjaOpManual: dbProvider.tarjasPend[i].ttarjaOpManual,
                        ttarjaCantidad: dbProvider.tarjasPend[i].ttarjaCantidad,
                        ttarjaServidor: dbProvider.tarjasPend[i].ttarjaServidor,
                        ttarjaSelected:
                            dbProvider.tarjasPend[i].ttarjaSelected);

                    tarjasErrorOPManual.add(tempTarja);
                  }
                }
              }

              print('Cont: ' + cont.toString());

              if (cont == 0) {
                for (int i = 0; i < dbProvider.tarjasPend.length; i++) {
                  dbProvider.countEnvioQAD = i;
                  print(dbProvider.countEnvioQAD.toString());

                  if (dbProvider.tarjasPend[i].ttarjaServidor ==
                      Preferences.ambiente) {
                    await dbProvider.cargarTDetCuarteles(
                        dbProvider.tarjasPend[i].ttarjaLinea,
                        Preferences.dominio,
                        dbProvider.tarjasPend[i].ttarjaFecha);
                    dbProvider.tarjasPend[i].ttarjaOpManual == 0
                        ? await EnvioQADAutoService().sendDataAutoQAD(
                            dbProvider.tarjasPend[i].ttarjaDomain,
                            dbProvider.tarjasPend[i].ttarjaFundo +
                                '-' +
                                Preferences.idDevice,
                            dbProvider.tarjasPend[i].ttarjaFecha,
                            dbProvider.tarjasPend[i].ttarjaLinea,
                            dbProvider.tarjasPend[i].ttarjaEmpleado,
                            dbProvider.tarjasPend[i].ttarjaEstado,
                            dbProvider.tarjasPend[i].ttarjaHextra,
                            dbProvider.tarjasPend[i].ttarjaHora,
                            dbProvider.tarjasPend[i].ttarjaJornada,
                            dbProvider.tarjasPend[i].ttarjaOperacion,
                            dbProvider.tarjasPend[i].ttarjaPago,
                            dbProvider.tarjasPend[i].ttarjaCantidad,
                            dbProvider.tarjasPend[i].ttarjaProcesado == 0
                                ? false
                                : true,
                            dbProvider.tarjasPend[i].ttarjaRegistro,
                            dbProvider)
                        : await EnvioQADManualService().sendDataManualQAD(
                            dbProvider,
                            dbProvider.tarjasPend[i].ttarjaDomain,
                            dbProvider.tarjasPend[i].ttarjaFundo +
                                '-' +
                                Preferences.idDevice,
                            dbProvider.tarjasPend[i].ttarjaFecha,
                            dbProvider.tarjasPend[i].ttarjaLinea,
                            dbProvider.tarjasPend[i].ttarjaEmpleado,
                            dbProvider.tarjasPend[i].ttarjaEstado,
                            dbProvider.tarjasPend[i].ttarjaHextra,
                            dbProvider.tarjasPend[i].ttarjaHora,
                            dbProvider.tarjasPend[i].ttarjaJornada,
                            dbProvider.tarjasPend[i].ttarjaOperacion,
                            dbProvider.tarjasPend[i].ttarjaPago,
                            dbProvider.tarjasPend[i].ttarjaProcesado == 0
                                ? false
                                : true,
                            dbProvider.tarjasPend[i].ttarjaRegistro,
                            dbProvider.tarjasPend[i].ttarjaCantidad,
                            dbProvider);
                  }
                }

                dbProvider.isLoadingQAD = false;
                dbProvider.countErrorEnvioQAD == 0
                    ? _showDialogResultEnvioQAD(context, dbProvider)
                    : _showDialogResultErrorEnvioQAD(context, dbProvider);

                print('CountErrorEnvioQAD: ' +
                    dbProvider.countErrorEnvioQAD.toString());
                for (int i = 0; i < dbProvider.tarjasNoEnviadas.length; i++) {
                  print(dbProvider.tarjasNoEnviadas[i].ttarjaFecha);
                  print(dbProvider.tarjasNoEnviadas[i].ttarjaFundo);
                  print(dbProvider.tarjasNoEnviadas[i].ttarjaLinea);
                }
                //dbProvider.countEnvioQAD = 0;
              } else {
                _showDialogErrorValidacionOpManual(context, dbProvider, tarjasErrorOPManual);
                dbProvider.isLoadingQAD = false;
              }
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
                backgroundColor: Colors.grey),
            child: Text('Cancelar', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
