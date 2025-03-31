import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static String _dominio = '';
  static String _servidor = '';
  static String _ambiente = '';
  static String _usuario = '';
  static String _pass = '';
  static String _inicio = 'logout';
  static String _user = '';
  static String _fundo = '';
  static String _fundoCod = '';
  static String _connectionStatus = '';
  static String _idDevice = '';
  static String _idDeviceFull = '';
  

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get dominio {
    return _prefs.getString('dominio') ?? _dominio;
  }

  static set dominio(String dominio) {
    _dominio = dominio;
    _prefs.setString('dominio', dominio);
  }

  static String get servidor {
    return _prefs.getString('servidor') ?? _servidor;
  }

  static set servidor(String servidor) {
    _servidor = servidor;
    _prefs.setString('servidor', servidor);
  }

  static String get ambiente {
    return _prefs.getString('ambiente') ?? _ambiente;
  }

  static set ambiente(String ambiente) {
    _ambiente = ambiente;
    _prefs.setString('ambiente', ambiente);
  }

  static String get usuario {
    return _prefs.getString('usuario') ?? _usuario;
  }

  static set usuario(String usuario) {
    _usuario = usuario;
    _prefs.setString('usuario', usuario);
  }

  static String get pass {
    return _prefs.getString('pass') ?? _pass;
  }

  static set pass(String pass) {
    _pass = pass;
    _prefs.setString('pass', pass);
  }

  static String get inicio {
    return _prefs.getString('inicio') ?? _inicio;
  }

  static set inicio(String inicio) {
    _inicio = inicio;
    _prefs.setString('inicio', inicio);
  }

  static String get user {
    return _prefs.getString('user') ?? _user;
  }

  static set user(String user) {
    _user = user;
    _prefs.setString('user', user);
  }

  static String get fundo {
    return _prefs.getString('fundo') ?? _fundo;
  }

  static set fundo(String fundo) {
    _fundo = fundo;
    _prefs.setString('fundo', fundo);
  }

  static String get fundoCod {
    return _prefs.getString('fundoCod') ?? _fundoCod;
  }

  static set fundoCod(String fundoCod) {
    _fundoCod = fundoCod;
    _prefs.setString('fundoCod', fundoCod);
  }

  static String get connectionStatus {
    return _prefs.getString('connectionStatus') ?? _connectionStatus;
  }

  static set connectionStatus(String connectionStatus) {
    _connectionStatus = connectionStatus;
    _prefs.setString('connectionStatus', connectionStatus);
  }

  static String get idDevice {
    return _prefs.getString('idDevice') ?? _idDevice;
  }

  static set idDevice(String idDevice) {
    _idDevice = idDevice;
    _prefs.setString('idDevice', idDevice);
  }

  static String get idDeviceFull {
    return _prefs.getString('idDeviceFull') ?? _idDeviceFull;
  }

  static set idDeviceFull(String idDeviceFull) {
    _idDeviceFull = idDeviceFull;
    _prefs.setString('idDeviceFull', idDeviceFull);
  }
}

