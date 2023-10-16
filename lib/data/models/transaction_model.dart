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
  String? amount;
  String? type;
  int? walletId;
  DateTime? createdAt;
  String? description;

  TransactionModel({
    this.id,
    this.amount,
    this.type,
    this.walletId,
    this.createdAt,
    this.description,
  });

  TransactionModel copyWith({
    int? id,
    String? amount,
    String? type,
    int? walletId,
    DateTime? createdAt,
    String? description,
  }) =>
      TransactionModel(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        walletId: walletId ?? this.walletId,
        createdAt: createdAt ?? this.createdAt,
        description: description ?? this.description,
      );

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        amount: json["amount"].toString(),
        type: json["type"],
        walletId: json["walletId"],
        createdAt: DateTime.parse(json["created_at"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "type": type,
        "walletId": walletId,
        "created_at": createdAt!.toIso8601String(),
        "description": description,
      };
}
