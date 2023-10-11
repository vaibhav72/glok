// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  int? id;
  int? amount;
  String? type;
  int? walletId;

  TransactionModel({
    this.id,
    this.amount,
    this.type,
    this.walletId,
  });

  TransactionModel copyWith({
    int? id,
    int? amount,
    String? type,
    int? walletId,
  }) =>
      TransactionModel(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        walletId: walletId ?? this.walletId,
      );

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        amount: json["amount"],
        type: json["type"],
        walletId: json["walletId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "type": type,
        "walletId": walletId,
      };
}
