
// ignore_for_file: unused_local_variable
import 'dart:io';
import 'package:qad_tarjas/local_models/local_models.dart';
import 'package:qad_tarjas/models/models.dart';
import 'package:qad_tarjas/providers/local_list_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database?> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'TarjaDB.db');
    print(path);

    return await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE tfundo (
          tfundo_cod VARCHAR(8) PRIMARY KEY, 
          tfundo_dominio VARCHAR(8),
          tfundo_nombre VARCHAR(24)
        )    
 ''');
      await db.execute('''
        CREATE TABLE templeado (
          templeado_cod VARCHAR(8) PRIMARY KEY, 
          templeado_dominio VARCHAR(8),
          templeado_fundo VARCHAR(8),
          templeado_nombre VARCHAR(36),
          templeado_rut VARCHAR(10),
          templeado_activo BIT,
          templeado_contratista BIT
          )       
 ''');
      await db.execute('''
        CREATE TABLE toperacion (
          toperacion_op VARCHAR(3) PRIMARY KEY, 
          toperacion_dominio VARCHAR(8),
          toperacion_fundo VARCHAR(8),
          toperacion_nombre VARCHAR(24),
          toperacion_manual BIT,
          toperacion_um VARCHAR(8)
          )       
 ''');
      await db.execute('''
        CREATE TABLE tpago (
          tpago_cod VARCHAR(4), 
          tpago_dominio VARCHAR(8),
          tpago_fundo VARCHAR(8),
          tpago_nombre VARCHAR(24),
          tpago_tarifa FLOAT,
          tpago_trato INT
          )       
 ''');
      await db.execute('''
        CREATE TABLE thora (
          thora_cod VARCHAR(1) PRIMARY KEY, 
          thora_dominio VARCHAR(8),
          thora_nombre VARCHAR(12)
          )       
 ''');
      await db.execute('''
        CREATE TABLE tcuartel (
          tcuartel_op VARCHAR(3), 
          tcuartel_dominio VARCHAR(8),
          tcuartel_fundo VARCHAR(8),
          tcuartel_cuartel VARCHAR(8),
          tcuartel_nombre VARCHAR(24),
          tcuartel_selected BIT,
          tcuartel_hilera BIT,
          tcuartel_cantidad FLOAT,
          tcuartel_cant_plantas INTEGER,
          tcuartel_valid BIT
          )       
 ''');
      await db.execute('''
        CREATE TABLE ttarja (
          ttarja_domain VARCHAR(8),
          ttarja_fundo VARCHAR(8),
          ttarja_fundo_nombre VARCHAR(24), 
          ttarja_fecha VARCHAR,
          ttarja_linea INTEGER,
          ttarja_empleado VARCHAR(8),
          ttarja_empleado_nombre VARCHAR(36),
          ttarja_operacion VARCHAR(3),
          ttarja_operacion_nombre VARCHAR(24),
          ttarja_operacion_um VARCHAR(8),
          ttarja_pago VARCHAR(3),
          ttarja_pago_nombre VARCHAR(24),
          ttarja_hora VARCHAR(1),
          ttarja_hora_nombre VARCHAR(12),
          ttarja_jornada FLOAT,
          ttarja_registro FLOAT,
          ttarja_hextra FLOAT,
          ttarja_procesado BIT,
          ttarja_estado VARCHAR(12),
          ttarja_opmanual BIT,
          ttarja_cantidad FLOAT,
          ttarja_servidor VARCHAR(8),
          ttarja_selected BIT
          )       
 ''');
      await db.execute('''
        CREATE TABLE tdetcuartel (
          tdetcuartel_linea INTEGER, 
          tdetcuartel_domain VARCHAR(8),
          tdetcuartel_fundo VARCHAR(8),
          tdetcuartel_fundo_nombre VARCHAR(24),
          tdetcuartel_fecha VARCHAR,
          tdetcuartel_cuartel VARCHAR(8),
          tdetcuartel_cuartel_nombre VARCHAR(24),
          tdetcuartel_cantidad FLOAT,
          tdetcuartel_estado VARCHAR(12)
          )       
 ''');
      await db.execute('''
        CREATE TABLE thilera (
          thilera_fundo VARCHAR(24), 
          thilera_cuartel VARCHAR(24),
          thilera_codigo VARCHAR(24),
          thilera_nombre VARCHAR(24),
          thilera_cantidad INTEGER,
          thilera_selected INTEGER
          )       
 ''');
      await db.execute('''
        CREATE TABLE tmaxhe (
          tmaxhe_fundo VARCHAR(24), 
          tmaxhe_horas INTEGER
          )       
 ''');
    });
  }

  nuevoTfundoRaw(TfundoLocalModel nuevoTfundo) async {
    final tfundo_cod = nuevoTfundo.tfundoCod;
    final tfundo_dominio = nuevoTfundo.tfundoDominio;
    final tfundo_nombre = nuevoTfundo.tfundoNombre;

    final db = await database;

    final res = await db!.rawInsert('''
      INSERT INTO tfundo (tfundo_cod, tfundo_dominio, tfundo_nombre) 
      SELECT * FROM (SELECT '$tfundo_cod' AS tfundo_cod, '$tfundo_dominio' AS tfundo_dominio, '$tfundo_nombre' 
      AS tfundo_nombre) AS tmp
      WHERE NOT EXISTS (
        SELECT tfundo_cod, tfundo_dominio FROM tfundo WHERE tfundo_cod = '$tfundo_cod' 
        AND tfundo_dominio = '$tfundo_dominio') LIMIT 1;
      
    ''');
    print(res);
  }

  nuevoTEmpleadoRaw(TempleadoLocalModel nuevoTempleado) async {
    final templeado_cod = nuevoTempleado.templeadoCod;
    final templeado_dominio = nuevoTempleado.templeadoDominio;
    final templeado_fundo = nuevoTempleado.templeadoFundo;
    final templeado_nombre = nuevoTempleado.templeadoNombre;
    final templeado_rut = nuevoTempleado.templeadoRut;
    final templeado_activo = nuevoTempleado.templeadoActivo;
    final templeado_contratista = nuevoTempleado.templeadoContratista;

    final db = await database;

    final res = await db!.rawInsert('''
      INSERT INTO templeado (templeado_cod, templeado_dominio, templeado_fundo, templeado_nombre, 
      templeado_rut, templeado_activo, templeado_contratista) 
      SELECT * FROM (SELECT '$templeado_cod' AS templeado_cod, '$templeado_dominio' AS templeado_dominio, 
      '$templeado_fundo' AS templeado_fundo, '$templeado_nombre' AS templeado_nombre, 
      '$templeado_rut' AS templeado_rut, '$templeado_activo' AS templeado_activo, 
      '$templeado_contratista' AS templeado_contratista) AS tmp
      WHERE NOT EXISTS (
        SELECT templeado_cod, templeado_dominio FROM templeado WHERE templeado_cod = '$templeado_cod' 
        AND templeado_dominio = '$templeado_dominio') LIMIT 1;
      
    ''');
    print(res);
  }

  nuevoTOperacionRaw(ToperacionLocalModel nuevoToperacion) async {
    final toperacion_op = nuevoToperacion.toperacionOp;
    final toperacion_dominio = nuevoToperacion.toperacionDominio;
    final toperacion_nombre = nuevoToperacion.toperacionNombre;
    final toperacion_fundo = nuevoToperacion.toperacionFundo;
    final toperacion_manual = nuevoToperacion.toperacionManual;
    final toperacion_um = nuevoToperacion.toperacion_um;

    final db = await database;

    final res = await db!.rawInsert('''
      INSERT INTO toperacion (toperacion_op, toperacion_dominio, toperacion_fundo, toperacion_nombre, 
      toperacion_manual, toperacion_um) 
      SELECT * FROM (SELECT '$toperacion_op' AS toperacion_op, '$toperacion_dominio' AS toperacion_dominio, 
      '$toperacion_fundo' AS toperacion_fundo, '$toperacion_nombre' AS toperacion_nombre, 
      '$toperacion_manual' AS toperacion_manual, '$toperacion_um' AS toperacion_um) AS tmp
      WHERE NOT EXISTS (
        SELECT toperacion_op, toperacion_dominio FROM toperacion WHERE toperacion_op = '$toperacion_op' AND 
        toperacion_dominio = '$toperacion_dominio') LIMIT 1;
      
    ''');
    print(res);
  }

  nuevoTtpagoRaw(TtpagoLocalModel nuevoTpago) async {
    final ttpago_cod = nuevoTpago.tpagoCod;
    final ttpago_dominio = nuevoTpago.tpagoDominio;
    final ttpago_nombre = nuevoTpago.tpagoNombre;
    final ttpago_fundo = nuevoTpago.tpagoFundo;
    final ttpago_tarifa = nuevoTpago.tpagoTarifa;
    final ttpago_trato = nuevoTpago.tpagoTrato;

    final db = await database;

    final res = await db!.rawInsert('''
      INSERT INTO tpago (tpago_cod, tpago_dominio, tpago_fundo, tpago_nombre, tpago_tarifa, tpago_trato) 
      SELECT * FROM (SELECT '$ttpago_cod' AS ttpago_cod, '$ttpago_dominio' AS ttpago_dominio, 
      '$ttpago_fundo' AS ttpago_fundo, '$ttpago_nombre' AS ttpago_nombre, '$ttpago_tarifa' AS ttpago_tarifa,
      '$ttpago_trato' AS ttpago_trato) AS tmp
      WHERE NOT EXISTS (
        SELECT tpago_cod, tpago_dominio, tpago_fundo FROM tpago WHERE tpago_cod = '$ttpago_cod' 
        AND tpago_dominio = '$ttpago_dominio' AND tpago_fundo = '$ttpago_fundo') LIMIT 1;
      
    ''');
    print(res);
  }

  nuevoTthoraRaw(TthoraLocalModel nuevoThora) async {
    final tthora_cod = nuevoThora.thoraCod;
    final tthora_dominio = nuevoThora.thoraDominio;
    final tthora_nombre = nuevoThora.thoraNombre;

    final db = await database;

    final res = await db!.rawInsert('''
      INSERT INTO thora (thora_cod, thora_dominio, thora_nombre) 
      SELECT * FROM (SELECT '$tthora_cod' AS tthora_cod, '$tthora_dominio' AS tthora_dominio, 
      '$tthora_nombre' AS tthora_nombre) AS tmp
      WHERE NOT EXISTS (
        SELECT thora_cod, thora_dominio FROM thora WHERE thora_cod = '$tthora_cod' AND thora_dominio = '$tthora_dominio') LIMIT 1;
      
    ''');
    print(res);
  }

  nuevoTcuartelRaw(TcuartelLocalModel nuevoTcuartel) async {
    final tcuartel_op = nuevoTcuartel.tcuartelOp;
    final tcuartel_dominio = nuevoTcuartel.tcuartelDominio;
    final tcuartel_fundo = nuevoTcuartel.tcuartelFundo;
    final tcuartel_cuartel = nuevoTcuartel.tcuartelCuartel;
    final tcuartel_nombre = nuevoTcuartel.tcuartelNombre;
    final tcuartel_selected = nuevoTcuartel.tcuartelSelected;
    final tcuartel_hilera = nuevoTcuartel.tcuartelHilera;
    final tcuartel_cantidad = nuevoTcuartel.tcuartelCantidad;
    final tcuartel_cant_plantas = nuevoTcuartel.tcuartelCantPlantas;
    final tcuartel_valid = nuevoTcuartel.tcuartelValid;

    final db = await database;

    final res = await db!.rawInsert('''
      INSERT INTO tcuartel (tcuartel_op, tcuartel_dominio, tcuartel_fundo, tcuartel_cuartel, tcuartel_nombre, 
      tcuartel_selected, tcuartel_hilera, tcuartel_cantidad, tcuartel_cant_plantas, tcuartel_valid) 
      SELECT * FROM (SELECT '$tcuartel_op' AS tcuartel_op, '$tcuartel_dominio' AS tcuartel_dominio, 
      '$tcuartel_fundo' AS tcuartel_fundo, '$tcuartel_cuartel' AS tcuartel_cuartel, 
      '$tcuartel_nombre' AS tcuartel_nombre, '$tcuartel_selected' AS tcuartel_selected, 
      '$tcuartel_hilera' AS tcuartel_hilera, '$tcuartel_cantidad' AS tcuartel_cantidad, 
      '$tcuartel_cant_plantas' AS tcuartel_cant_plantas, '$tcuartel_valid' AS tcuartel_valid) AS tmp
      WHERE NOT EXISTS (
        SELECT tcuartel_op, tcuartel_dominio, tcuartel_fundo, tcuartel_cuartel FROM tcuartel WHERE 
        tcuartel_op = '$tcuartel_op' AND tcuartel_dominio = '$tcuartel_dominio' 
        AND tcuartel_fundo = '$tcuartel_fundo' AND tcuartel_cuartel = '$tcuartel_cuartel') LIMIT 1;
      
    ''');
    print(res);
  }

  nuevoTHileraRaw(ThileraLocalModel nuevoThilera) async {
    final thilera_fundo = nuevoThilera.thileraFundo;
    final thilera_cuartel = nuevoThilera.thileraCuartel;
    final thilera_codigo = nuevoThilera.thileraCodigo;
    final thilera_nombre = nuevoThilera.thileraNombre;
    final thilera_cantidad = nuevoThilera.thileraCantidad;
    final thilera_selected = nuevoThilera.thileraSelected;

    final db = await database;

    final res = await db!.rawInsert('''
      INSERT INTO thilera (thilera_fundo, thilera_cuartel, thilera_codigo, thilera_nombre, thilera_cantidad, 
      thilera_selected) 
      SELECT * FROM (SELECT '$thilera_fundo' AS thilera_fundo, '$thilera_cuartel' AS thilera_cuartel, 
      '$thilera_codigo' AS thilera_codigo, '$thilera_nombre' AS thilera_nombre, 
      '$thilera_cantidad' AS thilera_cantidad, '$thilera_selected' AS thilera_selected) AS tmp
      WHERE NOT EXISTS (
        SELECT thilera_fundo, thilera_cuartel, thilera_codigo FROM thilera 
        WHERE thilera_fundo = '$thilera_fundo' AND thilera_cuartel = '$thilera_cuartel' AND 
        thilera_codigo = '$thilera_codigo') LIMIT 1;
      
    ''');
    print(res);
  }

  Future<TtarjaLocalModel> nuevoTtarjaRaw(
      TtarjaLocalModel nuevoTtarja, LocalListProvider dbProvider) async {
    final ttarja_dominio = nuevoTtarja.ttarjaDomain;
    final ttarja_fundo = nuevoTtarja.ttarjaFundo;
    final ttarja_fundo_nombre = nuevoTtarja.ttarjaFundoNombre;
    final ttarja_fecha = nuevoTtarja.ttarjaFecha;
    final ttarja_linea = nuevoTtarja.ttarjaLinea;
    final ttarja_empleado = nuevoTtarja.ttarjaEmpleado;
    final ttarja_empleado_nombre = nuevoTtarja.ttarjaEmpleadoNombre;
    final ttarja_operacion = nuevoTtarja.ttarjaOperacion;
    final ttarja_operacion_nombre = nuevoTtarja.ttarjaOperacionNombre;
    final ttarja_operacion_um = nuevoTtarja.ttarjaOperacionUM;
    final ttarja_pago = nuevoTtarja.ttarjaPago;
    final ttarja_pago_nombre = nuevoTtarja.ttarjaPagoNombre;
    final ttarja_hora = nuevoTtarja.ttarjaHora;
    final ttarja_hora_nombre = nuevoTtarja.ttarjaHoraNombre;
    final ttarja_jornada = nuevoTtarja.ttarjaJornada;
    final ttarja_registro = nuevoTtarja.ttarjaRegistro;
    final ttarja_hextra = nuevoTtarja.ttarjaHextra;
    final ttarja_procesado = nuevoTtarja.ttarjaProcesado;
    final ttarja_estado = nuevoTtarja.ttarjaEstado;
    final ttarja_op_manual = nuevoTtarja.ttarjaOpManual;
    final ttarja_cantidad = nuevoTtarja.ttarjaCantidad;
    final ttarja_servidor = nuevoTtarja.ttarjaServidor;
    final ttarja_selected = nuevoTtarja.ttarjaSelected;

    final tempTarjaCreada = new TtarjaLocalModel(
        ttarjaDomain: ttarja_dominio,
        ttarjaFundo: ttarja_fundo,
        ttarjaFundoNombre: ttarja_fundo_nombre,
        ttarjaFecha: ttarja_fecha,
        ttarjaLinea: ttarja_linea,
        ttarjaEmpleado: ttarja_empleado,
        ttarjaEmpleadoNombre: ttarja_empleado_nombre,
        ttarjaEstado: ttarja_estado,
        ttarjaHextra: ttarja_hextra,
        ttarjaHora: ttarja_hora,
        ttarjaHoraNombre: ttarja_hora_nombre,
        ttarjaJornada: ttarja_jornada,
        ttarjaOperacion: ttarja_operacion,
        ttarjaOperacionNombre: ttarja_operacion_nombre,
        ttarjaOperacionUM: ttarja_operacion_um,
        ttarjaPago: ttarja_pago,
        ttarjaPagoNombre: ttarja_pago_nombre,
        ttarjaProcesado: ttarja_procesado,
        ttarjaRegistro: ttarja_registro,
        ttarjaOpManual: ttarja_op_manual,
        ttarjaCantidad: ttarja_cantidad,
        ttarjaServidor: ttarja_servidor,
        ttarjaSelected: ttarja_selected);

    final db = await database;

    final res = await db!.rawInsert('''
      INSERT INTO ttarja (ttarja_domain, ttarja_fundo, ttarja_fundo_nombre, ttarja_fecha, ttarja_linea, 
      ttarja_empleado, ttarja_empleado_nombre, ttarja_operacion, ttarja_operacion_nombre, ttarja_operacion_um,
      ttarja_pago, ttarja_pago_nombre, ttarja_hora, ttarja_hora_nombre, ttarja_jornada, ttarja_registro, 
      ttarja_hextra, ttarja_procesado, ttarja_estado, ttarja_opmanual, ttarja_cantidad, ttarja_servidor, ttarja_selected) 
      SELECT * FROM (SELECT '$ttarja_dominio' AS ttarja_dominio, '$ttarja_fundo' AS ttarja_fundo,
      '$ttarja_fundo_nombre' AS ttarja_fundo_nombre, '$ttarja_fecha' AS ttarja_fecha, 
      '$ttarja_linea' AS ttarja_linea, '$ttarja_empleado' AS ttarja_empleado, 
      '$ttarja_empleado_nombre' AS ttarja_empleado_nombre, '$ttarja_operacion' AS ttarja_operacion, 
      '$ttarja_operacion_nombre' AS ttarja_operacion_nombre, '$ttarja_operacion_um' AS ttarja_operacion_um,
      '$ttarja_pago' AS ttarja_pago, '$ttarja_pago_nombre' AS ttarja_pago_nombre, '$ttarja_hora' AS ttarja_hora, 
      '$ttarja_hora_nombre' AS ttarja_hora_nombre, '$ttarja_jornada' AS ttarja_jornada, 
      '$ttarja_registro' AS ttarja_registro, '$ttarja_hextra' AS ttarja_hextra, 
      '$ttarja_procesado' AS ttarja_procesado, '$ttarja_estado' AS ttarja_estado, 
      '$ttarja_op_manual' AS ttarja_op_manual, '$ttarja_cantidad' AS ttarja_cantidad, 
      '$ttarja_servidor' AS ttarja_servidor, '$ttarja_selected' AS ttarja_selected) AS tmp
      WHERE NOT EXISTS (
        SELECT ttarja_linea FROM ttarja WHERE ttarja_domain = '$ttarja_dominio' AND 
        ttarja_fundo = '$ttarja_fundo' AND
        ttarja_fecha = '$ttarja_fecha' AND ttarja_linea = '$ttarja_linea') LIMIT 1;
      
    ''');
    print('Dominio: ' +
        ttarja_dominio +
        '; ' +
        'Fundo: ' +
        ttarja_fundo +
        '; ' +
        'Fecha: ' +
        ttarja_fecha +
        '; '
            'Linea: ' +
        ttarja_linea.toString());
    print('Tarja Creada: ' + res.toString());

    return tempTarjaCreada;
  }

  nuevoDetCuartelRaw(TDetCuartelLocalModel nuevoDetCuartel) async {
    final tdetcuartel_linea = nuevoDetCuartel.tdetcuartelLinea;
    final tdetcuartel_dominio = nuevoDetCuartel.tdetcuartelDomain;
    final tdetcuartel_fundo = nuevoDetCuartel.tdetcuartelFundo;
    final tdetcuartel_fundoNombre = nuevoDetCuartel.tdetcuartelFundoNombre;
    final tdetcuartel_fecha = nuevoDetCuartel.tdetcuartelFecha;
    final tdetcuartel_cuartel = nuevoDetCuartel.tdetcuartelCuartel;
    final tdetcuartel_cuartelNombre = nuevoDetCuartel.tdetcuartelCuartelNombre;
    final tdetcuartel_cantidad = nuevoDetCuartel.tdetcuartelCantidad;
    final tdetcuartel_estado = nuevoDetCuartel.tdetcuartelEstado;

    final db = await database;

    final res = await db!.rawInsert('''
      INSERT INTO tdetcuartel (tdetcuartel_linea, tdetcuartel_domain, tdetcuartel_fundo, 
      tdetcuartel_fundo_nombre, tdetcuartel_fecha, tdetcuartel_cuartel, tdetcuartel_cuartel_nombre,
      tdetcuartel_cantidad, tdetcuartel_estado) 
      SELECT * FROM (SELECT '$tdetcuartel_linea' AS tdetcuartel_linea, '$tdetcuartel_dominio' AS tdetcuartel_dominio, 
      '$tdetcuartel_fundo' AS tdetcuartel_fundo, '$tdetcuartel_fundoNombre' AS tdetcuartel_fundoNombre, 
      '$tdetcuartel_fecha' AS tdetcuartel_fecha, '$tdetcuartel_cuartel' AS tdetcuartel_cuartel, 
      '$tdetcuartel_cuartelNombre' AS tdetcuartel_cuartelNombre, '$tdetcuartel_cantidad' AS tdetcuartel_cantidad, 
      '$tdetcuartel_estado' AS tdetcuartel_estado) AS tmp
      WHERE NOT EXISTS (
        SELECT tdetcuartel_linea, tdetcuartel_domain, tdetcuartel_fundo, tdetcuartel_cuartel, tdetcuartel_fecha FROM tdetcuartel WHERE 
        tdetcuartel_linea = '$tdetcuartel_linea' AND tdetcuartel_domain = '$tdetcuartel_dominio' 
        AND tdetcuartel_fundo = '$tdetcuartel_fundo' AND tdetcuartel_cuartel = '$tdetcuartel_cuartel'
        AND tdetcuartel_fecha = '$tdetcuartel_fecha') LIMIT 1;
      
    ''');

    print('Linea: ' +
        tdetcuartel_linea.toString() +
        '; ' +
        'Dominio: ' +
        tdetcuartel_dominio +
        '; ' +
        'Fundo: ' +
        tdetcuartel_fundo +
        '; ' +
        'Cuartel: ' +
        tdetcuartel_cuartel +
        '; ' +
        'Fecha: ' +
        tdetcuartel_fecha);

    print('Det Cuartel Creada: ' + res.toString());

  }

  nuevoTMaxHERaw(MaxHeLocalModel nuevoTMaxHE) async {
    final tmaxhe_fundo = nuevoTMaxHE.tmaxheFundo;
    final tmaxhe_horas = nuevoTMaxHE.tmaxheHoras;

    final db = await database;

    final res = await db!.rawInsert('''
      INSERT INTO tmaxhe (tmaxhe_fundo, tmaxhe_horas) 
      SELECT * FROM (SELECT '$tmaxhe_fundo' AS tmaxhe_fundo, '$tmaxhe_horas' AS tmaxhe_horas) AS tmp
      WHERE NOT EXISTS (
        SELECT tmaxhe_fundo FROM tmaxhe WHERE tmaxhe_fundo = '$tmaxhe_fundo') LIMIT 1;
      
    ''');
    print(res);
  }

  Future<List<UserLocalModel>> getAllUsers() async {
    final db = await database;
    final res = await db!.query('tusers');

    return res.isNotEmpty
        ? res.map((s) => UserLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TtarjaLocalModel>> getAllTarjas(String dominio) async {
    final db = await database;
    final res = await db!
        .query('ttarja', where: 'ttarja_domain = ?', whereArgs: [dominio]);

    return res.isNotEmpty
        ? res.map((s) => TtarjaLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TtarjaLocalModel>> getTarjasPendientes(
      String dominio, String estado) async {
    final db = await database;
    final res = await db!.query('ttarja',
        where: 'ttarja_domain = ? AND ttarja_estado = ?',
        whereArgs: [dominio, estado]);

    return res.isNotEmpty
        ? res.map((s) => TtarjaLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TtarjaLocalModel>> getTarjaFundoFecha(
      String dominio, String fundo, String fecha) async {
    final db = await database;
    final res = await db!.query('ttarja',
        where: 'ttarja_domain = ? AND ttarja_fundo = ? AND ttarja_fecha = ?',
        whereArgs: [dominio, fundo, fecha]);
    print('getTarjaFundoFecha: ' + res.toString());
    return res.isNotEmpty
        ? res.map((s) => TtarjaLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TtarjaLocalModel>> getValEmpleadoJornada(
      String fecha, String empleado, String thora, String dominio) async {
    final db = await database;
    final res = await db!.query('ttarja',
        where:
            'ttarja_fecha = ? AND ttarja_empleado = ? AND ttarja_hora = ? AND ttarja_domain = ?',
        whereArgs: [fecha, empleado, thora, dominio]);

    return res.isNotEmpty
        ? res.map((s) => TtarjaLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<double> getValEmpleadoHE(
      String fecha, String empleado, String thora, String dominio) async {
    final db = await database;
    final res = await db!.rawQuery(
        'SELECT SUM(ttarja_hextra) FROM ttarja WHERE ttarja_fecha = ? AND ttarja_empleado = ? AND ttarja_hora = ? AND ttarja_domain = ?',
        [fecha, empleado, thora, dominio]);
    print(res);
    double _count = 0;
    print(res[0]['SUM(ttarja_hextra)'] == null);
    if (res[0]['SUM(ttarja_hextra)'] == null) {
      _count = 0;
    } else {
      _count = double.parse(res[0]['SUM(ttarja_hextra)'].toString());
    }

    print(res[0]['SUM(ttarja_hextra)']);
    return _count;
  }

  Future<List<TfundoLocalModel>> getAllFundos(String dominio) async {
    final db = await database;
    final res = await db!
        .query('tfundo', where: 'tfundo_dominio = ?', whereArgs: [dominio]);

    return res.isNotEmpty
        ? res.map((s) => TfundoLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<UserModel?> getUserById(int id) async {
    final db = await database;
    final res =
        await db!.query('tusers', where: 'tusers_id = ?', whereArgs: [id]);

    return res.isNotEmpty ? UserModel.fromJson(res.first) : null;
  }

  Future<List<TempleadoLocalModel>> getEmpleadoActivos(
      int activo, String dominio) async {
    final db = await database;
    final res = await db!.query('templeado',
        where: 'templeado_activo = ? AND templeado_dominio = ?',
        whereArgs: [activo, dominio]);

    return res.isNotEmpty
        ? res.map((s) => TempleadoLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TempleadoLocalModel>> getEmpleadoActivosByFundo(
      int activo, String dominio, String fundo) async {
    final db = await database;
    final res = await db!.query('templeado',
        where:
            'templeado_activo = ? AND templeado_dominio = ? AND templeado_fundo = ?',
        whereArgs: [activo, dominio, fundo]);

    return res.isNotEmpty
        ? res.map((s) => TempleadoLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<ToperacionLocalModel>> getOperacionesByFundo(
      String fundo, String dominio) async {
    final db = await database;
    final res = await db!.query('toperacion',
        where: 'toperacion_fundo = ? AND toperacion_dominio = ?',
        whereArgs: [fundo, dominio]);

    return res.isNotEmpty
        ? res.map((s) => ToperacionLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TtpagoLocalModel>> getTpagoByFundo(
      String fundo, String dominio) async {
    final db = await database;
    final res = await db!.query('tpago',
        where: 'tpago_fundo = ? AND tpago_dominio = ?',
        whereArgs: [fundo, dominio]);

    return res.isNotEmpty
        ? res.map((s) => TtpagoLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TtpagoLocalModel>> getTpagoTrato(
      String fundo, String dominio) async {
    final db = await database;
    final res = await db!.query('tpago',
        where: 'tpago_fundo = ? AND tpago_dominio = ? AND tpago_trato = ?',
        whereArgs: [fundo, dominio, 2]);

    return res.isNotEmpty
        ? res.map((s) => TtpagoLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TthoraLocalModel>> getAllThora(String dominio) async {
    final db = await database;
    final res = await db!
        .query('thora', where: 'thora_dominio = ?', whereArgs: [dominio]);

    return res.isNotEmpty
        ? res.map((s) => TthoraLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TthoraLocalModel>> getThoraTrato(String dominio) async {
    final db = await database;
    final res = await db!.query('thora',
        where: 'thora_dominio = ? AND thora_cod != ? AND thora_cod != ?',
        whereArgs: [dominio, 'E', 'B']);

    return res.isNotEmpty
        ? res.map((s) => TthoraLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TthoraLocalModel>> getThoraNormalBono(String dominio) async {
    final db = await database;
    final res = await db!.query('thora',
        where: 'thora_dominio = ? AND thora_cod != ?',
        whereArgs: [dominio, 'E']);

    return res.isNotEmpty
        ? res.map((s) => TthoraLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TthoraLocalModel>> getThoraNormalHE(String dominio) async {
    final db = await database;
    final res = await db!.query('thora',
        where: 'thora_dominio = ? AND thora_cod != ?',
        whereArgs: [dominio, 'B']);

    return res.isNotEmpty
        ? res.map((s) => TthoraLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<ToperacionLocalModel>> getAllOps() async {
    final db = await database;
    final res = await db!.query('toperacion');

    return res.isNotEmpty
        ? res.map((s) => ToperacionLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TtpagoLocalModel>> getAllTpago() async {
    final db = await database;
    final res = await db!.query('tpago');

    return res.isNotEmpty
        ? res.map((s) => TtpagoLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TcuartelLocalModel>> getAllCuarteles() async {
    final db = await database;
    final res = await db!.query('tcuartel');

    return res.isNotEmpty
        ? res.map((s) => TcuartelLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TcuartelLocalModel>> getCuartelesByFundoOp(
      String fundo, String op, String dominio) async {
    final db = await database;
    final res = await db!.query('tcuartel',
        where:
            'tcuartel_fundo = ? AND tcuartel_op = ? AND tcuartel_dominio = ?',
        whereArgs: [fundo, op, dominio]);

    return res.isNotEmpty
        ? res.map((s) => TcuartelLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<ToperacionLocalModel>> getOperacionesByManual(
      int manual, String dominio) async {
    final db = await database;
    final res = await db!.query('toperacion',
        where: 'toperacion_manual = ? AND toperacion_dominio = ?',
        whereArgs: [manual, dominio]);

    return res.isNotEmpty
        ? res.map((s) => ToperacionLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TDetCuartelLocalModel>> getTDetCuartelesByLineaFecha(
      int linea, String dominio, String fecha) async {
    final db = await database;
    final res = await db!.query('tdetcuartel',
        where:
            'tdetcuartel_linea = ? AND tdetcuartel_domain = ? AND tdetcuartel_fecha = ?',
        whereArgs: [linea, dominio, fecha]);

    return res.isNotEmpty
        ? res.map((s) => TDetCuartelLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TDetCuartelLocalModel>> getTDetCuartelesByCabecera(
      int linea, String dominio, String fundo, String fecha) async {
    final db = await database;
    final res = await db!.query('tdetcuartel',
        where:
            'tdetcuartel_linea = ? AND tdetcuartel_domain = ? AND tdetcuartel_fundo = ? AND tdetcuartel_fecha = ?',
        whereArgs: [linea, dominio, fundo, fecha]);

    return res.isNotEmpty
        ? res.map((s) => TDetCuartelLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TDetCuartelLocalModel>> getAllTDetCuarteles(
      String dominio) async {
    final db = await database;
    final res = await db!.query('tdetcuartel',
        where: 'tdetcuartel_domain = ?', whereArgs: [dominio]);

    return res.isNotEmpty
        ? res.map((s) => TDetCuartelLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<TtarjaLocalModel>> getTarjaByFecha(
      String fecha, String dominio) async {
    final db = await database;
    final res = await db!.query('ttarja',
        where: 'ttarja_fecha = ? AND ttarja_domain = ?',
        whereArgs: [fecha, dominio]);

    return res.isNotEmpty
        ? res.map((s) => TtarjaLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<ThileraLocalModel>> getAllHileras() async {
    final db = await database;
    final res = await db!.query('thilera');

    return res.isNotEmpty
        ? res.map((s) => ThileraLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<ThileraLocalModel>> getHileraByCuartel(String cuartel) async {
    final db = await database;
    final res = await db!.rawQuery(
        'SELECT * FROM thilera WHERE thilera_cuartel = ? ORDER BY CAST(thilera_codigo AS INT) ASC',
        [cuartel]);
    //final res = await db!.query('thilera', where: 'thilera_cuartel = ?', whereArgs: [cuartel]);

    return res.isNotEmpty
        ? res.map((s) => ThileraLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<List<MaxHeLocalModel>> getAllMaxHE() async {
    final db = await database;
    final res = await db!.query('tmaxhe');

    return res.isNotEmpty
        ? res.map((s) => MaxHeLocalModel.fromJson(s)).toList()
        : [];
  }

  Future<double> getMaxHEByFundo(String fundo) async {
    final db = await database;
    final res = await db!
        .query('tmaxhe', where: 'tmaxhe_fundo = ?', whereArgs: [fundo]);

    print(res);
    final double _maxHE = double.parse(res[0]['tmaxhe_horas'].toString());
    print('MaxHE: ' + _maxHE.toString());

    return _maxHE;
  }

  Future<int> updateTarjaEstado(int linea, String estado) async {
    final db = await database;
    final res = await db!.rawUpdate('''
    UPDATE ttarja 
    SET ttarja_estado = ? 
    WHERE ttarja_linea = ?
    ''', [estado, linea]);
    return res;
  }

  deleteData() async {
    final db = await database;
    final delFundo = await db!.delete('tfundo');
    final delEmpl = await db.delete('templeado');
    final delOp = await db.delete('toperacion');
    final delTP = await db.delete('tpago');
    final delTH = await db.delete('thora');
    final delCuar = await db.delete('tcuartel');
    final delHil = await db.delete('thilera');
    final delMaxHE = await db.delete('tmaxhe');
  }

  Future<int> deleteTarja(
      String dominio, String fundo, String fecha, int linea) async {
    final db = await database;
    final res = await db!.delete('ttarja',
        where:
            'ttarja_domain = ? AND ttarja_fundo = ? AND ttarja_fecha = ? AND ttarja_linea = ?',
        whereArgs: [dominio, fundo, fecha, linea]);
    return res;
  }

  Future<int> deleteDetCuarteles(int linea) async {
    final db = await database;
    final res = await db!.delete('tdetcuartel',
        where: 'tdetcuartel_linea = ?', whereArgs: [linea]);
    return res;
  }

  nuevoPruebaRaw(TthoraLocalModel nuevoThora) async {
    final tthora_cod = nuevoThora.thoraCod;
    final tthora_dominio = nuevoThora.thoraDominio;
    final tthora_nombre = nuevoThora.thoraNombre;

    final db = await database;

    final result = await db!.rawQuery('''
      SELECT EXISTS(SELECT 1 FROM thora WHERE thora_cod = '$tthora_cod')      
    ''');

    int? _exists = Sqflite.firstIntValue(result);
    print(_exists);

    if (_exists == 0) {
      final res = await db.rawInsert('''
      INSERT INTO thora (thora_cod, thora_dominio, thora_nombre) 
      SELECT * FROM (SELECT '$tthora_cod' AS tthora_cod, '$tthora_dominio' AS tthora_dominio, 
      '$tthora_nombre' AS tthora_nombre) AS tmp
      WHERE NOT EXISTS (
        SELECT thora_cod FROM thora WHERE thora_cod = '$tthora_cod') LIMIT 1;
      ''');

      print(res);
    } else {
      final res = await db.rawUpdate('''
    UPDATE thora 
    SET thora_dominio = ?, thora_nombre = ?
    WHERE thora_cod = ?
    ''', [tthora_dominio, tthora_nombre, tthora_cod]);

      print(res);
    }
  }
}
