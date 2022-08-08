import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class ItemModel {
  const ItemModel();
  const ItemModel.fromMap(Map<String, dynamic> json);
  Map<String, dynamic> toMap();
}
