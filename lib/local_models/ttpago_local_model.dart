// To parse this JSON data, do
//
//     final ttpagoLocalModel = ttpagoLocalModelFromJson(jsonString);

import 'dart:convert';

TtpagoLocalModel ttpagoLocalModelFromJson(String str) =>
    TtpagoLocalModel.fromJson(json.decode(str));

String ttpagoLocalModelToJson(TtpagoLocalModel data) =>
    json.encode(data.toJson());

class TtpagoLocalModel {
  TtpagoLocalModel({
    required this.tpagoCod,
    required this.tpagoDominio,
    required this.tpagoFundo,
    required this.tpagoNombre,
    this.tpagoTarifa,
    required this.tpagoTrato,
  });

  String tpagoCod;
  String tpagoDominio;
  String tpagoFundo;
  String tpagoNombre;
  dynamic tpagoTarifa;
  int tpagoTrato;

  factory TtpagoLocalModel.fromJson(Map<String, dynamic> json) =>
      TtpagoLocalModel(
        tpagoCod: json["tpago_cod"],
        tpagoDominio: json["tpago_dominio"],
        tpagoFundo: json["tpago_fundo"],
        tpagoNombre: json["tpago_nombre"],
        tpagoTarifa: json["tpago_tarifa"],
        tpagoTrato: json["tpago_trato"]
      );

  Map<String, dynamic> toJson() => {
        "tpago_cod": tpagoCod,
        "tpago_dominio": tpagoDominio,
        "tpago_fundo": tpagoFundo,
        "tpago_nombre": tpagoNombre,
        "tpago_tarifa": tpagoTarifa,
        "tpago_trato": tpagoTrato,
      };
}
