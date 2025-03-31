// To parse this JSON data, do
//
//     final cuartelModel = cuartelModelFromJson(jsonString);

import 'dart:convert';

List<CuartelModel> cuartelModelFromJson(String str) => List<CuartelModel>.from(json.decode(str).map((x) => CuartelModel.fromJson(x)));

String cuartelModelToJson(List<CuartelModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CuartelModel {
    CuartelModel({
        required this.xxawoMstrXxawoDomain,
        required this.xxawoMstrXxawoSite,
        required this.xxawoMstrXxawoNbr,
        required this.xxawodDetXxawodLoc,
        required this.locMstrLocDesc,
        required this.xxpadDetXxpadNumPla,
        this.localVariablesBrowseRowOrderIndex,
        this.localVariablesUniqueId,
        this.localVariablesDecorationCell,
        this.xxawoMstrOidXXxawoMstr,
        this.xxawoMstrXxawoMstrRowid,
        this.xxawodDetOidXXxawodDet,
        this.xxawodDetXxawodDetRowid,
        this.locMstrOidXLocMstr,
        this.locMstrLocMstrRowid,
        this.xxpadDetOidXXxpadDet,
        this.xxpadDetXxpadDetRowid,
    });

    String xxawoMstrXxawoDomain;
    String xxawoMstrXxawoSite;
    int xxawoMstrXxawoNbr;
    String xxawodDetXxawodLoc;
    String locMstrLocDesc;
    double xxpadDetXxpadNumPla;
    dynamic localVariablesBrowseRowOrderIndex;
    dynamic localVariablesUniqueId;
    dynamic localVariablesDecorationCell;
    dynamic xxawoMstrOidXXxawoMstr;
    dynamic xxawoMstrXxawoMstrRowid;
    dynamic xxawodDetOidXXxawodDet;
    dynamic xxawodDetXxawodDetRowid;
    dynamic locMstrOidXLocMstr;
    dynamic locMstrLocMstrRowid;
    dynamic xxpadDetOidXXxpadDet;
    dynamic xxpadDetXxpadDetRowid;

    factory CuartelModel.fromJson(Map<String, dynamic> json) => CuartelModel(
        xxawoMstrXxawoDomain: json["xxawo_mstr.xxawo_domain"],
        xxawoMstrXxawoSite: json["xxawo_mstr.xxawo_site"],
        xxawoMstrXxawoNbr: json["xxawo_mstr.xxawo_nbr"],
        xxawodDetXxawodLoc: json["xxawod_det.xxawod_loc"],
        locMstrLocDesc: json["loc_mstr.loc_desc"],
        xxpadDetXxpadNumPla: json["xxpad_det.xxpad_num_pla"].toDouble(),
        localVariablesBrowseRowOrderIndex: json["local_variables.BrowseRowOrderIndex"],
        localVariablesUniqueId: json["local_variables.uniqueId"],
        localVariablesDecorationCell: json["local_variables.decoration_cell"],
        xxawoMstrOidXXxawoMstr: json["xxawo_mstr.oid_X_xxawo_mstr"],
        xxawoMstrXxawoMstrRowid: json["xxawo_mstr.xxawo_mstr_rowid"],
        xxawodDetOidXXxawodDet: json["xxawod_det.oid_X_xxawod_det"],
        xxawodDetXxawodDetRowid: json["xxawod_det.xxawod_det_rowid"],
        locMstrOidXLocMstr: json["loc_mstr.oid_X_loc_mstr"],
        locMstrLocMstrRowid: json["loc_mstr.loc_mstr_rowid"],
        xxpadDetOidXXxpadDet: json["xxpad_det.oid_X_xxpad_det"],
        xxpadDetXxpadDetRowid: json["xxpad_det.xxpad_det_rowid"],
    );

    Map<String, dynamic> toJson() => {
        "xxawo_mstr.xxawo_domain": xxawoMstrXxawoDomain,
        "xxawo_mstr.xxawo_site": xxawoMstrXxawoSite,
        "xxawo_mstr.xxawo_nbr": xxawoMstrXxawoNbr,
        "xxawod_det.xxawod_loc": xxawodDetXxawodLoc,
        "loc_mstr.loc_desc": locMstrLocDesc,
        "xxpad_det.xxpad_num_pla": xxpadDetXxpadNumPla,
        "local_variables.BrowseRowOrderIndex": localVariablesBrowseRowOrderIndex,
        "local_variables.uniqueId": localVariablesUniqueId,
        "local_variables.decoration_cell": localVariablesDecorationCell,
        "xxawo_mstr.oid_X_xxawo_mstr": xxawoMstrOidXXxawoMstr,
        "xxawo_mstr.xxawo_mstr_rowid": xxawoMstrXxawoMstrRowid,
        "xxawod_det.oid_X_xxawod_det": xxawodDetOidXXxawodDet,
        "xxawod_det.xxawod_det_rowid": xxawodDetXxawodDetRowid,
        "loc_mstr.oid_X_loc_mstr": locMstrOidXLocMstr,
        "loc_mstr.loc_mstr_rowid": locMstrLocMstrRowid,
        "xxpad_det.oid_X_xxpad_det": xxpadDetOidXXxpadDet,
        "xxpad_det.xxpad_det_rowid": xxpadDetXxpadDetRowid,
    };
}
