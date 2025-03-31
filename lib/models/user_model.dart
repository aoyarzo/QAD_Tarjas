// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.usrMstrUsrUserid,
        required this.usrMstrUsrName,
        required this.usrMstrUsrActive,
        required this.usrMstrUsrPasswd,
        required this.localVariablesBrowseRowOrderIndex,
        required this.localVariablesUniqueId,
        this.localVariablesDecorationCell,
        this.usrMstrOidXUsrMstr,
        required this.usrMstrUsrMstrRowid,
    });

    String usrMstrUsrUserid;
    String usrMstrUsrName;
    bool usrMstrUsrActive;
    String usrMstrUsrPasswd;
    int localVariablesBrowseRowOrderIndex;
    String localVariablesUniqueId;
    dynamic localVariablesDecorationCell;
    dynamic usrMstrOidXUsrMstr;
    String usrMstrUsrMstrRowid;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        usrMstrUsrUserid: json["usr_mstr.usr_userid"],
        usrMstrUsrName: json["usr_mstr.usr_name"],
        usrMstrUsrActive: json["usr_mstr.usr_active"],
        usrMstrUsrPasswd: json["usr_mstr.usr_passwd"],
        localVariablesBrowseRowOrderIndex: json["local_variables.BrowseRowOrderIndex"],
        localVariablesUniqueId: json["local_variables.uniqueId"],
        localVariablesDecorationCell: json["local_variables.decoration_cell"],
        usrMstrOidXUsrMstr: json["usr_mstr.oid_X_usr_mstr"],
        usrMstrUsrMstrRowid: json["usr_mstr.usr_mstr_rowid"],
    );

    Map<String, dynamic> toJson() => {
        "usr_mstr.usr_userid": usrMstrUsrUserid,
        "usr_mstr.usr_name": usrMstrUsrName,
        "usr_mstr.usr_active": usrMstrUsrActive,
        "usr_mstr.usr_passwd": usrMstrUsrPasswd,
        "local_variables.BrowseRowOrderIndex": localVariablesBrowseRowOrderIndex,
        "local_variables.uniqueId": localVariablesUniqueId,
        "local_variables.decoration_cell": localVariablesDecorationCell,
        "usr_mstr.oid_X_usr_mstr": usrMstrOidXUsrMstr,
        "usr_mstr.usr_mstr_rowid": usrMstrUsrMstrRowid,
    };
}
