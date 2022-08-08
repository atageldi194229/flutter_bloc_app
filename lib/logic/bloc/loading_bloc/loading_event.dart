import 'package:flutter/foundation.dart' show immutable;

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
