import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadState> {
  LoadingBloc() : super(const LoadStateOff()) {
    on<StartLoadingEvent>((event, emit) => emit(const LoadStateOn()));
    on<StopLoadingEvent>((event, emit) => emit(const LoadStateOff()));
  }
}
