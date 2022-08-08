import 'package:flutter/material.dart' show BuildContext;
import 'package:jsonplaceholder_app/data/error/app_error.dart';
import 'package:jsonplaceholder_app/presentation/dialogs/generic_dialog.dart';

Future<void> showLoadError({
  required AppError error,
  required BuildContext context,
}) {
  return showGenericDialog<void>(
    context: context,
    title: error.title,
    content: error.description,
    optionsBuilder: () => {
      'OK': true,
    },
  );
}
