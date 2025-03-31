import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qad_tarjas/models/models.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:http/http.dart' as http;

class EmpleadosServices extends ChangeNotifier {
  List<EmpleadoModel> empleados = [];

  Future getEmpleados() async {

    var url = Preferences.servidor;
    var browse = 'api/qracore/browses?browseId=urn:browse:mfg:xvbr007&page=1&pageSize=999999&pageAction=first';
    var username = Preferences.usuario;
    var password = Preferences.pass;

    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    var request = http.Request('GET', Uri.parse(url + browse));

    request.headers.addAll(<String, String>{'authorization': basicAuth});

    http.StreamedResponse response = await request.send();

    var responseString = await response.stream.bytesToString();

    //final decodedMap = json.decode(responseString);

    final Map<String, dynamic> decodeJson = jsonDecode(responseString);

    List<dynamic> data = decodeJson['data'];
    //print(decodeJson);
    //print(data);

    data.map((element) {
      empleados.add(new EmpleadoModel.fromJson(element));
    }).toList();
    notifyListeners();

    //notifyListeners();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      //print(decodeJson['data']);
      for (int i = 0; i < empleados.length; i++) {
        print(empleados[i].empMstrEmpChr02);
        print(empleados[i].empMstrEmpSort);
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
