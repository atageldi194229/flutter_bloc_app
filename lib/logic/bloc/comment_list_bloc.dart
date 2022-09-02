import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:jsonplaceholder_app/data/error/app_error.dart';
import 'package:jsonplaceholder_app/data/models/comment_model.dart';
import 'package:jsonplaceholder_app/logic/bloc/abstract/item_list_bloc/item_list_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/app_error_bloc/app_error_bloc.dart';
import 'package:jsonplaceholder_app/logic/bloc/loading_bloc/loading_bloc.dart';

typedef ItemModel = CommentModel;

class CommentListBloc extends ItemListBloc<ItemModel> {
  CommentListBloc({
    required AppErrorBloc appErrorBloc,
    required LoadingBloc loadingBloc,
  }) : super(
          appErrorBloc: appErrorBloc,
          loadingBloc: loadingBloc,
        ) {
    on<LoadPostCommentsEvent>(onLoadItemList);

    on<CreatePostCommentEvent>(
      (event, emit) async {
        try {
          loadingBloc.add(const StartLoadingEvent());

          await event.loader();

          loadingBloc.add(const StopLoadingEvent());
        } on DioError catch (_) {
          appErrorBloc.add(const AppErrorAddEvent(LoadError()));
        } catch (_) {
          appErrorBloc.add(const AppErrorAddEvent(LoadError()));
        }
      },
    );
  }
}

@immutable
class LoadPostCommentsEvent extends LoadItemListEvent<ItemModel> {
  final int postId;
  const LoadPostCommentsEvent({
    required super.loader,
    required this.postId,
  });
}

@immutable
class CreatePostCommentEvent extends ItemListEvent<ItemModel> {
  final Future<void> Function() loader;
  const CreatePostCommentEvent({
    required this.loader,
  });
}
