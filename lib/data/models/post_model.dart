import 'dart:convert';
import 'package:flutter/foundation.dart' show immutable;
import 'package:jsonplaceholder_app/data/models/abstract_model.dart';

@immutable
class PostModel extends ItemModel {
  const PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  final int userId;
  final int id;
  final String title;
  final String body;

  factory PostModel.fromJson(String str) => PostModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  @override
  factory PostModel.fromMap(Map<String, dynamic> json) => PostModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };

  @override
  String toString() {
    return toMap().toString();
  }
}
