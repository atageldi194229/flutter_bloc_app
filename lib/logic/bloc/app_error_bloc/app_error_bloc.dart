import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_app/data/error/app_error.dart';
import 'package:jsonplaceholder_app/logic/extensions/add_without_dublicate.dart';

part 'app_error_event.dart';
part 'app_error_state.dart';

class AppErrorBloc extends Bloc<AppErrorEvent, AppErrorState> {
  List<AppError> errors = [];

  AppErrorBloc() : super(const AppErrorInitial()) {
    on<AppErrorAddEvent>((event, emit) {
      errors.addWithoutDublicate(event.error);

      if (state.error == null) {
        emit(AppErrorState(event.error));
      }
    });

    on<AppErrorRemoveEvent>((event, emit) {
      errors.remove(event.error);

      if (errors.isNotEmpty) {
        emit(AppErrorState(errors.first));
      } else {
        emit(const AppErrorInitial());
      }
    });
  }
}
