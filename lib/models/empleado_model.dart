// To parse this JSON data, do
//
//     final empleadoModel = empleadoModelFromJson(jsonString);

import 'dart:convert';

List<EmpleadoModel> empleadoModelFromJson(String str) => List<EmpleadoModel>.from(json.decode(str).map((x) => EmpleadoModel.fromJson(x)));

String empleadoModelToJson(List<EmpleadoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmpleadoModel {
    EmpleadoModel({
        required this.empMstrEmpDomain,
        required this.empMstrEmpAddr,
        required this.empMstrEmpSort,
        required this.empMstrEmpChr02,
        required this.empMstrEmpActive,
        this.empMstrEmpDept,
        this.empMstrEmpBsPhone,
        this.empMstrEmpCity,
        this.empMstrEmpCountry,
        this.empMstrEmpEmpDate,
        this.empMstrEmpPhone,
        this.empMstrEmpTrmDate,
        required this.xxempMstrXxempUlog10,
        this.localVariablesBrowseRowOrderIndex,
        this.localVariablesUniqueId,
        this.localVariablesDecorationCell,
        this.empMstrOidXEmpMstr,
        this.empMstrEmpMstrRowid,
        this.xxempMstrOidXXxempMstr,
        this.xxempMstrXxempMstrRowid,
    });

    String empMstrEmpDomain;
    String empMstrEmpAddr;
    String empMstrEmpSort;
    String empMstrEmpChr02;
    bool empMstrEmpActive;
    dynamic empMstrEmpDept;
    dynamic empMstrEmpBsPhone;
    dynamic empMstrEmpCity;
    dynamic empMstrEmpCountry;
    dynamic empMstrEmpEmpDate;
    dynamic empMstrEmpPhone;
    dynamic empMstrEmpTrmDate;
    bool xxempMstrXxempUlog10;
    dynamic localVariablesBrowseRowOrderIndex;
    dynamic localVariablesUniqueId;
    dynamic localVariablesDecorationCell;
    dynamic empMstrOidXEmpMstr;
    dynamic empMstrEmpMstrRowid;
    dynamic xxempMstrOidXXxempMstr;
    dynamic xxempMstrXxempMstrRowid;

    factory EmpleadoModel.fromJson(Map<String, dynamic> json) => EmpleadoModel(
        empMstrEmpDomain: json["emp_mstr.emp_domain"],
        empMstrEmpAddr: json["emp_mstr.emp_addr"],
        empMstrEmpSort: json["emp_mstr.emp_sort"],
        empMstrEmpChr02: json["emp_mstr.emp__chr02"],
        empMstrEmpActive: json["emp_mstr.emp_active"],
        empMstrEmpDept: json["emp_mstr.emp_dept"],
        empMstrEmpBsPhone: json["emp_mstr.emp_bs_phone"],
        empMstrEmpCity: json["emp_mstr.emp_city"],
        empMstrEmpCountry: json["emp_mstr.emp_country"],
        empMstrEmpEmpDate: DateTime.parse(json["emp_mstr.emp_emp_date"]),
        empMstrEmpPhone: json["emp_mstr.emp_phone"],
        empMstrEmpTrmDate: json["emp_mstr.emp_trm_date"],
        xxempMstrXxempUlog10: json["xxemp_mstr.xxemp__ulog10"],
        localVariablesBrowseRowOrderIndex: json["local_variables.BrowseRowOrderIndex"],
        localVariablesUniqueId: json["local_variables.uniqueId"],
        localVariablesDecorationCell: json["local_variables.decoration_cell"],
        empMstrOidXEmpMstr: json["emp_mstr.oid_X_emp_mstr"],
        empMstrEmpMstrRowid: json["emp_mstr.emp_mstr_rowid"],
        xxempMstrOidXXxempMstr: json["xxemp_mstr.oid_X_xxemp_mstr"],
        xxempMstrXxempMstrRowid: json["xxemp_mstr.xxemp_mstr_rowid"],
    );

    Map<String, dynamic> toJson() => {
        "emp_mstr.emp_domain": empMstrEmpDomain,
        "emp_mstr.emp_addr": empMstrEmpAddr,
        "emp_mstr.emp_sort": empMstrEmpSort,
        "emp_mstr.emp__chr02": empMstrEmpChr02,
        "emp_mstr.emp_active": empMstrEmpActive,
        "emp_mstr.emp_dept": empMstrEmpDept,
        "emp_mstr.emp_bs_phone": empMstrEmpBsPhone,
        "emp_mstr.emp_city": empMstrEmpCity,
        "emp_mstr.emp_country": empMstrEmpCountry,
        "emp_mstr.emp_emp_date": empMstrEmpEmpDate.toIso8601String(),
        "emp_mstr.emp_phone": empMstrEmpPhone,
        "emp_mstr.emp_trm_date": empMstrEmpTrmDate,
        "xxemp_mstr.xxemp__ulog10": xxempMstrXxempUlog10,
        "local_variables.BrowseRowOrderIndex": localVariablesBrowseRowOrderIndex,
        "local_variables.uniqueId": localVariablesUniqueId,
        "local_variables.decoration_cell": localVariablesDecorationCell,
        "emp_mstr.oid_X_emp_mstr": empMstrOidXEmpMstr,
        "emp_mstr.emp_mstr_rowid": empMstrEmpMstrRowid,
        "xxemp_mstr.oid_X_xxemp_mstr": xxempMstrOidXXxempMstr,
        "xxemp_mstr.xxemp_mstr_rowid": xxempMstrXxempMstrRowid,
    };
}
