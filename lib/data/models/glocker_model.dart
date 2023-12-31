// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final glockerModel = glockerModelFromJson(jsonString);

import 'dart:convert';

GlockerModel glockerModelFromJson(String str) =>
    GlockerModel.fromJson(json.decode(str));

String glockerModelToJson(GlockerModel data) => json.encode(data.toJson());

class GlockerModel {
  int? status;
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
  String? videoKyc;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isFavourite;
  GlockerModel({
    this.status,
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
    this.isFavourite,
  });

  GlockerModel copyWith({
    int? status,
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
    String? videoKyc,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavourite,
  }) =>
      GlockerModel(
        status: status ?? this.status,
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
        isFavourite: isFavourite ?? this.isFavourite,
      );

  factory GlockerModel.fromJson(Map<String, dynamic> json) => GlockerModel(
        status: json["status"],
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
        isFavourite: json["is_favourite"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
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
      };

  @override
  bool operator ==(covariant GlockerModel other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.id == id &&
        other.name == name &&
        other.category == category &&
        other.aboutMe == aboutMe &&
        other.isOnline == isOnline &&
        other.price == price &&
        other.kycPin == kycPin &&
        other.isVideoKycDone == isVideoKycDone &&
        other.isAadhar == isAadhar &&
        other.aadharFront == aadharFront &&
        other.aadharBack == aadharBack &&
        other.profilePhoto == profilePhoto &&
        other.coverPhoto == coverPhoto &&
        other.nameAsPerPan == nameAsPerPan &&
        other.panNumber == panNumber &&
        other.gstinNumber == gstinNumber &&
        other.videoKyc == videoKyc &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.isFavourite == isFavourite;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        id.hashCode ^
        name.hashCode ^
        category.hashCode ^
        aboutMe.hashCode ^
        isOnline.hashCode ^
        price.hashCode ^
        kycPin.hashCode ^
        isVideoKycDone.hashCode ^
        isAadhar.hashCode ^
        aadharFront.hashCode ^
        aadharBack.hashCode ^
        profilePhoto.hashCode ^
        coverPhoto.hashCode ^
        nameAsPerPan.hashCode ^
        panNumber.hashCode ^
        gstinNumber.hashCode ^
        videoKyc.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        isFavourite.hashCode;
  }
}
