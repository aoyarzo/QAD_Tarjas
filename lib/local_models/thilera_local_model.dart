// To parse this JSON data, do
//
//     final tfundoLocalModel = tfundoLocalModelFromJson(jsonString);

import 'dart:convert';

ThileraLocalModel ThileraLocalModelFromJson(String str) =>
    ThileraLocalModel.fromJson(json.decode(str));

String ThileraLocalModelToJson(ThileraLocalModel data) =>
    json.encode(data.toJson());

class ThileraLocalModel {
  ThileraLocalModel({
    required this.thileraFundo,
    required this.thileraCuartel,
    required this.thileraCodigo,
    required this.thileraNombre,
    required this.thileraCantidad,
    required this.thileraSelected,

  });

  String thileraFundo;
  String thileraCuartel;
  String thileraCodigo;
  String thileraNombre;
  int thileraCantidad;
  int thileraSelected;

  factory ThileraLocalModel.fromJson(Map<String, dynamic> json) =>
      ThileraLocalModel(
        thileraFundo: json["thilera_fundo"],
        thileraCuartel: json["thilera_cuartel"],
        thileraCodigo: json["thilera_codigo"],
        thileraNombre: json["thilera_nombre"],
        thileraCantidad: json["thilera_cantidad"],
        thileraSelected: json["thilera_selected"],
      );

  Map<String, dynamic> toJson() => {
        "thilera_fundo": thileraFundo,
        "thilera_cuartel": thileraCuartel,
        "thilera_codigo": thileraCodigo,
        "thilera_nombre": thileraNombre,
        "thilera_cantidad": thileraCantidad,
        "thilera_selected": thileraSelected,
      };
}
