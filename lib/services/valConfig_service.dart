import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:http/http.dart' as http;

class ValConfigServices extends ChangeNotifier {

  Future getValConfig(BuildContext context) async {
    
    var url = Preferences.servidor;

    if(url == 'https://lfewines-nonprod.qad.com/clouderp/devl/' || 
    url == 'https://lfewines-nonprod.qad.com/clouderp/test/' ||
    url == 'https://lfewines.qad.com/clouderp/') {

    var browse = 'api/qracore/browses?browseId=urn:browse:mfg:xvbr013&page=1&pageSize=999999&pageAction=first';
    var username = Preferences.usuario;
    var password = Preferences.pass;

    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    var request = http.Request('GET', Uri.parse(url + browse));

    request.headers.addAll(<String, String>{'authorization': basicAuth});

    http.StreamedResponse response = await request.send();

    String error = response.statusCode.toString();

    print(response.statusCode);

    Preferences.connectionStatus = error;

    if(error == '200') {
      _showDialogSuccess(context, error);
    } else {
      if(error == '404') {
        _showDialogError404(context, error);
      } else {
        if(error == '401') {
          _showDialogError401(context, error);
        } else {
          _showDialogError404(context, error);
        }
      }
    }
    
    } else {
      _showDialogError404(context, '404');
    }
  }

  Future<String?> _showDialogError404(BuildContext context, String error) async {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Column(
          children: [
            Icon(Icons.info_outlined, color: Colors.red, size: 34),
            SizedBox(height: 10),
            Text('Status: ' + error, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
          ],
        ),
        content: Text('Servidor No Encontrado', textAlign: TextAlign.center),
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

  Future<String?> _showDialogError401(BuildContext context, String error) async {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Column(
          children: [
            Icon(Icons.info_outlined, color: Colors.red, size: 34),
            SizedBox(height: 10),
            Text('Status: ' + error, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
          ],
        ),
        content: Text('Usuario y/o Contraseña Incorrecta', textAlign: TextAlign.center),
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

  Future<String?> _showDialogSuccess(BuildContext context, String error) async {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Column(
          children: [
            Icon(Icons.check_box_outlined, color: Colors.green, size: 34),
            SizedBox(height: 10),
            Text('Status: ' + error, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
          ],
        ),
        content: Text('Conexión Exitosa', textAlign: TextAlign.center),
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

}