import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:qad_tarjas/models/models.dart';
import 'package:http/http.dart' as http;


class CuartelesServices extends ChangeNotifier {
  List<CuartelModel> cuarteles = [];

  Future getCuarteles() async {

    var url = Preferences.servidor;
    var filter = 'xxawo_mstr.xxawo_site,eq,' + Preferences.fundoCod + ',literal';
    var browse = 'api/qracore/browses?browseId=urn:browse:mfg:xvbr014&page=1&pageSize=999999&pageAction=first&filter=' + filter;
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
    //print(response.statusCode);
    //print(data);

    data.map((element) {
      cuarteles.add(new CuartelModel.fromJson(element));
    }).toList();
    notifyListeners();

    //notifyListeners();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      //print(decodeJson['data']);
      for (int i = 0; i < cuarteles.length; i++) {
        print(cuarteles[i].xxawoMstrXxawoSite);
        print(cuarteles[i].locMstrLocDesc);
        
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
