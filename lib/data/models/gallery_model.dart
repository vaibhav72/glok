// To parse this JSON data, do
//
//     final galleryItem = galleryItemFromJson(jsonString);

import 'dart:convert';

GalleryItem galleryItemFromJson(String str) =>
    GalleryItem.fromJson(json.decode(str));

String galleryItemToJson(GalleryItem data) => json.encode(data.toJson());

class GalleryItem {
  int? id;
  String? file;
  String? category;
  DateTime? createdAt;
  int? glockerId;

  GalleryItem({
    this.id,
    this.file,
    this.category,
    this.createdAt,
    this.glockerId,
  });

  GalleryItem copyWith({
    int? id,
    String? file,
    String? category,
    DateTime? createdAt,
    int? glockerId,
  }) =>
      GalleryItem(
        id: id ?? this.id,
        file: file ?? this.file,
        category: category ?? this.category,
        createdAt: createdAt ?? this.createdAt,
        glockerId: glockerId ?? this.glockerId,
      );

  factory GalleryItem.fromJson(Map<String, dynamic> json) => GalleryItem(
        id: json["id"],
        file: json["file"],
        category: json["category"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        glockerId: json["glocker_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "category": category,
        "created_at": createdAt?.toIso8601String(),
        "glocker_id": glockerId,
      };
}
