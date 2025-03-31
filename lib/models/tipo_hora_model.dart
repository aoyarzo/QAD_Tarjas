// To parse this JSON data, do
//
//     final tipoHoraModel = tipoHoraModelFromJson(jsonString);

import 'dart:convert';

TipoHoraModel tipoHoraModelFromJson(String str) =>
    TipoHoraModel.fromJson(json.decode(str));

String tipoHoraModelToJson(TipoHoraModel data) => json.encode(data.toJson());

class TipoHoraModel {
  TipoHoraModel({
    required this.codeMstrCodeDomain,
    required this.codeMstrCodeValue,
    required this.codeMstrCodeCmmt,
    this.localVariablesBrowseRowOrderIndex,
    this.localVariablesUniqueId,
    this.localVariablesDecorationCell,
    this.codeMstrOidXCodeMstr,
    this.codeMstrCodeMstrRowid,
  });

  String codeMstrCodeDomain;
  String codeMstrCodeValue;
  String codeMstrCodeCmmt;
  dynamic localVariablesBrowseRowOrderIndex;
  dynamic localVariablesUniqueId;
  dynamic localVariablesDecorationCell;
  dynamic codeMstrOidXCodeMstr;
  dynamic codeMstrCodeMstrRowid;

  factory TipoHoraModel.fromJson(Map<String, dynamic> json) => TipoHoraModel(
        codeMstrCodeDomain: json["code_mstr.code_domain"],
        codeMstrCodeValue: json["code_mstr.code_value"],
        codeMstrCodeCmmt: json["code_mstr.code_cmmt"],
        localVariablesBrowseRowOrderIndex:
            json["local_variables.BrowseRowOrderIndex"],
        localVariablesUniqueId: json["local_variables.uniqueId"],
        localVariablesDecorationCell: json["local_variables.decoration_cell"],
        codeMstrOidXCodeMstr: json["code_mstr.oid_X_code_mstr"],
        codeMstrCodeMstrRowid: json["code_mstr.code_mstr_rowid"],
      );

  Map<String, dynamic> toJson() => {
        "code_mstr.code_domain": codeMstrCodeDomain,
        "code_mstr.code_value": codeMstrCodeValue,
        "code_mstr.code_cmmt": codeMstrCodeCmmt,
        "local_variables.BrowseRowOrderIndex":
            localVariablesBrowseRowOrderIndex,
        "local_variables.uniqueId": localVariablesUniqueId,
        "local_variables.decoration_cell": localVariablesDecorationCell,
        "code_mstr.oid_X_code_mstr": codeMstrOidXCodeMstr,
        "code_mstr.code_mstr_rowid": codeMstrCodeMstrRowid,
      };
}
