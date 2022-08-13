// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppError {
  final String title;
  final String description;

  const AppError({
    required this.title,
    required this.description,
  });

  @override
  bool operator ==(covariant AppError other) {
    if (identical(this, other)) return true;

    return other.title == title && other.description == description;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode;
}

@immutable
class LoadError extends AppError {
  const LoadError()
      : super(
          title: "Load error",
          description: "Maybe internet connection error",
        );
}
