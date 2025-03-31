import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:http/http.dart' as http;
import 'package:qad_tarjas/models/models.dart';

class TipoPagoServices extends ChangeNotifier {
  List<TipoPagoModel> tpago = [];

  Future getTipoPago() async {

    var url = Preferences.servidor;
    var filter = 'wc_mstr.wc__chr01,eq,' + Preferences.fundoCod + ',literal';
    var browse = 'api/qracore/browses?browseId=urn:browse:mfg:xvbr009&page=1&pageSize=999999&pageAction=first&filter=' + filter;
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
      tpago.add(new TipoPagoModel.fromJson(element));
    }).toList();
    notifyListeners();

    //notifyListeners();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      //print(decodeJson['data']);
      for (int i = 0; i < tpago.length; i++) {
        //print(tpago[i].wcMstrWcDomain);
        //print(tpago[i].localVariablesLocalVar00);
        print(tpago[i].wcMstrWcChr01);
        print(tpago[i].wcMstrWcDesc);
        //print(tpago[i].localVariablesLocalVar01);
        //print(tpago[i].wcMstrWcMchOp);
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
