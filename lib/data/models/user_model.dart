// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? status;
  int? id;
  String? name;
  String? gender;
  String? email;
  String? mobileNumber;
  bool? mobileVerified;
  String? countryCode;
  int? otp;
  String? photo;
  bool? isGlocker;
  bool? isActive;
  bool? isBlocked;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? roles;
  String? glockerId;
  String? accessToken;

  UserModel({
    this.status,
    this.id,
    this.name,
    this.gender,
    this.email,
    this.mobileNumber,
    this.mobileVerified,
    this.countryCode,
    this.otp,
    this.photo,
    this.isGlocker,
    this.isActive,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    this.roles,
    this.glockerId,
    this.accessToken,
  });

  UserModel copyWith({
    int? status,
    int? id,
    String? name,
    String? gender,
    String? email,
    String? mobileNumber,
    bool? mobileVerified,
    String? countryCode,
    int? otp,
    String? photo,
    bool? isGlocker,
    bool? isActive,
    bool? isBlocked,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? roles,
    String? glockerId,
    String? accessToken,
  }) =>
      UserModel(
        status: status ?? this.status,
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        mobileVerified: mobileVerified ?? this.mobileVerified,
        countryCode: countryCode ?? this.countryCode,
        otp: otp ?? this.otp,
        photo: photo ?? this.photo,
        isGlocker: isGlocker ?? this.isGlocker,
        isActive: isActive ?? this.isActive,
        isBlocked: isBlocked ?? this.isBlocked,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        roles: roles ?? this.roles,
        glockerId: glockerId ?? this.glockerId,
        accessToken: accessToken ?? this.accessToken,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        // status: json["status"],
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        mobileVerified: json["mobile_verified"],
        countryCode: json["country_code"],
        otp: json["otp"],
        photo: json["photo"],
        isGlocker: json["is_glocker"],
        isActive: json["is_active"],
        isBlocked: json["is_blocked"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        roles: json["roles"],
        glockerId: json["glocker_id"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "name": name,
        "gender": gender,
        "email": email,
        "mobile_number": mobileNumber,
        "mobile_verified": mobileVerified,
        "country_code": countryCode,
        "otp": otp,
        "photo": photo,
        "is_glocker": isGlocker,
        "is_active": isActive,
        "is_blocked": isBlocked,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "roles": roles,
        "glocker_id": glockerId,
        "access_token": accessToken,
      };
}
