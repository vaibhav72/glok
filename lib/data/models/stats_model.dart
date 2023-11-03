// To parse this JSON data, do
//
//     final glockerStatsModel = glockerStatsModelFromJson(jsonString);

import 'dart:convert';

GlockerStatsModel glockerStatsModelFromJson(String str) =>
    GlockerStatsModel.fromJson(json.decode(str));

String glockerStatsModelToJson(GlockerStatsModel data) =>
    json.encode(data.toJson());

class GlockerStatsModel {
  int? status;
  num? totalAmount;
  num? percentageAmountChange;
  num? totalDuration;
  num? percentageDurationChange;
  num? totalUser;
  num? percentageUserChange;
  List<Stat>? stat;

  GlockerStatsModel({
    this.status,
    this.totalAmount,
    this.percentageAmountChange,
    this.totalDuration,
    this.percentageDurationChange,
    this.totalUser,
    this.percentageUserChange,
    this.stat,
  });

  GlockerStatsModel copyWith({
    int? status,
    num? totalAmount,
    num? percentageAmountChange,
    num? totalDuration,
    num? percentageDurationChange,
    num? totalUser,
    num? percentageUserChange,
    List<Stat>? stat,
  }) =>
      GlockerStatsModel(
        status: status ?? this.status,
        totalAmount: totalAmount ?? this.totalAmount,
        percentageAmountChange:
            percentageAmountChange ?? this.percentageAmountChange,
        totalDuration: totalDuration ?? this.totalDuration,
        percentageDurationChange:
            percentageDurationChange ?? this.percentageDurationChange,
        totalUser: totalUser ?? this.totalUser,
        percentageUserChange: percentageUserChange ?? this.percentageUserChange,
        stat: stat ?? this.stat,
      );

  factory GlockerStatsModel.fromJson(Map<String, dynamic> json) =>
      GlockerStatsModel(
        status: json["status"],
        totalAmount: json["total amount"],
        percentageAmountChange: double.parse(json["percentage_amount_change"]),
        totalDuration: json["total_duration"],
        percentageDurationChange:
            double.parse(json["percentage_duration_change"]),
        totalUser: json["total_user"],
        percentageUserChange: double.parse(json["percentage_user_change"]),
        stat: json["stat"] == null
            ? []
            : List<Stat>.from(json["stat"]!.map((x) => Stat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "total amount": totalAmount,
        "percentage_amount_change": percentageAmountChange,
        "total_duration": totalDuration,
        "percentage_duration_change": percentageDurationChange,
        "total_user": totalUser,
        "percentage_user_change": percentageUserChange,
        "stat": stat == null
            ? []
            : List<dynamic>.from(stat!.map((x) => x.toJson())),
      };
}

class Stat {
  double? amount;
  DateTime? date;

  Stat({
    this.amount,
    this.date,
  });

  Stat copyWith({
    double? amount,
    DateTime? date,
  }) =>
      Stat(
        amount: amount ?? this.amount,
        date: date ?? this.date,
      );

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        amount: double.parse(json["amount"] ?? '0'),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "date": date?.toIso8601String(),
      };
}
