// To parse this JSON data, do
//
//     final operacionModel = operacionModelFromJson(jsonString);

import 'dart:convert';

List<OperacionModel> operacionModelFromJson(String str) => List<OperacionModel>.from(json.decode(str).map((x) => OperacionModel.fromJson(x)));

String operacionModelToJson(List<OperacionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OperacionModel {
    OperacionModel({
        required this.xxawoMstrXxawoDomain,
        required this.xxawoMstrXxawoSite,
        required this.xxawoMstrXxawoNbr,
        required this.xxawoMstrXxawoDesc,
        required this.xxawoMstrXxawoUm,
        this.xxawoMstrXxawoStatus,
        this.xxawoMstrXxawoPart,
        this.xxawoMstrXxawoType,
        this.localVariablesLocalVar00,
        required this.xxawoMstrXxawoShare,
        this.localVariablesBrowseRowOrderIndex,
        this.localVariablesUniqueId,
        this.localVariablesDecorationCell,
        this.xxawoMstrOidXXxawoMstr,
        this.xxawoMstrXxawoMstrRowid,
    });

    String xxawoMstrXxawoDomain;
    String xxawoMstrXxawoSite;
    int xxawoMstrXxawoNbr;
    String xxawoMstrXxawoDesc;
    String xxawoMstrXxawoUm;
    dynamic xxawoMstrXxawoStatus;
    dynamic xxawoMstrXxawoPart;
    dynamic xxawoMstrXxawoType;
    dynamic localVariablesLocalVar00;
    bool xxawoMstrXxawoShare;
    dynamic localVariablesBrowseRowOrderIndex;
    dynamic localVariablesUniqueId;
    dynamic localVariablesDecorationCell;
    dynamic xxawoMstrOidXXxawoMstr;
    dynamic xxawoMstrXxawoMstrRowid;

    factory OperacionModel.fromJson(Map<String, dynamic> json) => OperacionModel(
        xxawoMstrXxawoDomain: json["xxawo_mstr.xxawo_domain"],
        xxawoMstrXxawoSite: json["xxawo_mstr.xxawo_site"],
        xxawoMstrXxawoNbr: json["xxawo_mstr.xxawo_nbr"],
        xxawoMstrXxawoDesc: json["xxawo_mstr.xxawo_desc"],
        xxawoMstrXxawoUm: json["xxawo_mstr.xxawo_um"],
        xxawoMstrXxawoStatus: json["xxawo_mstr.xxawo_status"],
        xxawoMstrXxawoPart: json["xxawo_mstr.xxawo_part"],
        xxawoMstrXxawoType: json["xxawo_mstr.xxawo_type"],
        localVariablesLocalVar00: json["local_variables.local-var00"],
        xxawoMstrXxawoShare: json["xxawo_mstr.xxawo_share"],
        localVariablesBrowseRowOrderIndex: json["local_variables.BrowseRowOrderIndex"],
        localVariablesUniqueId: json["local_variables.uniqueId"],
        localVariablesDecorationCell: json["local_variables.decoration_cell"],
        xxawoMstrOidXXxawoMstr: json["xxawo_mstr.oid_X_xxawo_mstr"],
        xxawoMstrXxawoMstrRowid: json["xxawo_mstr.xxawo_mstr_rowid"],
    );

    Map<String, dynamic> toJson() => {
        "xxawo_mstr.xxawo_domain": xxawoMstrXxawoDomain,
        "xxawo_mstr.xxawo_site": xxawoMstrXxawoSite,
        "xxawo_mstr.xxawo_nbr": xxawoMstrXxawoNbr,
        "xxawo_mstr.xxawo_desc": xxawoMstrXxawoDesc,
        "xxawo_mstr.xxawo_um": xxawoMstrXxawoUm,
        "xxawo_mstr.xxawo_status": xxawoMstrXxawoStatus,
        "xxawo_mstr.xxawo_part": xxawoMstrXxawoPart,
        "xxawo_mstr.xxawo_type": xxawoMstrXxawoType,
        "local_variables.local-var00": localVariablesLocalVar00,
        "xxawo_mstr.xxawo_share": xxawoMstrXxawoShare,
        "local_variables.BrowseRowOrderIndex": localVariablesBrowseRowOrderIndex,
        "local_variables.uniqueId": localVariablesUniqueId,
        "local_variables.decoration_cell": localVariablesDecorationCell,
        "xxawo_mstr.oid_X_xxawo_mstr": xxawoMstrOidXXxawoMstr,
        "xxawo_mstr.xxawo_mstr_rowid": xxawoMstrXxawoMstrRowid,
    };
}
