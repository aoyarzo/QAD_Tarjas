// To parse this JSON data, do
//
//     final ttarjaLocalModel = ttarjaLocalModelFromJson(jsonString);

import 'dart:convert';

TtarjaErrorLocalModel ttarjaErrorLocalModelFromJson(String str) =>
    TtarjaErrorLocalModel.fromJson(json.decode(str));

String ttarjaErrorLocalModelToJson(TtarjaErrorLocalModel data) =>
    json.encode(data.toJson());

class TtarjaErrorLocalModel {
  TtarjaErrorLocalModel({
    required this.ttarjaDomain,
    required this.ttarjaFundo,
    required this.ttarjaFecha,
    required this.ttarjaLinea,
    
  });

  String ttarjaDomain;
  String ttarjaFundo;
  String ttarjaFecha;
  int ttarjaLinea;
 
  factory TtarjaErrorLocalModel.fromJson(Map<String, dynamic> json) =>
      TtarjaErrorLocalModel(
        ttarjaDomain: json["ttarja_domain"],
        ttarjaFundo: json["ttarja_fundo"],  
        ttarjaFecha: json["ttarja_fecha"],
        ttarjaLinea: json["ttarja_linea"],
        
      );

  Map<String, dynamic> toJson() => {
        "ttarja_domain": ttarjaDomain,
        "ttarja_fundo": ttarjaFundo,
        "ttarja_fecha": ttarjaFecha,
        "ttarja_linea": ttarjaLinea,
       
      };
}
