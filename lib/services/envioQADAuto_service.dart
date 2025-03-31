import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qad_tarjas/local_models/local_models.dart';
import 'package:qad_tarjas/providers/providers.dart';
import 'package:qad_tarjas/services/services.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:http/http.dart' as http;

class EnvioQADAutoService extends ChangeNotifier {
  Future sendDataAutoQAD(
      String dominio,
      String fundo,
      String fecha,
      int linea,
      String empleado,
      String estado,
      double hextra,
      String hora,
      double jornada,
      String operacion,
      String pago,
      double cantidad,
      bool procesado,
      double registro,
      LocalListProvider dbProvider) async {
    
    var url = Preferences.servidor;
    var browse = 'api/bdoc/lfewines/lfewinesapp/TarjaMstr';
    var username = Preferences.usuario;
    var password = Preferences.pass;
  
    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    var request = http.Request('POST', Uri.parse(url + browse));
    request.body = json.encode([
      {
        "domainCode": dominio,
        "tarjam_fundo": fundo,
        "tarjam_fecha": fecha,
        "tarjam_linea": linea,
        "tarjam_empleado": empleado,
        "tarjam_estado": estado,
        "tarjam_hextra": hextra,
        "tarjam_hora": hora,
        "tarjam_jornada": jornada,
        "tarjam_operacion": operacion,
        "tarjam_pago": pago,
        "tarjam_procesado": procesado,
        "tarjam_qty": cantidad,
        "tarjam_registro": registro
      }
    ]);

    request.headers.addAll(<String, String>{'authorization': basicAuth});

    http.StreamedResponse response = await request.send();

    print(response.statusCode);

    if (response.statusCode == 201) {
      DBProvider.db.updateTarjaEstado(linea, 'Enviado');
      print('Datos Enviados Exitosamente');
    } else {
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
