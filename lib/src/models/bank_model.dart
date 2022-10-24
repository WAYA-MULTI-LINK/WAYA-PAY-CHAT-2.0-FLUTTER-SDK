// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankModelToJson(BankModel data) => json.encode(data.toJson());

class BankModel {
  BankModel({
    required this.code,
    required this.message,
    required this.data,
    required this.date,
  });

  String code;
  String message;
  List<Bank> data;
  DateTime date;

  factory BankModel.fromJson(Map<dynamic, dynamic> json) => BankModel(
    code: json["code"],
    message: json["message"],
    data: List<Bank>.from(json["data"].map((x) => Bank.fromJson(x))),
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "date": date.toIso8601String(),
  };
}

class Bank {
  Bank({
    required this.bankId,
    required  this.bankName,
    required  this.bankUssdCode,
    required  this.bankUssdPrefix,
    required  this.createdAt,
    required  this.dateModified,
    required  this.updatedBy,
    required   this.createdBy,
    required this.updateAt,
    required  this.deleted,
  });

  String bankId;
  String bankName;
  String bankUssdCode;
  String bankUssdPrefix;
  DateTime createdAt;
  dynamic dateModified;
  dynamic updatedBy;
  int createdBy;
  dynamic updateAt;
  bool deleted;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    bankId: json["bankId"],
    bankName: json["bankName"],
    bankUssdCode: json["bankUSSDCode"],
    bankUssdPrefix: json["bankUSSDPrefix"],
    createdAt: DateTime.parse(json["createdAt"]),
    dateModified: json["dateModified"],
    updatedBy: json["updatedBy"],
    createdBy: json["createdBy"],
    updateAt: json["updateAt"],
    deleted: json["deleted"],
  );

  Map<String, dynamic> toJson() => {
    "bankId": bankId,
    "bankName": bankName,
    "bankUSSDCode": bankUssdCode,
    "bankUSSDPrefix": bankUssdPrefix,
    "createdAt": createdAt.toIso8601String(),
    "dateModified": dateModified,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "updateAt": updateAt,
    "deleted": deleted,
  };
}
