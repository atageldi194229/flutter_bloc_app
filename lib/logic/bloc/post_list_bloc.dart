import 'package:flutter/foundation.dart' show immutable;
import 'package:jsonplaceholder_app/data/models/post_model.dart';
import 'package:jsonplaceholder_app/logic/bloc/abstract/item_list_bloc/item_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/app_error_bloc/app_error_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/loading_bloc/loading_bloc.dart';

typedef ItemModel = PostModel;

class PostListBloc extends ItemListBloc<ItemModel> {
  PostListBloc({
    required AppErrorBloc appErrorBloc,
    required LoadingBloc loadingBloc,
  }) : super(
          appErrorBloc: appErrorBloc,
          loadingBloc: loadingBloc,
        ) {
    on<LoadUserPostsEvent>(onLoadItemList);
  }

  @override
  ItemModel getItemFromJson(e) => ItemModel.fromJson(e);
}

@immutable
class LoadUserPostsEvent extends LoadItemListEvent<ItemModel> {
  final int userId;
  const LoadUserPostsEvent({
    required super.loader,
    required this.userId,
  });

  @override
  String get path => "users/$userId/posts";
}
