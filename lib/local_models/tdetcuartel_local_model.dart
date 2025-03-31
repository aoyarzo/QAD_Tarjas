// To parse this JSON data, do
//
//     final tDetCuartelLocalModel = tDetCuartelLocalModelFromJson(jsonString);

import 'dart:convert';

TDetCuartelLocalModel tDetCuartelLocalModelFromJson(String str) =>
    TDetCuartelLocalModel.fromJson(json.decode(str));

String tDetCuartelLocalModelToJson(TDetCuartelLocalModel data) =>
    json.encode(data.toJson());

class TDetCuartelLocalModel {
  TDetCuartelLocalModel({
    required this.tdetcuartelLinea,
    required this.tdetcuartelDomain,
    required this.tdetcuartelFundo,
    required this.tdetcuartelFundoNombre,
    required this.tdetcuartelFecha,
    required this.tdetcuartelCuartel,
    required this.tdetcuartelCuartelNombre,
    required this.tdetcuartelCantidad,
    required this.tdetcuartelEstado,
  });

  int tdetcuartelLinea;
  String tdetcuartelDomain;
  String tdetcuartelFundo;
  String tdetcuartelFundoNombre;
  String tdetcuartelFecha;
  String tdetcuartelCuartel;
  String tdetcuartelCuartelNombre;
  double tdetcuartelCantidad;
  String tdetcuartelEstado;

  factory TDetCuartelLocalModel.fromJson(Map<String, dynamic> json) =>
      TDetCuartelLocalModel(
        tdetcuartelLinea: json["tdetcuartel_linea"],
        tdetcuartelDomain: json["tdetcuartel_domain"],
        tdetcuartelFundo: json["tdetcuartel_fundo"],
        tdetcuartelFundoNombre: json["tdetcuartel_fundo_nombre"],
        tdetcuartelFecha: json["tdetcuartel_fecha"],
        tdetcuartelCuartel: json["tdetcuartel_cuartel"],
        tdetcuartelCuartelNombre: json["tdetcuartel_cuartel_nombre"],
        tdetcuartelCantidad: json["tdetcuartel_cantidad"].toDouble(),
        tdetcuartelEstado: json["tdetcuartel_estado"],
      );

  Map<String, dynamic> toJson() => {
        "tdetcuartel_linea": tdetcuartelLinea,
        "tdetcuartel_domain": tdetcuartelDomain,
        "tdetcuartel_fundo": tdetcuartelFundo,
        "tdetcuartel_fundo_nombre": tdetcuartelFundoNombre,
        "tdetcuartel_fecha": tdetcuartelFecha,
        "tdetcuartel_cuartel": tdetcuartelCuartel,
        "tdetcuartel_cuartel_nombre": tdetcuartelCuartelNombre,
        "tdetcuartel_cantidad": tdetcuartelCantidad,
        "tdetcuartel_estado": tdetcuartelEstado,
      };
}
