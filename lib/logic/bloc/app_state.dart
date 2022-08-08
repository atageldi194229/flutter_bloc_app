// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;
import 'package:jsonplaceholder_app/data/error/app_error.dart';

import 'package:jsonplaceholder_app/data/models/album_model.dart';
import 'package:jsonplaceholder_app/data/models/comment_model.dart';
import 'package:jsonplaceholder_app/data/models/photo_model.dart';
import 'package:jsonplaceholder_app/data/models/post_model.dart';
import 'package:jsonplaceholder_app/data/models/user_model.dart';

@immutable
class AppState {
  final bool isLoading;
  final AppError? error;
  final Iterable<UserModel> users;
  final Iterable<AlbumModel> albums;
  final Iterable<PhotoModel> photos;
  final Iterable<PostModel> posts;
  final Iterable<CommentModel> comments;

  const AppState({
    this.error,
    required this.isLoading,
    required this.users,
    required this.albums,
    required this.photos,
    required this.posts,
    required this.comments,
  });

  @override
  bool operator ==(covariant AppState other) =>
      isLoading == other.isLoading &&
      error == other.error &&
      users.length == other.users.length &&
      albums.length == other.albums.length &&
      photos.length == other.photos.length &&
      posts.length == other.posts.length &&
      comments.length == other.comments.length;

  @override
  int get hashCode => Object.hash(
        isLoading,
        error,
        users,
        albums,
        photos,
        posts,
        comments,
      );

  AppState copyWith({
    bool? isLoading,
    AppError? error,
    Iterable<UserModel>? users,
    Iterable<AlbumModel>? albums,
    Iterable<PhotoModel>? photos,
    Iterable<PostModel>? posts,
    Iterable<CommentModel>? comments,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      users: users ?? this.users,
      albums: albums ?? this.albums,
      photos: photos ?? this.photos,
      posts: posts ?? this.posts,
      comments: comments ?? this.comments,
    );
  }
}
