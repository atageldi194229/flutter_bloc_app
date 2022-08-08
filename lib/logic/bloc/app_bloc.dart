import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jsonplaceholder_app/data/error/app_error.dart';
import 'package:jsonplaceholder_app/data/models/abstract_model.dart';
import 'package:jsonplaceholder_app/data/models/album_model.dart';
import 'package:jsonplaceholder_app/data/models/comment_model.dart';
import 'package:jsonplaceholder_app/data/models/photo_model.dart';
import 'package:jsonplaceholder_app/data/models/post_model.dart';
import 'package:jsonplaceholder_app/data/models/user_model.dart';
import 'package:jsonplaceholder_app/logic/bloc/app_event.dart';
import 'package:jsonplaceholder_app/logic/bloc/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  late LazyBox box;
  AppBloc()
      : super(const AppState(
          isLoading: false,
          users: [],
          albums: [],
          photos: [],
          posts: [],
          comments: [],
        )) {
    box = Hive.lazyBox("appBox");

    on<LoadUsersEvent>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
        error: null,
      ));

      try {
        final key = event.path;
        late Iterable<UserModel> users;

        if (!box.containsKey(key)) {
          String value = await box.get(key);
          users = (jsonDecode(value) as List).map(
            (e) => UserModel.fromJson(e),
          );

          emit(state.copyWith(
            isLoading: false,
            users: users,
          ));
        }

        users = await event.loader();
        box.put(key, jsonEncode(users.toList()));

        emit(state.copyWith(
          isLoading: false,
          users: users,
        ));
      } catch (_) {
        emit(state.copyWith(
          isLoading: false,
          error: const LoadError(),
        ));
      }
    });

    on<LoadUserAlbumsEvent>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
        error: null,
      ));

      try {
        final key = event.path;
        late Iterable<AlbumModel> items;

        if (box.containsKey(key)) {
          String value = await box.get(key);
          items = (jsonDecode(value) as List).map(
            (e) => AlbumModel.fromJson(e),
          );

          emit(state.copyWith(
            isLoading: false,
            albums: items,
          ));
        }

        items = await event.loader(event.userId);
        box.put(key, jsonEncode(items.toList()));

        emit(state.copyWith(
          isLoading: false,
          albums: items,
        ));
      } catch (_) {
        emit(state.copyWith(
          isLoading: false,
          error: const LoadError(),
        ));
      }
    });

    on<LoadUserPostsEvent>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
        error: null,
      ));

      try {
        final key = event.path;
        late Iterable<PostModel> items;

        if (box.containsKey(key)) {
          String value = await box.get(key);
          items = (jsonDecode(value) as List).map(
            (e) => PostModel.fromJson(e),
          );

          emit(state.copyWith(
            isLoading: false,
            posts: items,
          ));
        }

        items = await event.loader(event.userId);
        box.put(key, jsonEncode(items.toList()));

        emit(state.copyWith(
          isLoading: false,
          posts: items,
        ));
      } catch (_) {
        emit(state.copyWith(
          isLoading: false,
          error: const LoadError(),
        ));
      }
    });

    on<LoadAlbumPhotosEvent>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
        error: null,
      ));

      try {
        final key = event.path;
        late Iterable<PhotoModel> items;

        if (box.containsKey(key)) {
          String value = await box.get(key);
          items = (jsonDecode(value) as List).map(
            (e) => PhotoModel.fromJson(e),
          );

          emit(state.copyWith(
            isLoading: false,
            photos: items,
          ));
        }

        items = await event.loader(event.albumId);
        box.put(key, jsonEncode(items.toList()));

        emit(state.copyWith(
          isLoading: false,
          photos: items,
        ));
      } catch (_) {
        emit(state.copyWith(
          isLoading: false,
          error: const LoadError(),
        ));
      }
    });

    on<LoadPostCommentsEvent>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
        error: null,
      ));

      try {
        final key = event.path;
        late Iterable<CommentModel> items;

        if (box.containsKey(key)) {
          String value = await box.get(key);
          items = (jsonDecode(value) as List).map(
            (e) => CommentModel.fromJson(e),
          );

          emit(state.copyWith(
            isLoading: false,
            comments: items,
          ));
        }

        items = await event.loader(event.postId);
        box.put(key, jsonEncode(items.toList()));

        emit(state.copyWith(
          isLoading: false,
          comments: items,
        ));
      } catch (_) {
        emit(state.copyWith(
          isLoading: false,
          error: const LoadError(),
        ));
      }
    });
  }
}
