// To parse this JSON data, do
//
//     final tipoPagoModel = tipoPagoModelFromJson(jsonString);

import 'dart:convert';

List<TipoPagoModel> tipoPagoModelFromJson(String str) => List<TipoPagoModel>.from(json.decode(str).map((x) => TipoPagoModel.fromJson(x)));

String tipoPagoModelToJson(List<TipoPagoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TipoPagoModel {
    TipoPagoModel({
        required this.wcMstrWcDomain,
        required this.wcMstrWcChr01,
        required this.localVariablesLocalVar00,
        required this.wcMstrWcDesc,
        this.wcMstrWcDept,
        required this.wcMstrWcMchOp,
        this.wcMstrWcWkctr,
        this.localVariablesLocalVar01,
        this.wcMstrWcMch,
        this.wcMstrWcLbrRate,
        this.wcMstrWcSetupRte,
        this.wcMstrWcFsmType,
        this.localVariablesBrowseRowOrderIndex,
        this.localVariablesUniqueId,
        this.localVariablesDecorationCell,
        this.wcMstrOidXWcMstr,
        this.wcMstrWcMstrRowid,
    });

    String wcMstrWcDomain;
    String wcMstrWcChr01;
    String localVariablesLocalVar00;
    String wcMstrWcDesc;
    dynamic wcMstrWcDept;
    int wcMstrWcMchOp;
    dynamic wcMstrWcWkctr;
    dynamic localVariablesLocalVar01;
    dynamic wcMstrWcMch;
    dynamic wcMstrWcLbrRate;
    dynamic wcMstrWcSetupRte;
    dynamic wcMstrWcFsmType;
    dynamic localVariablesBrowseRowOrderIndex;
    dynamic localVariablesUniqueId;
    dynamic localVariablesDecorationCell;
    dynamic wcMstrOidXWcMstr;
    dynamic wcMstrWcMstrRowid;

    factory TipoPagoModel.fromJson(Map<String, dynamic> json) => TipoPagoModel(
        wcMstrWcDomain: json["wc_mstr.wc_domain"],
        wcMstrWcChr01: json["wc_mstr.wc__chr01"],
        localVariablesLocalVar00: json["local_variables.local-var00"],
        wcMstrWcDesc: json["wc_mstr.wc_desc"],
        wcMstrWcDept: json["wc_mstr.wc_dept"],
        wcMstrWcMchOp: json["wc_mstr.wc_mch_op"],
        wcMstrWcWkctr: json["wc_mstr.wc_wkctr"],
        localVariablesLocalVar01: json["local_variables.local-var01"],
        wcMstrWcMch: json["wc_mstr.wc_mch"],
        wcMstrWcLbrRate: json["wc_mstr.wc_lbr_rate"],
        wcMstrWcSetupRte: json["wc_mstr.wc_setup_rte"],
        wcMstrWcFsmType: json["wc_mstr.wc_fsm_type"],
        localVariablesBrowseRowOrderIndex: json["local_variables.BrowseRowOrderIndex"],
        localVariablesUniqueId: json["local_variables.uniqueId"],
        localVariablesDecorationCell: json["local_variables.decoration_cell"],
        wcMstrOidXWcMstr: json["wc_mstr.oid_X_wc_mstr"],
        wcMstrWcMstrRowid: json["wc_mstr.wc_mstr_rowid"],
    );

    Map<String, dynamic> toJson() => {
        "wc_mstr.wc_domain": wcMstrWcDomain,
        "wc_mstr.wc__chr01": wcMstrWcChr01,
        "local_variables.local-var00": localVariablesLocalVar00,
        "wc_mstr.wc_desc": wcMstrWcDesc,
        "wc_mstr.wc_dept": wcMstrWcDept,
        "wc_mstr.wc_mch_op": wcMstrWcMchOp,
        "wc_mstr.wc_wkctr": wcMstrWcWkctr,
        "local_variables.local-var01": localVariablesLocalVar01,
        "wc_mstr.wc_mch": wcMstrWcMch,
        "wc_mstr.wc_lbr_rate": wcMstrWcLbrRate,
        "wc_mstr.wc_setup_rte": wcMstrWcSetupRte,
        "wc_mstr.wc_fsm_type": wcMstrWcFsmType,
        "local_variables.BrowseRowOrderIndex": localVariablesBrowseRowOrderIndex,
        "local_variables.uniqueId": localVariablesUniqueId,
        "local_variables.decoration_cell": localVariablesDecorationCell,
        "wc_mstr.oid_X_wc_mstr": wcMstrOidXWcMstr,
        "wc_mstr.wc_mstr_rowid": wcMstrWcMstrRowid,
    };
}
