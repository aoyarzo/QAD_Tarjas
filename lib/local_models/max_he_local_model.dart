// To parse this JSON data, do
//
//     final maxHeLocalModel = maxHeLocalModelFromJson(jsonString);

import 'dart:convert';

List<MaxHeLocalModel> maxHeLocalModelFromJson(String str) => List<MaxHeLocalModel>.from(json.decode(str).map((x) => MaxHeLocalModel.fromJson(x)));

String maxHeLocalModelToJson(List<MaxHeLocalModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaxHeLocalModel {
    MaxHeLocalModel({
        required this.tmaxheFundo,
        required this.tmaxheHoras,
    });

    String tmaxheFundo;
    int tmaxheHoras;

    factory MaxHeLocalModel.fromJson(Map<String, dynamic> json) => MaxHeLocalModel(
        tmaxheFundo: json["tmaxhe_fundo"],
        tmaxheHoras: json["tmaxhe_horas"],
    );

    Map<String, dynamic> toJson() => {
        "tmaxhe_fundo": tmaxheFundo,
        "tmaxhe_horas": tmaxheHoras,
    };
}
