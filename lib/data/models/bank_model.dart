// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankModelToJson(BankModel data) => json.encode(data.toJson());

class BankModel {
  int? status;
  String? accountHolderName;
  String? accountNumber;
  String? reenterAccountNumber;
  String? ifscCode;
  int? id;

  BankModel({
    this.status,
    this.accountHolderName,
    this.accountNumber,
    this.reenterAccountNumber,
    this.ifscCode,
    this.id,
  });

  BankModel copyWith({
    int? status,
    String? accountHolderName,
    String? accountNumber,
    String? reenterAccountNumber,
    String? ifscCode,
    int? id,
  }) =>
      BankModel(
        status: status ?? this.status,
        accountHolderName: accountHolderName ?? this.accountHolderName,
        accountNumber: accountNumber ?? this.accountNumber,
        reenterAccountNumber: reenterAccountNumber ?? this.reenterAccountNumber,
        ifscCode: ifscCode ?? this.ifscCode,
        id: id ?? this.id,
      );

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        status: json["status"],
        accountHolderName: json["account_holder_name"],
        accountNumber: json["account_number"],
        reenterAccountNumber: json["reenter_account_number"],
        ifscCode: json["ifsc_code"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "account_holder_name": accountHolderName,
        "account_number": accountNumber,
        "reenter_account_number": reenterAccountNumber,
        "ifsc_code": ifscCode,
        "id": id,
      };
}
