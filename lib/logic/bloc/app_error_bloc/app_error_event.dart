part of 'app_error_bloc.dart';

@immutable
class AppErrorEvent {
  final AppError error;
  const AppErrorEvent(this.error);
}
