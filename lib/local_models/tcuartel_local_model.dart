// To parse this JSON data, do
//
//     final tcuartelLocalModel = tcuartelLocalModelFromJson(jsonString);

import 'dart:convert';

TcuartelLocalModel tcuartelLocalModelFromJson(String str) =>
    TcuartelLocalModel.fromJson(json.decode(str));

String tcuartelLocalModelToJson(TcuartelLocalModel data) =>
    json.encode(data.toJson());

class TcuartelLocalModel {
  TcuartelLocalModel({
    required this.tcuartelOp,
    required this.tcuartelDominio,
    required this.tcuartelFundo,
    required this.tcuartelCuartel,
    required this.tcuartelNombre,
    required this.tcuartelSelected,
    required this.tcuartelHilera,
    required this.tcuartelCantidad,
    required this.tcuartelCantPlantas,
    required this.tcuartelValid,
  });

  String tcuartelOp;
  String tcuartelDominio;
  String tcuartelFundo;
  String tcuartelCuartel;
  String tcuartelNombre;
  int  tcuartelSelected;
  int tcuartelHilera;
  double tcuartelCantidad;
  double tcuartelCantPlantas;
  int tcuartelValid;

  factory TcuartelLocalModel.fromJson(Map<String, dynamic> json) =>
      TcuartelLocalModel(
        tcuartelOp: json["tcuartel_op"],
        tcuartelDominio: json["tcuartel_dominio"],
        tcuartelFundo: json["tcuartel_fundo"],
        tcuartelCuartel: json["tcuartel_cuartel"],
        tcuartelNombre: json["tcuartel_nombre"],
        tcuartelSelected: json["tcuartel_selected"],
        tcuartelHilera: json["tcuartel_hilera"],
        tcuartelCantidad: json["tcuartel_cantidad"],
        tcuartelCantPlantas: json["tcuartel_cant_plantas"].toDouble(),
        tcuartelValid: json["tcuartel_valid"],
      );

  Map<String, dynamic> toJson() => {
        "tcuartel_op": tcuartelOp,
        "tcuartel_dominio": tcuartelDominio,
        "tcuartel_fundo": tcuartelFundo,
        "tcuartel_cuartel": tcuartelCuartel,
        "tcuartel_nombre": tcuartelNombre,
        "tcuartel_selected": tcuartelSelected,
        "tcuartel_hilera": tcuartelHilera,
        "tcuartel_cantidad": tcuartelCantidad,
        "tcuartel_cant_plantas": tcuartelCantPlantas,
        "tcuartel_valid": tcuartelValid,
      };
}
