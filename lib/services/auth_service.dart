import 'package:flutter/material.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthUserService extends ChangeNotifier {

  Future AuthUser(String user, String pass, BuildContext context) async {

    var url = Preferences.servidor;
    var browse = 'login?username=$user&password=$pass';
    var username = Preferences.usuario;
    var password = Preferences.pass;
    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    var request = http.Request('POST', Uri.parse(url + browse));
    request.body = json.encode([
  { }
    ]);
    
    request.headers.addAll(<String, String>{'authorization': basicAuth});

    http.StreamedResponse response = await request.send();


    print('response.statusCode:' + response.statusCode.toString());

    print(response.headers['location']);

    String location = response.headers['location'].toString();

    String errorAuth = location.substring(location.length - 17);

    print(location);
    print(errorAuth);

    if(errorAuth == 'login.jsp?error=1') {
      showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('Usuario y/o Contraseña Incorrecta', textAlign: TextAlign.center),
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
    else {
      Preferences.user = user;
      Preferences.inicio = 'login';
      Navigator.pushNamed(context, 'home');
    }

  }
   
}