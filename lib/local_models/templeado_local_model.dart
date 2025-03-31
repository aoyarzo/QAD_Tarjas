// To parse this JSON data, do
//
//     final templeadoLocalModel = templeadoLocalModelFromJson(jsonString);

import 'dart:convert';

TempleadoLocalModel templeadoLocalModelFromJson(String str) =>
    TempleadoLocalModel.fromJson(json.decode(str));

String templeadoLocalModelToJson(TempleadoLocalModel data) =>
    json.encode(data.toJson());

class TempleadoLocalModel {
  TempleadoLocalModel({
    required this.templeadoDominio,
    required this.templeadoCod,
    required this.templeadoFundo,
    required this.templeadoNombre,
    required this.templeadoRut,
    required this.templeadoActivo,
    required this.templeadoContratista,
  });

  String templeadoDominio;
  String templeadoFundo;
  String templeadoCod;
  String templeadoNombre;
  String templeadoRut;
  int templeadoActivo;
  int templeadoContratista;

  factory TempleadoLocalModel.fromJson(Map<String, dynamic> json) =>
      TempleadoLocalModel(
        templeadoDominio: json["templeado_dominio"],
        templeadoFundo: json["templeado_fundo"],
        templeadoCod: json["templeado_cod"],
        templeadoNombre: json["templeado_nombre"],
        templeadoRut: json["templeado_rut"],
        templeadoActivo: json["templeado_activo"],
        templeadoContratista: json["templeado_contratista"],
      );

  Map<String, dynamic> toJson() => {
        "templeado_dominio": templeadoDominio,
        "templeado_fundo": templeadoFundo,
        "templeado_cod": templeadoCod,
        "templeado_nombre": templeadoNombre,
        "templeado_rut": templeadoRut,
        "templeado_activo": templeadoActivo,
        "templeado_contratista": templeadoContratista,
      };
}
