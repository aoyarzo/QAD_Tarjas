// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserLocalModel userModelFromJson(String str) => UserLocalModel.fromJson(json.decode(str));

String userModelToJson(UserLocalModel data) => json.encode(data.toJson());

class UserLocalModel {
  UserLocalModel({
    required this.tusersId,
    required this.tusersNombre,
    required this.tusersPassword,
    required this.tusersAdmin,
  });

  String tusersId;
  String tusersNombre;
  String tusersPassword;
  int tusersAdmin;

  factory UserLocalModel.fromJson(Map<String, dynamic> json) => UserLocalModel(
        tusersId: json["tusers_id"],
        tusersNombre: json["tusers_nombre"],
        tusersPassword: json["tusers_password"],
        tusersAdmin: json["tusers_admin"],
      );

  Map<String, dynamic> toJson() => {
        "tusers_id": tusersId,
        "tusers_nombre": tusersNombre,
        "tusers_password": tusersPassword,
        "tusers_admin": tusersAdmin,
      };
}