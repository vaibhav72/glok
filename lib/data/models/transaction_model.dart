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
  String? description;
  int? walletId;
  String? name;
  DateTime? createdAt;

  TransactionModel({
    this.id,
    this.amount,
    this.type,
    this.description,
    this.walletId,
    this.name,
    this.createdAt,
  });

  TransactionModel copyWith({
    int? id,
    String? amount,
    String? type,
    String? description,
    int? walletId,
    String? name,
    DateTime? createdAt,
  }) =>
      TransactionModel(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        description: description ?? this.description,
        walletId: walletId ?? this.walletId,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        amount: json["amount"].toString(),
        type: json["type"],
        description: json["description"],
        walletId: json["walletId"],
        name: json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "type": type,
        "description": description,
        "walletId": walletId,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
      };
}
