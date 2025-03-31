// To parse this JSON data, do
//
//     final toperacionLocalModel = toperacionLocalModelFromJson(jsonString);

import 'dart:convert';

ToperacionLocalModel toperacionLocalModelFromJson(String str) =>
    ToperacionLocalModel.fromJson(json.decode(str));

String toperacionLocalModelToJson(ToperacionLocalModel data) =>
    json.encode(data.toJson());

class ToperacionLocalModel {
  ToperacionLocalModel({
    required this.toperacionOp,
    required this.toperacionDominio,
    required this.toperacionFundo,
    required this.toperacionNombre,
    required this.toperacionManual,
    required this.toperacion_um,
  });

  String toperacionOp;
  String toperacionDominio;
  String toperacionFundo;
  String toperacionNombre;
  int toperacionManual;
  String toperacion_um;

  factory ToperacionLocalModel.fromJson(Map<String, dynamic> json) =>
      ToperacionLocalModel(
        toperacionOp: json["toperacion_op"],
        toperacionDominio: json["toperacion_dominio"],
        toperacionFundo: json["toperacion_fundo"],
        toperacionNombre: json["toperacion_nombre"],
        toperacionManual: json["toperacion_manual"],
        toperacion_um: json["toperacion_um"],
      );

  Map<String, dynamic> toJson() => {
        "toperacion_op": toperacionOp,
        "toperacion_dominio": toperacionDominio,
        "toperacion_fundo": toperacionFundo,
        "toperacion_nombre": toperacionNombre,
        "toperacion_manual": toperacionManual,
        "toperacion_um": toperacion_um,
      };
}
