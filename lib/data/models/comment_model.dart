import 'dart:convert';
import 'package:flutter/foundation.dart' show immutable;
import 'package:jsonplaceholder_app/data/models/abstract_model.dart';

@immutable
class CommentModel extends ItemModel {
  const CommentModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  factory CommentModel.fromJson(String str) =>
      CommentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  @override
  factory CommentModel.fromMap(Map<String, dynamic> json) => CommentModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
      };

  @override
  String toString() {
    return toMap().toString();
  }
}