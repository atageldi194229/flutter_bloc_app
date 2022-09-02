import 'package:flutter/foundation.dart' show immutable;
import 'package:jsonplaceholder_app/data/models/photo_model.dart';
import 'package:jsonplaceholder_app/logic/bloc/abstract/item_list_bloc/item_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/app_error_bloc/app_error_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/loading_bloc/loading_bloc.dart';

typedef ItemModel = PhotoModel;

class PhotoListBloc extends ItemListBloc<ItemModel> {
  PhotoListBloc({
    required AppErrorBloc appErrorBloc,
    required LoadingBloc loadingBloc,
  }) : super(
          appErrorBloc: appErrorBloc,
          loadingBloc: loadingBloc,
        ) {
    on<LoadAlbumPhotosEvent>(onLoadItemList);
  }
}

@immutable
class LoadAlbumPhotosEvent extends LoadItemListEvent<ItemModel> {
  final int albumId;
  const LoadAlbumPhotosEvent({
    required super.loader,
    required this.albumId,
  });
}
