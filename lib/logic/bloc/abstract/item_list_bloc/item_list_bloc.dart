import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_app/data/error/app_error.dart';
import 'package:jsonplaceholder_app/logic/bloc/app_error_bloc/app_error_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/loading_bloc/loading_bloc.dart';

part 'item_list_event.dart';
part 'item_list_state.dart';

class ItemListBloc<T> extends Bloc<ItemListEvent<T>, ItemListState<T>> {
  final AppErrorBloc appErrorBloc;
  final LoadingBloc loadingBloc;

  ItemListBloc({
    required this.appErrorBloc,
    required this.loadingBloc,
  }) : super(const ItemListInitial());

  onLoadItemList(
    LoadItemListEvent<T> event,
    Emitter<ItemListState<T>> emit,
  ) async {
    // start loading
    loadingBloc.add(const StartLoadingEvent());

    try {
      // get data from loader
      final Iterable<T> list = await event.loader();

      // stop loading & set list
      loadingBloc.add(const StopLoadingEvent());

      // emit new data
      emit(ItemListState({...state.list, ...list}.toList()));

      return;
    } on DioError catch (_) {
    } on SocketException catch (_) {
    } catch (_) {}

    // stop loading & show load error dialog
    loadingBloc.add(const StopLoadingEvent());
    appErrorBloc.add(const AppErrorAddEvent(LoadError()));
  }
}
