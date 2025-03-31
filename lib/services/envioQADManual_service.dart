import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qad_tarjas/local_models/local_models.dart';
import 'package:qad_tarjas/providers/providers.dart';
import 'package:qad_tarjas/services/db_service.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:http/http.dart' as http;

class EnvioQADManualService extends ChangeNotifier {

  Future sendDataManualQAD(LocalListProvider cuartel, String dominio, String fundo, String fecha, 
  int linea, String empleado, String estado, double hextra, String hora, double jornada, 
  String operacion, String pago, bool procesado, double registro, double cantidad, LocalListProvider dbProvider) async {

  var url = Preferences.servidor;
  var browse = 'api/bdoc/lfewines/lfewinesapp/TarjaMstr';
  var username = Preferences.usuario;
  var password = Preferences.pass;

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

var request = http.Request('POST', Uri.parse(url + browse));

var requestTarja = '''{
    "domainCode": "$dominio",
    "tarjam_fundo": "$fundo",
    "tarjam_fecha": "$fecha",
    "tarjam_linea": $linea,
    "tarjam_empleado": "$empleado",
    "tarjam_estado": "$estado",
    "tarjam_hextra": $hextra,
    "tarjam_hora": "$hora",
    "tarjam_jornada": $jornada,
    "tarjam_operacion": "$operacion",
    "tarjam_pago": "$pago",
    "tarjam_procesado": $procesado,
    "tarjam_qty": $cantidad,
    "tarjam_registro": $registro,
    "_com_lfewines_lfewinesapp_TarjaDet": ''';


List<String> requestCuarteles_temp = [];

for(int i=0; i<cuartel.Detcuarteles.length; i++) {

  String dominio = cuartel.Detcuarteles[i].tdetcuartelDomain;
  String fundo = cuartel.Detcuarteles[i].tdetcuartelFundo;
  String fecha = cuartel.Detcuarteles[i].tdetcuartelFecha;
  int linea = cuartel.Detcuarteles[i].tdetcuartelLinea;
  String _cuartel = cuartel.Detcuarteles[i].tdetcuartelCuartel;
  String estado = cuartel.Detcuarteles[i].tdetcuartelEstado;
  double porcentaje = cuartel.Detcuarteles[i].tdetcuartelCantidad;

  var requestCuartel = '''{
        "domainCode": "$dominio",
        "tarjad_fundo": "$fundo",
        "tarjad_fecha": "$fecha",
        "tarjad_linea": "$linea",
        "tarjad_cuartel": "$_cuartel",
        "tarjad_estado": "$estado",
        "tarjad_porc": "$porcentaje"
      },''';

  requestCuarteles_temp.add(requestCuartel);
}

  String requestCuarteles = requestCuarteles_temp.join();
  List<String> c = requestCuarteles.split("");
  c.removeLast();
  requestCuarteles = c.join();
  requestCuarteles = '[' + requestCuarteles + ']';

var requestBody = '[' + requestTarja + requestCuarteles + '}]';

List<dynamic> requestBodyRaw = json.decode(requestBody);

String aa = json.encode(requestBodyRaw);

request.body = aa;
request.headers.addAll(<String, String>{'authorization': basicAuth});

http.StreamedResponse response = await request.send();

print(response.statusCode);
print(json.encode(requestBodyRaw));
//List<dynamic> aa = jsonDecode(requestBody);
//print(jsonDecode(requestBody));
//print(json.encode(aa));

if (response.statusCode == 201) {
  DBProvider.db.updateTarjaEstado(linea, 'Enviado');
  print('Datos Enviados Exitosamente');
}
else {
  print('Error en el envío');
  final tarjaError = new TtarjaErrorLocalModel(
          ttarjaDomain: dominio,
          ttarjaFundo: fundo,
          ttarjaFecha: fecha,
          ttarjaLinea: linea);
  dbProvider.tarjasNoEnviadas.add(tarjaError);        
  dbProvider.countErrorEnvioQAD += 1;
}

  }

}