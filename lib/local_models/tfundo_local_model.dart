// To parse this JSON data, do
//
//     final tfundoLocalModel = tfundoLocalModelFromJson(jsonString);

import 'dart:convert';

TfundoLocalModel tfundoLocalModelFromJson(String str) =>
    TfundoLocalModel.fromJson(json.decode(str));

String tfundoLocalModelToJson(TfundoLocalModel data) =>
    json.encode(data.toJson());

class TfundoLocalModel {
  TfundoLocalModel({
    required this.tfundoCod,
    required this.tfundoDominio,
    required this.tfundoNombre,
  });

  String tfundoCod;
  String tfundoDominio;
  String tfundoNombre;

  factory TfundoLocalModel.fromJson(Map<String, dynamic> json) =>
      TfundoLocalModel(
        tfundoCod: json["tfundo_cod"],
        tfundoDominio: json["tfundo_dominio"],
        tfundoNombre: json["tfundo_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "tfundo_cod": tfundoCod,
        "tfundo_dominio": tfundoDominio,
        "tfundo_nombre": tfundoNombre,
      };
}
