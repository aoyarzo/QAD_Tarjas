import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:http/http.dart' as http;
import 'package:qad_tarjas/models/models.dart';

class TipoHoraServices extends ChangeNotifier {
  List<TipoHoraModel> thora = [];

  Future getTipoHora() async {

    var url = Preferences.servidor;
    var browse = 'api/qracore/browses?browseId=urn:browse:mfg:xvbr011&page=1&pageSize=999999&pageAction=first';
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
      thora.add(new TipoHoraModel.fromJson(element));
    }).toList();
    notifyListeners();

    //notifyListeners();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      //print(decodeJson['data']);
      for (int i = 0; i < thora.length; i++) {
        //print(thora[i].codeMstrCodeDomain);
        //print(thora[i].codeMstrCodeCmmt);
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
