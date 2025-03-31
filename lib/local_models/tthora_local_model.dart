// To parse this JSON data, do
//
//     final tthoraLocalModel = tthoraLocalModelFromJson(jsonString);

import 'dart:convert';

TthoraLocalModel tthoraLocalModelFromJson(String str) => TthoraLocalModel.fromJson(json.decode(str));

String tthoraLocalModelToJson(TthoraLocalModel data) => json.encode(data.toJson());

class TthoraLocalModel {
    TthoraLocalModel({
        required this.thoraCod,
        required this.thoraDominio,
        required this.thoraNombre,
    });

    String thoraCod;
    String thoraDominio;
    String thoraNombre;

    factory TthoraLocalModel.fromJson(Map<String, dynamic> json) => TthoraLocalModel(
        thoraCod: json["thora_cod"],
        thoraDominio: json["thora_dominio"],
        thoraNombre: json["thora_nombre"],
    );

    Map<String, dynamic> toJson() => {
        "thora_cod": thoraCod,
        "thora_dominio": thoraDominio,
        "thora_nombre": thoraNombre,
    };
}
