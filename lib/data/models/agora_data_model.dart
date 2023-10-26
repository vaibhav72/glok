// To parse this JSON data, do
//
//     final agoraResponseModel = agoraResponseModelFromJson(jsonString);

import 'dart:convert';

AgoraResponseModel agoraResponseModelFromJson(String str) =>
    AgoraResponseModel.fromJson(json.decode(str));

String agoraResponseModelToJson(AgoraResponseModel data) =>
    json.encode(data.toJson());

class AgoraResponseModel {
  String? token;
  String? channelName;
  int? userId;
  int? glockerId;

  AgoraResponseModel({
    this.token,
    this.channelName,
    this.userId,
    this.glockerId,
  });

  AgoraResponseModel copyWith({
    String? token,
    String? channelName,
    int? userId,
    int? glockerId,
  }) =>
      AgoraResponseModel(
        token: token ?? this.token,
        channelName: channelName ?? this.channelName,
        userId: userId ?? this.userId,
        glockerId: glockerId ?? this.glockerId,
      );

  factory AgoraResponseModel.fromJson(Map<String, dynamic> json) =>
      AgoraResponseModel(
        token: json["token"],
        channelName: json["channel_name"],
        userId: json["user_id"],
        glockerId: json["glocker_id"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "channel_name": channelName,
        "user_id": userId,
        "glocker_id": glockerId,
      };
}
