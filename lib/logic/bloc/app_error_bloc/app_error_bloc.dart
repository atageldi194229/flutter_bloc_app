import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_app/data/error/app_error.dart';

part 'app_error_event.dart';
part 'app_error_state.dart';

class AppErrorBloc extends Bloc<AppErrorEvent, AppErrorState> {
  AppErrorBloc() : super(const AppErrorInitial()) {
    on<AppErrorEvent>((event, emit) => emit(AppErrorState(event.error)));
  }
}
