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
  int? amount;
  int? glockerId;
  int? userId;
  String? state;
  int? biddingSessionId;
  String? userName;
  String? profilePhoto;
  double? rating;
  int? count;

  BidListModel({
    this.id,
    this.amount,
    this.glockerId,
    this.userId,
    this.state,
    this.biddingSessionId,
    this.userName,
    this.profilePhoto,
    this.rating,
    this.count,
  });

  BidListModel copyWith({
    int? id,
    int? amount,
    int? glockerId,
    int? userId,
    String? state,
    int? biddingSessionId,
    String? userName,
    String? profilePhoto,
    double? rating,
    int? count,
  }) =>
      BidListModel(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        glockerId: glockerId ?? this.glockerId,
        userId: userId ?? this.userId,
        state: state ?? this.state,
        biddingSessionId: biddingSessionId ?? this.biddingSessionId,
        userName: userName ?? this.userName,
        profilePhoto: profilePhoto ?? this.profilePhoto,
        rating: rating ?? this.rating,
        count: count ?? this.count,
      );

  factory BidListModel.fromJson(Map<String, dynamic> json) => BidListModel(
        id: json["id"],
        amount: json["amount"],
        glockerId: json["glocker_id"],
        userId: json["user_id"],
        state: json["state"],
        biddingSessionId: json["bidding_session_id"],
        userName: json["user_name"],
        profilePhoto: json["profile_photo"],
        rating: json["rating"]?.toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "glocker_id": glockerId,
        "user_id": userId,
        "state": state,
        "bidding_session_id": biddingSessionId,
        "user_name": userName,
        "profile_photo": profilePhoto,
        "rating": rating,
        "count": count,
      };
}
