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
  User? user;
  Glocker? glocker;

  AgoraResponseModel({
    this.token,
    this.channelName,
    this.user,
    this.glocker,
  });

  AgoraResponseModel copyWith({
    String? token,
    String? channelName,
    User? user,
    Glocker? glocker,
  }) =>
      AgoraResponseModel(
        token: token ?? this.token,
        channelName: channelName ?? this.channelName,
        user: user ?? this.user,
        glocker: glocker ?? this.glocker,
      );

  factory AgoraResponseModel.fromJson(Map<String, dynamic> json) =>
      AgoraResponseModel(
        token: json["token"],
        channelName: json["channel_name"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        glocker:
            json["glocker"] == null ? null : Glocker.fromJson(json["glocker"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "channel_name": channelName,
        "user": user?.toJson(),
        "glocker": glocker?.toJson(),
      };
}

class Glocker {
  int? id;
  String? name;
  String? category;
  String? aboutMe;
  bool? isOnline;
  int? price;
  int? kycPin;
  bool? isVideoKycDone;
  bool? isAadhar;
  dynamic aadharFront;
  dynamic aadharBack;
  String? profilePhoto;
  String? coverPhoto;
  String? nameAsPerPan;
  String? panNumber;
  dynamic gstinNumber;
  dynamic videoKyc;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  Glocker({
    this.id,
    this.name,
    this.category,
    this.aboutMe,
    this.isOnline,
    this.price,
    this.kycPin,
    this.isVideoKycDone,
    this.isAadhar,
    this.aadharFront,
    this.aadharBack,
    this.profilePhoto,
    this.coverPhoto,
    this.nameAsPerPan,
    this.panNumber,
    this.gstinNumber,
    this.videoKyc,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  Glocker copyWith({
    int? id,
    String? name,
    String? category,
    String? aboutMe,
    bool? isOnline,
    int? price,
    int? kycPin,
    bool? isVideoKycDone,
    bool? isAadhar,
    dynamic aadharFront,
    dynamic aadharBack,
    String? profilePhoto,
    String? coverPhoto,
    String? nameAsPerPan,
    String? panNumber,
    dynamic gstinNumber,
    dynamic videoKyc,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? user,
  }) =>
      Glocker(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        aboutMe: aboutMe ?? this.aboutMe,
        isOnline: isOnline ?? this.isOnline,
        price: price ?? this.price,
        kycPin: kycPin ?? this.kycPin,
        isVideoKycDone: isVideoKycDone ?? this.isVideoKycDone,
        isAadhar: isAadhar ?? this.isAadhar,
        aadharFront: aadharFront ?? this.aadharFront,
        aadharBack: aadharBack ?? this.aadharBack,
        profilePhoto: profilePhoto ?? this.profilePhoto,
        coverPhoto: coverPhoto ?? this.coverPhoto,
        nameAsPerPan: nameAsPerPan ?? this.nameAsPerPan,
        panNumber: panNumber ?? this.panNumber,
        gstinNumber: gstinNumber ?? this.gstinNumber,
        videoKyc: videoKyc ?? this.videoKyc,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        user: user ?? this.user,
      );

  factory Glocker.fromJson(Map<String, dynamic> json) => Glocker(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        aboutMe: json["about_me"],
        isOnline: json["is_online"],
        price: json["price"],
        kycPin: json["kyc_pin"],
        isVideoKycDone: json["is_video_kyc_done"],
        isAadhar: json["is_aadhar"],
        aadharFront: json["aadhar_front"],
        aadharBack: json["aadhar_back"],
        profilePhoto: json["profile_photo"],
        coverPhoto: json["cover_photo"],
        nameAsPerPan: json["name_as_per_pan"],
        panNumber: json["pan_number"],
        gstinNumber: json["gstin_number"],
        videoKyc: json["video_kyc"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "about_me": aboutMe,
        "is_online": isOnline,
        "price": price,
        "kyc_pin": kycPin,
        "is_video_kyc_done": isVideoKycDone,
        "is_aadhar": isAadhar,
        "aadhar_front": aadharFront,
        "aadhar_back": aadharBack,
        "profile_photo": profilePhoto,
        "cover_photo": coverPhoto,
        "name_as_per_pan": nameAsPerPan,
        "pan_number": panNumber,
        "gstin_number": gstinNumber,
        "video_kyc": videoKyc,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
      };
}

class User {
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
  int? glockerId;

  User({
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
  });

  User copyWith({
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
    int? glockerId,
  }) =>
      User(
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
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
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
      );

  Map<String, dynamic> toJson() => {
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
      };
}
