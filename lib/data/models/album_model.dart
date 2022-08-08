import 'dart:convert';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class AlbumModel {
  const AlbumModel({
    required this.userId,
    required this.id,
    required this.title,
  });

  final int userId;
  final int id;
  final String title;

  factory AlbumModel.fromJson(String str) =>
      AlbumModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AlbumModel.fromMap(Map<String, dynamic> json) => AlbumModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
      };

  @override
  String toString() {
    return toMap().toString();
  }
}
