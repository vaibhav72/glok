// To parse this JSON data, do
//
//     final bidListModel = bidListModelFromJson(jsonString);

import 'dart:convert';

List<BidListModel> bidListModelFromJson(String str) => List<BidListModel>.from(
    json.decode(str).map((x) => BidListModel.fromJson(x)));

String bidListModelToJson(List<BidListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BidListModel {
  int? id;
  int? userId;
  int? glockerId;
  int? biddingSessionId;
  int? amount;
  State? state;

  BidListModel({
    this.id,
    this.userId,
    this.glockerId,
    this.biddingSessionId,
    this.amount,
    this.state,
  });

  BidListModel copyWith({
    int? id,
    int? userId,
    int? glockerId,
    int? biddingSessionId,
    int? amount,
    State? state,
  }) =>
      BidListModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        glockerId: glockerId ?? this.glockerId,
        biddingSessionId: biddingSessionId ?? this.biddingSessionId,
        amount: amount ?? this.amount,
        state: state ?? this.state,
      );

  factory BidListModel.fromJson(Map<String, dynamic> json) => BidListModel(
        id: json["id"],
        userId: json["user_id"],
        glockerId: json["glocker_id"],
        biddingSessionId: json["bidding_session_id"],
        amount: json["amount"],
        state: stateValues.map[json["state"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "glocker_id": glockerId,
        "bidding_session_id": biddingSessionId,
        "amount": amount,
        "state": stateValues.reverse[state],
      };
}

enum State { ACCEPTED, REJECTED }

final stateValues =
    EnumValues({"accepted": State.ACCEPTED, "rejected": State.REJECTED});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
