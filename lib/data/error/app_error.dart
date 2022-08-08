import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppError {
  final String title;
  final String description;

  const AppError({
    required this.title,
    required this.description,
  });
}

@immutable
class LoadError extends AppError {
  const LoadError()
      : super(
          title: "Load error",
          description: "Maybe internet connection error",
        );
}
