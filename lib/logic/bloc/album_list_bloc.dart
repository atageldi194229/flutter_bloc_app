import 'package:flutter/foundation.dart' show immutable;
import 'package:jsonplaceholder_app/data/models/album_model.dart';
import 'package:jsonplaceholder_app/logic/bloc/abstract/item_list_bloc/item_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/app_error_bloc/app_error_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/loading_bloc/loading_bloc.dart';

typedef ItemModel = AlbumModel;

class AlbumListBloc extends ItemListBloc<ItemModel> {
  AlbumListBloc({
    required AppErrorBloc appErrorBloc,
    required LoadingBloc loadingBloc,
  }) : super(
          appErrorBloc: appErrorBloc,
          loadingBloc: loadingBloc,
        ) {
    on<LoadUserAlbumsEvent>(onLoadItemList);
  }

  @override
  ItemModel getItemFromJson(e) => ItemModel.fromJson(e);
}

@immutable
class LoadUserAlbumsEvent extends LoadItemListEvent<ItemModel> {
  final int userId;
  const LoadUserAlbumsEvent({
    required super.loader,
    required this.userId,
  });

  @override
  String get path => "users/$userId/albums";
}
