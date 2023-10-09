// To parse this JSON data, do
//
//     final registrationModel = registrationModelFromJson(jsonString);

import 'dart:convert';

RegistrationModel registrationModelFromJson(String str) =>
    RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) =>
    json.encode(data.toJson());

class RegistrationModel {
  int? status;
  String? name;
  String? gender;
  String? email;
  String? mobileNumber;
  int? otp;
  String? photo;
  String? countryCode;
  DateTime? createdAt;
  DateTime? updatedAt;

  RegistrationModel({
    this.status,
    this.name,
    this.gender,
    this.email,
    this.mobileNumber,
    this.otp,
    this.photo,
    this.countryCode,
    this.createdAt,
    this.updatedAt,
  });

  RegistrationModel copyWith({
    int? status,
    String? name,
    String? gender,
    String? email,
    String? mobileNumber,
    int? otp,
    String? photo,
    String? countryCode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      RegistrationModel(
        status: status ?? this.status,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        otp: otp ?? this.otp,
        photo: photo ?? this.photo,
        countryCode: countryCode ?? this.countryCode,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      RegistrationModel(
        status: json["status"],
        name: json["name"],
        gender: json["gender"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        otp: json["otp"],
        photo: json["photo"],
        countryCode: json["country_code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "name": name,
        "gender": gender,
        "email": email,
        "mobile_number": mobileNumber,
        "otp": otp,
        "photo": photo,
        "country_code": countryCode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
