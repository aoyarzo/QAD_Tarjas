import 'package:flutter/material.dart';
import 'package:qad_tarjas/providers/providers.dart';
import 'package:qad_tarjas/services/services.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controllerUsuario = TextEditingController();

  final _controllerContrasena = TextEditingController();

  //final _controllerFundo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<LocalListProvider>(context);
    //final fundosApi = Provider.of<FundosServices>(context);
    final authUser = Provider.of<AuthUserService>(context);

    return PopScope(
      //onWillPop: () async => exit(0),
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Color(0xFF5A87C6),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 150.0,
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width / 1.2,
                          padding: const EdgeInsets.only(
                              left: 35, right: 35, top: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10 // changes position of shadow
                                  ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 90.0,
                                width: 90.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/logo.png'),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'QAD Tarjas',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF5A87C6),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '¡Bienvenido!',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, 'configuracion');
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Configuración',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF5A87C6)),
                                      ),
                                      Icon(Icons.settings,
                                          color: Color(0xFF5A87C6))
                                    ],
                                  )),
                              SizedBox(height: 10),
                              Preferences.connectionStatus == '200'
                                  ? TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, 'configuracionFundo');
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Fundo',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF5A87C6)),
                                          ),
                                          SizedBox(width: 5),
                                          Icon(Icons.manage_search_outlined,
                                              color: Color(0xFF5A87C6))
                                        ],
                                      ))
                                  : Text(''),
                              //SizedBox(height: 5),
                              Preferences.connectionStatus == '200'
                                  ? Text(
                                      Preferences.fundo,
                                      style: TextStyle(fontSize: 12),
                                    )
                                  : Text(''),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: TextField(
                                  controller: _controllerUsuario,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    hintText: 'Usuario',
                                  ),
                                  //keyboardType: TextInputType.emailAddress
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: TextField(
                                  controller: _controllerContrasena,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    hintText: 'Contraseña',
                                  ),
                                  obscureText: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.0),
                                    color: Color(0xFF5A87C6),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                                            shadowColor: Colors.transparent,
                                          ),
                                          onPressed: () async {
                                            dbProvider.isLoadingLogin = true;

                                            print(Preferences.connectionStatus);
                                            print(Preferences.fundo.isEmpty);

                                            if (Preferences.connectionStatus ==
                                                '200') {
                                              if (Preferences.fundo.isEmpty) {
                                                _showDialogErrorFundo(context);
                                              } else {
                                                await authUser.AuthUser(
                                                    _controllerUsuario.text,
                                                    _controllerContrasena.text,
                                                    context);
                                              }
                                            } else {
                                              _showDialogErrorConnection(
                                                  context);
                                            }

                                            dbProvider.isLoadingLogin = false;
                                    
                                          },
                                          child: dbProvider.isLoadingLogin
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CircularProgressIndicator(
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text('Espere...',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                )
                                              : Text('Ingresar',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 60.0,
          child: Center(
            child: Text(
              'Versión: 20231219',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<String?> showDialogErrorLogin(BuildContext context) async {
  return showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('Usuario y/o Contraseña Incorrecta',
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

TextFormField textFieldFundo(
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
      //labelText: 'Fundo',
      //errorText: _validateFundo ? 'Campo Vacío' : null,
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

Future<String?> _showDialogErrorConnection(BuildContext context) async {
  return showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Column(
        children: [
          Icon(Icons.info_outlined, color: Colors.red, size: 34),
          SizedBox(height: 10),
          Text('Error: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
        ],
      ),
      content: Text(
          'Configuración del Servidor no fue realizada Correctamente.',
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

Future<String?> _showDialogErrorFundo(BuildContext context) async {
  return showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Column(
        children: [
          Icon(Icons.info_outlined, color: Colors.red, size: 34),
          SizedBox(height: 10),
          Text('Error: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
        ],
      ),
      content: Text('Debe seleccionar un Fundo', textAlign: TextAlign.center),
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


