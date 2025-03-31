// To parse this JSON data, do
//
//     final hileraModel = hileraModelFromJson(jsonString);

import 'dart:convert';

List<HileraModel> hileraModelFromJson(String str) => List<HileraModel>.from(json.decode(str).map((x) => HileraModel.fromJson(x)));

String hileraModelToJson(List<HileraModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HileraModel {
    HileraModel({
        required this.xxhileraMstrXxhileraSite,
        required this.xxhileraMstrXxhileraLoc,
        required this.xxhileraMstrXxhileraHilera,
        required this.xxhileraMstrXxhileraDesc,
        required this.xxhileraMstrXxhileraCant,
        this.localVariablesBrowseRowOrderIndex,
        this.localVariablesUniqueId,
        this.localVariablesDecorationCell,
        this.xxhileraMstrOidXXxhileraMstr,
        this.xxhileraMstrXxhileraMstrRowid,
    });

    String xxhileraMstrXxhileraSite;
    String xxhileraMstrXxhileraLoc;
    String xxhileraMstrXxhileraHilera;
    String xxhileraMstrXxhileraDesc;
    int xxhileraMstrXxhileraCant;
    dynamic localVariablesBrowseRowOrderIndex;
    dynamic localVariablesUniqueId;
    dynamic localVariablesDecorationCell;
    dynamic xxhileraMstrOidXXxhileraMstr;
    dynamic xxhileraMstrXxhileraMstrRowid;

    factory HileraModel.fromJson(Map<String, dynamic> json) => HileraModel(
        xxhileraMstrXxhileraSite: json["xxhilera_mstr.xxhilera_site"],
        xxhileraMstrXxhileraLoc: json["xxhilera_mstr.xxhilera_loc"],
        xxhileraMstrXxhileraHilera: json["xxhilera_mstr.xxhilera_hilera"],
        xxhileraMstrXxhileraDesc: json["xxhilera_mstr.xxhilera_desc"],
        xxhileraMstrXxhileraCant: json["xxhilera_mstr.xxhilera_cant"],
        localVariablesBrowseRowOrderIndex: json["local_variables.BrowseRowOrderIndex"],
        localVariablesUniqueId: json["local_variables.uniqueId"],
        localVariablesDecorationCell: json["local_variables.decoration_cell"],
        xxhileraMstrOidXXxhileraMstr: json["xxhilera_mstr.oid_X_xxhilera_mstr"],
        xxhileraMstrXxhileraMstrRowid: json["xxhilera_mstr.xxhilera_mstr_rowid"],
    );

    Map<String, dynamic> toJson() => {
        "xxhilera_mstr.xxhilera_site": xxhileraMstrXxhileraSite,
        "xxhilera_mstr.xxhilera_loc": xxhileraMstrXxhileraLoc,
        "xxhilera_mstr.xxhilera_hilera": xxhileraMstrXxhileraHilera,
        "xxhilera_mstr.xxhilera_desc": xxhileraMstrXxhileraDesc,
        "xxhilera_mstr.xxhilera_cant": xxhileraMstrXxhileraCant,
        "local_variables.BrowseRowOrderIndex": localVariablesBrowseRowOrderIndex,
        "local_variables.uniqueId": localVariablesUniqueId,
        "local_variables.decoration_cell": localVariablesDecorationCell,
        "xxhilera_mstr.oid_X_xxhilera_mstr": xxhileraMstrOidXXxhileraMstr,
        "xxhilera_mstr.xxhilera_mstr_rowid": xxhileraMstrXxhileraMstrRowid,
    };
}
