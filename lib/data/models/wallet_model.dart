// To parse this JSON data, do
//
//     final walletModel = walletModelFromJson(jsonString);

import 'dart:convert';

WalletModel walletModelFromJson(String str) =>
    WalletModel.fromJson(json.decode(str));

String walletModelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
  int? status;
  int? id;
  String? balance;
  String? currency;
  DateTime? creationDate;
  DateTime? lastUpdated;

  WalletModel({
    this.status,
    this.id,
    this.balance,
    this.currency,
    this.creationDate,
    this.lastUpdated,
  });

  WalletModel copyWith({
    int? status,
    int? id,
    String? balance,
    String? currency,
    DateTime? creationDate,
    DateTime? lastUpdated,
  }) =>
      WalletModel(
        status: status ?? this.status,
        id: id ?? this.id,
        balance: balance ?? this.balance,
        currency: currency ?? this.currency,
        creationDate: creationDate ?? this.creationDate,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        status: json["status"],
        id: json["id"],
        balance: json["balance"],
        currency: json["currency"],
        creationDate: json["creation_date"] == null
            ? null
            : DateTime.parse(json["creation_date"]),
        lastUpdated: json["last_updated"] == null
            ? null
            : DateTime.parse(json["last_updated"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "balance": balance,
        "currency": currency,
        "creation_date": creationDate?.toIso8601String(),
        "last_updated": lastUpdated?.toIso8601String(),
      };
}
