// To parse this JSON data, do
//
//     final ttarjaLocalModel = ttarjaLocalModelFromJson(jsonString);

import 'dart:convert';

TtarjaLocalModel ttarjaLocalModelFromJson(String str) =>
    TtarjaLocalModel.fromJson(json.decode(str));

String ttarjaLocalModelToJson(TtarjaLocalModel data) =>
    json.encode(data.toJson());

class TtarjaLocalModel {
  TtarjaLocalModel({
    required this.ttarjaDomain,
    required this.ttarjaFundo,
    required this.ttarjaFundoNombre,
    required this.ttarjaFecha,
    required this.ttarjaLinea,
    required this.ttarjaEmpleado,
    required this.ttarjaEmpleadoNombre,
    required this.ttarjaEstado,
    required this.ttarjaHextra,
    required this.ttarjaHora,
    required this.ttarjaHoraNombre,
    required this.ttarjaJornada,
    required this.ttarjaOperacion,
    required this.ttarjaOperacionNombre,
    required this.ttarjaOperacionUM,
    required this.ttarjaPago,
    required this.ttarjaPagoNombre,
    required this.ttarjaProcesado,
    required this.ttarjaRegistro,
    required this.ttarjaOpManual,
    required this.ttarjaCantidad,
    required this.ttarjaServidor,
    required this.ttarjaSelected,
  });

  String ttarjaDomain;
  String ttarjaFundo;
  String ttarjaFundoNombre;
  String ttarjaFecha;
  int ttarjaLinea;
  String ttarjaEmpleado;
  String ttarjaEmpleadoNombre;
  String ttarjaEstado;
  double ttarjaHextra;
  String ttarjaHora;
  String ttarjaHoraNombre;
  double ttarjaJornada;
  String ttarjaOperacion;
  String ttarjaOperacionNombre;
  String ttarjaOperacionUM;
  String ttarjaPago;
  String ttarjaPagoNombre;
  int ttarjaProcesado;
  double ttarjaRegistro;
  int ttarjaOpManual;
  double ttarjaCantidad;
  String ttarjaServidor;
  int ttarjaSelected;

  factory TtarjaLocalModel.fromJson(Map<String, dynamic> json) =>
      TtarjaLocalModel(
        ttarjaDomain: json["ttarja_domain"],
        ttarjaFundo: json["ttarja_fundo"],
        ttarjaFundoNombre: json["ttarja_fundo_nombre"],
        ttarjaFecha: json["ttarja_fecha"],
        ttarjaLinea: json["ttarja_linea"],
        ttarjaEmpleado: json["ttarja_empleado"],
        ttarjaEmpleadoNombre: json["ttarja_empleado_nombre"],
        ttarjaEstado: json["ttarja_estado"],
        ttarjaHextra: json["ttarja_hextra"],
        ttarjaHora: json["ttarja_hora"],
        ttarjaHoraNombre: json["ttarja_hora_nombre"],
        ttarjaJornada: json["ttarja_jornada"],
        ttarjaOperacion: json["ttarja_operacion"],
        ttarjaOperacionNombre: json["ttarja_operacion_nombre"],
        ttarjaOperacionUM: json["ttarja_operacion_um"],
        ttarjaPago: json["ttarja_pago"],
        ttarjaPagoNombre: json["ttarja_pago_nombre"],
        ttarjaRegistro: json["ttarja_registro"],
        ttarjaProcesado: json["ttarja_procesado"],
        ttarjaOpManual: json["ttarja_opmanual"],
        ttarjaCantidad: json["ttarja_cantidad"],
        ttarjaServidor: json["ttarja_servidor"],
        ttarjaSelected: json["ttarja_selected"],
      );

  Map<String, dynamic> toJson() => {
        "ttarja_domain": ttarjaDomain,
        "ttarja_fundo": ttarjaFundo,
        "ttarja_fundo_nombre": ttarjaFundoNombre,
        "ttarja_fecha": ttarjaFecha,
        "ttarja_linea": ttarjaLinea,
        "ttarja_empleado": ttarjaEmpleado,
        "ttarja_empleado_nombre": ttarjaEmpleadoNombre,
        "ttarja_estado": ttarjaEstado,
        "ttarja_hextra": ttarjaHextra,
        "ttarja_hora": ttarjaHora,
        "ttarja_hora_nombre": ttarjaHoraNombre,
        "ttarja_jornada": ttarjaJornada,
        "ttarja_operacion": ttarjaOperacion,
        "ttarja_operacion_nombrer": ttarjaOperacionNombre,
        "ttarja_operacion_um": ttarjaOperacionUM,
        "ttarja_pago": ttarjaPago,
        "ttarja_pago_nombre": ttarjaPagoNombre,
        "ttarja_procesado": ttarjaProcesado,
        "ttarja_registro": ttarjaRegistro,
        "ttarja_opmanual": ttarjaOpManual,
        "ttarja_cantidad": ttarjaCantidad,
        "ttarja_servidor": ttarjaServidor,
        "ttarja_selected": ttarjaSelected,
      };
}
