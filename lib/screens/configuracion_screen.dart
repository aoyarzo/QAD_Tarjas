import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:qad_tarjas/constants/environment.dart';
import 'package:qad_tarjas/models/models.dart';
import 'package:qad_tarjas/providers/providers.dart';
import 'package:qad_tarjas/services/services.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ConfiguracionScreen extends StatefulWidget {
  @override
  State<ConfiguracionScreen> createState() => _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends State<ConfiguracionScreen> {
  final _controllerServidor = TextEditingController();

  final _controllerDominio = TextEditingController();

  //final _controllerFundo = TextEditingController();

  final _controllerUser = TextEditingController();

  final _controllerPass = TextEditingController();

  //final _controllerBuscar = TextEditingController();

  List<FundoModel> fundos_temp = [];

  //int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    _controllerServidor.text = Preferences.servidor;
    _controllerDominio.text = Preferences.dominio;
    //_controllerFundo.text = Preferences.fundo;
    _controllerUser.text = Preferences.usuario;
    _controllerPass.text = Preferences.pass;

    final valConfig = Provider.of<ValConfigServices>(context);
    final dbProvider = Provider.of<LocalListProvider>(context);
    //final fundosApi = Provider.of<FundosServices>(context);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Color(0xFF5A87C6),
            title: Container(
                child: Text(
              'Configuración del Servidor',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          )),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        width: double.infinity,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        //color: Colors.red,
                        child: Text('Servidor:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal)),
                      )),
                      Expanded(
                          flex: 3,
                          child: Container(
                            child: _TextFieldServidor(_controllerServidor),
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        //color: Colors.red,
                        child: Text('Dominio:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal)),
                      )),
                      Expanded(
                          flex: 2,
                          child: Container(
                            child: _TextFieldDominio(_controllerDominio),
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        //color: Colors.red,
                        child: Text('Usuario:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal)),
                      )),
                      Expanded(
                          flex: 2,
                          child: Container(
                            child: _TextFieldUser(_controllerUser),
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        //color: Colors.red,
                        child: Text('Contraseña:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal)),
                      )),
                      Expanded(
                          flex: 2,
                          child: Container(
                            child: _TextFieldContrasena(_controllerPass),
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  width: 220,
                  child: MaterialButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      dbProvider.isLoadingConfig = true;

                      //_getId();

                      var uuid = Uuid();
                      var v4 = uuid.v4();
                      var id = v4.substring(9, 13);

                      Preferences.idDevice.isEmpty
                          ? Preferences.idDevice = id
                          : 
                      Preferences.servidor = _controllerServidor.text;
                      Preferences.dominio = _controllerDominio.text;
                      Preferences.usuario = _controllerUser.text;
                      Preferences.pass = _controllerPass.text;

                      if (Preferences.servidor == Environment.url_devl) {
                        Preferences.ambiente = 'devl';
                      } else {
                        if (Preferences.servidor == Environment.url_test) {
                          Preferences.ambiente = 'test';
                        } else {
                          if (Preferences.servidor == Environment.url_prod) {
                            Preferences.ambiente = 'prod';
                          }
                        }
                      }

                      await valConfig.getValConfig(context);
                      //Navigator.pushNamed(context, 'login');

                      dbProvider.isLoadingConfig = false;
                      print(Preferences.idDevice);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    disabledColor: Colors.grey,
                    elevation: 0,
                    color: Color(0xFF5A87C6),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      child: dbProvider.isLoadingConfig
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
                          : Text('Check',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 220,
                  child: MaterialButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();

                      //_getId();

                      var uuid = Uuid();
                      var v4 = uuid.v4();
                      var id = v4.substring(9, 13);

                      Preferences.idDevice.isEmpty
                          ? Preferences.idDevice = id
                          :

                          //print(v4);
                          //print(id);

                      Preferences.servidor = _controllerServidor.text;
                      Preferences.dominio = _controllerDominio.text;
                      Preferences.usuario = _controllerUser.text;
                      Preferences.pass = _controllerPass.text;

                      if (Preferences.servidor == Environment.url_devl) {
                        Preferences.ambiente = 'devl';
                      } else {
                        if (Preferences.servidor == Environment.url_test) {
                          Preferences.ambiente = 'test';
                        } else {
                          if (Preferences.servidor == Environment.url_prod) {
                            Preferences.ambiente = 'prod';
                          }
                        }
                      }

                      Navigator.pushNamed(context, 'login');
                      print(Preferences.idDevice);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    disabledColor: Colors.grey,
                    elevation: 0,
                    color: Color(0xFF5A87C6),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      child: Text('Guardar',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _TextFieldServidor(TextEditingController _controllerServidor) {
    return TextFormField(
      controller: _controllerServidor,
      //autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //labelText: 'Servidor',
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

  TextFormField _TextFieldDominio(TextEditingController _controllerDominio) {
    return TextFormField(
      controller: _controllerDominio,
      //autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //labelText: 'Servidor',
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

  TextFormField _TextFieldUser(TextEditingController _controllerUser) {
    return TextFormField(
      controller: _controllerUser,
      //autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //labelText: 'Servidor',
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

  TextFormField _TextFieldContrasena(TextEditingController _controllerPass) {
    return TextFormField(
      controller: _controllerPass,
      //obscureText: true,
      //autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //labelText: 'Servidor',
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    var androidDeviceInfo = await deviceInfo.androidInfo;
    print(androidDeviceInfo.id);
    var id = androidDeviceInfo.id.substring(5, 9);
    Preferences.idDevice = id;
    Preferences.idDeviceFull = androidDeviceInfo.id;
    print(id);
    return androidDeviceInfo.id; // unique ID on Android
  }
}
