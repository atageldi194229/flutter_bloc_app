part of 'loading_bloc.dart';

@immutable
class LoadingEvent {
  const LoadingEvent();
}

@immutable
class StartLoadingEvent extends LoadingEvent {
  const StartLoadingEvent();
}

@immutable
class StopLoadingEvent extends LoadingEvent {
  const StopLoadingEvent();
}
