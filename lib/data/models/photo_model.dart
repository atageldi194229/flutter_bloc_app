import 'dart:convert';
import 'package:flutter/foundation.dart' show immutable;
import 'package:jsonplaceholder_app/data/models/abstract_model.dart';

@immutable
class PhotoModel extends ItemModel {
  const PhotoModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  factory PhotoModel.fromJson(String str) =>
      PhotoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  @override
  factory PhotoModel.fromMap(Map<String, dynamic> json) => PhotoModel(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };

  @override
  String toString() {
    return toMap().toString();
  }
}
