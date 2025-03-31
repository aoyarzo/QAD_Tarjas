// To parse this JSON data, do
//
//     final fundoModel = fundoModelFromJson(jsonString);

import 'dart:convert';

FundoModel fundoModelFromJson(String str) =>
    FundoModel.fromJson(json.decode(str));

String fundoModelToJson(FundoModel data) => json.encode(data.toJson());

class FundoModel {
  FundoModel({
    required this.siMstrSiDomain,
    required this.siMstrSiSite,
    required this.siMstrSiDesc,
    this.siMstrSiEntity,
    this.siMstrSiStatus,
    this.siMstrSiAutoLoc,
    this.siMstrSiDb,
    this.siMstrSiCurSet,
    this.siMstrSiGlSet,
    this.siMstrSiXferOwnership,
    this.localVariablesBrowseRowOrderIndex,
    this.localVariablesUniqueId,
    this.localVariablesDecorationCell,
    this.siMstrOidXSiMstr,
    this.siMstrSiMstrRowid,
  });

  String siMstrSiDomain;
  String siMstrSiSite;
  String siMstrSiDesc;
  dynamic siMstrSiEntity;
  dynamic siMstrSiStatus;
  dynamic siMstrSiAutoLoc;
  dynamic siMstrSiDb;
  dynamic siMstrSiCurSet;
  dynamic siMstrSiGlSet;
  dynamic siMstrSiXferOwnership;
  dynamic localVariablesBrowseRowOrderIndex;
  dynamic localVariablesUniqueId;
  dynamic localVariablesDecorationCell;
  dynamic siMstrOidXSiMstr;
  dynamic siMstrSiMstrRowid;

  factory FundoModel.fromJson(Map<String, dynamic> json) => FundoModel(
        siMstrSiDomain: json["si_mstr.si_domain"],
        siMstrSiSite: json["si_mstr.si_site"],
        siMstrSiDesc: json["si_mstr.si_desc"],
        siMstrSiEntity: json["si_mstr.si_entity"],
        siMstrSiStatus: json["si_mstr.si_status"],
        siMstrSiAutoLoc: json["si_mstr.si_auto_loc"],
        siMstrSiDb: json["si_mstr.si_db"],
        siMstrSiCurSet: json["si_mstr.si_cur_set"],
        siMstrSiGlSet: json["si_mstr.si_gl_set"],
        siMstrSiXferOwnership: json["si_mstr.si_xfer_ownership"],
        localVariablesBrowseRowOrderIndex:
            json["local_variables.BrowseRowOrderIndex"],
        localVariablesUniqueId: json["local_variables.uniqueId"],
        localVariablesDecorationCell: json["local_variables.decoration_cell"],
        siMstrOidXSiMstr: json["si_mstr.oid_X_si_mstr"],
        siMstrSiMstrRowid: json["si_mstr.si_mstr_rowid"],
      );

  Map<String, dynamic> toJson() => {
        "si_mstr.si_domain": siMstrSiDomain,
        "si_mstr.si_site": siMstrSiSite,
        "si_mstr.si_desc": siMstrSiDesc,
        "si_mstr.si_entity": siMstrSiEntity,
        "si_mstr.si_status": siMstrSiStatus,
        "si_mstr.si_auto_loc": siMstrSiAutoLoc,
        "si_mstr.si_db": siMstrSiDb,
        "si_mstr.si_cur_set": siMstrSiCurSet,
        "si_mstr.si_gl_set": siMstrSiGlSet,
        "si_mstr.si_xfer_ownership": siMstrSiXferOwnership,
        "local_variables.BrowseRowOrderIndex":
            localVariablesBrowseRowOrderIndex,
        "local_variables.uniqueId": localVariablesUniqueId,
        "local_variables.decoration_cell": localVariablesDecorationCell,
        "si_mstr.oid_X_si_mstr": siMstrOidXSiMstr,
        "si_mstr.si_mstr_rowid": siMstrSiMstrRowid,
      };
}
