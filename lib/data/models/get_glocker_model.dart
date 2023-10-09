// To parse this JSON data, do
//
//     final getGlockerModel = getGlockerModelFromJson(jsonString);

import 'dart:convert';

GetGlockerModel getGlockerModelFromJson(String str) =>
    GetGlockerModel.fromJson(json.decode(str));

String getGlockerModelToJson(GetGlockerModel data) =>
    json.encode(data.toJson());

class GetGlockerModel {
  int? id;
  String? name;
  String? category;
  String? aboutMe;
  bool? isOnline;
  int? price;
  int? kycPin;
  bool? isKyc;
  bool? isAadhar;
  dynamic aadharFront;
  dynamic aadharBack;
  dynamic profilePhoto;
  dynamic coverPhoto;

  GetGlockerModel({
    this.id,
    this.name,
    this.category,
    this.aboutMe,
    this.isOnline,
    this.price,
    this.kycPin,
    this.isKyc,
    this.isAadhar,
    this.aadharFront,
    this.aadharBack,
    this.profilePhoto,
    this.coverPhoto,
  });

  GetGlockerModel copyWith({
    int? id,
    String? name,
    String? category,
    String? aboutMe,
    bool? isOnline,
    int? price,
    int? kycPin,
    bool? isKyc,
    bool? isAadhar,
    dynamic aadharFront,
    dynamic aadharBack,
    dynamic profilePhoto,
    dynamic coverPhoto,
  }) =>
      GetGlockerModel(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        aboutMe: aboutMe ?? this.aboutMe,
        isOnline: isOnline ?? this.isOnline,
        price: price ?? this.price,
        kycPin: kycPin ?? this.kycPin,
        isKyc: isKyc ?? this.isKyc,
        isAadhar: isAadhar ?? this.isAadhar,
        aadharFront: aadharFront ?? this.aadharFront,
        aadharBack: aadharBack ?? this.aadharBack,
        profilePhoto: profilePhoto ?? this.profilePhoto,
        coverPhoto: coverPhoto ?? this.coverPhoto,
      );

  factory GetGlockerModel.fromJson(Map<String, dynamic> json) =>
      GetGlockerModel(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        aboutMe: json["about_me"],
        isOnline: json["is_online"],
        price: json["price"],
        kycPin: json["kyc_pin"],
        isKyc: json["is_kyc"],
        isAadhar: json["is_aadhar"],
        aadharFront: json["aadhar_front"],
        aadharBack: json["aadhar_back"],
        profilePhoto: json["profile_photo"],
        coverPhoto: json["cover_photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "about_me": aboutMe,
        "is_online": isOnline,
        "price": price,
        "kyc_pin": kycPin,
        "is_kyc": isKyc,
        "is_aadhar": isAadhar,
        "aadhar_front": aadharFront,
        "aadhar_back": aadharBack,
        "profile_photo": profilePhoto,
        "cover_photo": coverPhoto,
      };
}
