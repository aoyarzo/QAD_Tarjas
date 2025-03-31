// To parse this JSON data, do
//
//     final maxHeModel = maxHeModelFromJson(jsonString);

import 'dart:convert';

List<MaxHeModel> maxHeModelFromJson(String str) => List<MaxHeModel>.from(json.decode(str).map((x) => MaxHeModel.fromJson(x)));

String maxHeModelToJson(List<MaxHeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaxHeModel {
    MaxHeModel({
        required this.xxagCtrlXxagSite,
        required this.xxagCtrlXxagUdec05,
        this.xxagCtrlXxagUdec01,
        this.localVariablesBrowseRowOrderIndex,
        this.localVariablesUniqueId,
        this.localVariablesDecorationCell,
        this.xxagCtrlOidXXxagCtrl,
        this.xxagCtrlXxagCtrlRowid,
    });

    String xxagCtrlXxagSite;
    int xxagCtrlXxagUdec05;
    double? xxagCtrlXxagUdec01;
    dynamic localVariablesBrowseRowOrderIndex;
    dynamic localVariablesUniqueId;
    dynamic localVariablesDecorationCell;
    dynamic xxagCtrlOidXXxagCtrl;
    dynamic xxagCtrlXxagCtrlRowid;

    factory MaxHeModel.fromJson(Map<String, dynamic> json) => MaxHeModel(
        xxagCtrlXxagSite: json["xxag_ctrl.xxag_site"],
        xxagCtrlXxagUdec05: json["xxag_ctrl.xxag__udec05"],
        xxagCtrlXxagUdec01: json["xxag_ctrl.xxag__udec01"].toDouble(),
        localVariablesBrowseRowOrderIndex: json["local_variables.BrowseRowOrderIndex"],
        localVariablesUniqueId: json["local_variables.uniqueId"],
        localVariablesDecorationCell: json["local_variables.decoration_cell"],
        xxagCtrlOidXXxagCtrl: json["xxag_ctrl.oid_X_xxag_ctrl"],
        xxagCtrlXxagCtrlRowid: json["xxag_ctrl.xxag_ctrl_rowid"],
    );

    Map<String, dynamic> toJson() => {
        "xxag_ctrl.xxag_site": xxagCtrlXxagSite,
        "xxag_ctrl.xxag__udec05": xxagCtrlXxagUdec05,
        "xxag_ctrl.xxag__udec01": xxagCtrlXxagUdec01,
        "local_variables.BrowseRowOrderIndex": localVariablesBrowseRowOrderIndex,
        "local_variables.uniqueId": localVariablesUniqueId,
        "local_variables.decoration_cell": localVariablesDecorationCell,
        "xxag_ctrl.oid_X_xxag_ctrl": xxagCtrlOidXXxagCtrl,
        "xxag_ctrl.xxag_ctrl_rowid": xxagCtrlXxagCtrlRowid,
    };
}
