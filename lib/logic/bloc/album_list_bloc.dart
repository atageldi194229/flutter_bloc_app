import 'package:flutter/foundation.dart' show immutable;
import 'package:jsonplaceholder_app/data/models/album_model.dart';
import 'package:jsonplaceholder_app/data/repositories/photo_repository.dart';
import 'package:jsonplaceholder_app/logic/bloc/abstract/item_list_bloc/item_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/app_error_bloc/app_error_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/loading_bloc/loading_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/photo_list_bloc.dart';

typedef ItemModel = AlbumModel;

class AlbumListBloc extends ItemListBloc<ItemModel> {
  final PhotoListBloc photoListBloc;

  AlbumListBloc({
    required AppErrorBloc appErrorBloc,
    required LoadingBloc loadingBloc,
    required this.photoListBloc,
  }) : super(
          appErrorBloc: appErrorBloc,
          loadingBloc: loadingBloc,
        ) {
    on<LoadUserAlbumsEvent>(
      (event, emit) async {
        await onLoadItemList(event, emit);

        for (var album in state.list) {
          photoListBloc.add(
            LoadAlbumPhotosEvent(
              loader: () => PhotoRepository().getForAlbum(album.id),
              albumId: album.id,
            ),
          );
        }
      },
    );
  }
}

@immutable
class LoadUserAlbumsEvent extends LoadItemListEvent<ItemModel> {
  final int userId;
  const LoadUserAlbumsEvent({
    required super.loader,
    required this.userId,
  });
}
