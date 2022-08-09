import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jsonplaceholder_app/data/error/app_error.dart';
import 'package:jsonplaceholder_app/logic/bloc/app_error_bloc/app_error_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/loading_bloc/loading_bloc.dart';

part 'item_list_event.dart';
part 'item_list_state.dart';

class ItemListBloc<T> extends Bloc<ItemListEvent<T>, ItemListState<T>> {
  final AppErrorBloc appErrorBloc;
  final LoadingBloc loadingBloc;
  late LazyBox box;

  ItemListBloc({
    required this.appErrorBloc,
    required this.loadingBloc,
  }) : super(const ItemListInitial()) {
    box = Hive.lazyBox("appBox");
  }

  T getItemFromJson(e) {
    throw Exception("Unimplemented error");
  }

  onLoadItemList(
    LoadItemListEvent<T> event,
    Emitter<ItemListState<T>> emit,
  ) async {
    // start loading
    loadingBloc.add(const StartLoadingEvent());

    try {
      final key = event.path;
      late Iterable<T> list;

      // first check cache
      if (box.containsKey(key)) {
        String value = await box.get(key);
        list = (jsonDecode(value) as List).map(
          (e) => getItemFromJson(e),
        );

        // stop loading & set list
        loadingBloc.add(const StopLoadingEvent());
        emit(ItemListState(list));
      }

      // get data from loader
      list = await event.loader();
      box.put(key, jsonEncode(list.toList()));

      // stop loading & set list
      loadingBloc.add(const StopLoadingEvent());
      emit(ItemListState([...state.list, ...list]));
    } catch (_) {
      // stop loading & show load error dialog
      loadingBloc.add(const StopLoadingEvent());
      appErrorBloc.add(const AppErrorEvent(LoadError()));
    }
  }
}
