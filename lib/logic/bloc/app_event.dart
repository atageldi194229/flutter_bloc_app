import 'package:flutter/foundation.dart' show immutable;
import 'package:jsonplaceholder_app/data/models/album_model.dart';
import 'package:jsonplaceholder_app/data/models/comment_model.dart';
import 'package:jsonplaceholder_app/data/models/photo_model.dart';
import 'package:jsonplaceholder_app/data/models/post_model.dart';
import 'package:jsonplaceholder_app/data/models/user_model.dart';

typedef UsersLoader = Future<Iterable<UserModel>> Function();
typedef AlbumsLoader = Future<Iterable<AlbumModel>> Function(int userId);
typedef PhotosLoader = Future<Iterable<PhotoModel>> Function(int albumId);
typedef PostsLoader = Future<Iterable<PostModel>> Function(int userId);
typedef CommentsLoader = Future<Iterable<CommentModel>> Function(int postId);

@immutable
class AppEvent {
  const AppEvent();
}

@immutable
class AppEventInitialize extends AppEvent {
  const AppEventInitialize();
}

@immutable
class LoadUsersEvent extends AppEvent {
  final UsersLoader loader;

  const LoadUsersEvent({
    required this.loader,
  }) : super();

  String get path => "/users";
}

@immutable
class LoadUserAlbumsEvent extends AppEvent {
  final AlbumsLoader loader;
  final int userId;

  const LoadUserAlbumsEvent({
    required this.loader,
    required this.userId,
  }) : super();

  String get path => "users/$userId/albums";
}

@immutable
class LoadAlbumPhotosEvent extends AppEvent {
  final PhotosLoader loader;
  final int albumId;

  const LoadAlbumPhotosEvent({
    required this.loader,
    required this.albumId,
  }) : super();

  String get path => "albums/$albumId/photos";
}

@immutable
class LoadUserPostsEvent extends AppEvent {
  final PostsLoader loader;
  final int userId;

  const LoadUserPostsEvent({
    required this.loader,
    required this.userId,
  }) : super();

  String get path => "users/$userId/posts";
}

@immutable
class LoadPostCommentsEvent extends AppEvent {
  final CommentsLoader loader;
  final int postId;

  const LoadPostCommentsEvent({
    required this.loader,
    required this.postId,
  }) : super();

  String get path => "posts/$postId/comments";
}


// @immutable
// class LoadUsersEvent extends AppEvent {
//   final HiveBoxKey boxKey = HiveBoxKey.users;
//   final UsersLoader loader;

//   const LoadUsersEvent({
//     required this.loader,
//   }) : super();
// }

// @immutable
// class LoadAlbumsEvent extends AppEvent {
//   final HiveBoxKey boxKey = HiveBoxKey.albums;
//   final AlbumsLoader loader;

//   const LoadAlbumsEvent({
//     required this.loader,
//   }) : super();
// }

// @immutable
// class LoadPhotosEvent extends AppEvent {
//   final HiveBoxKey boxKey = HiveBoxKey.photos;
//   final PhotosLoader loader;

//   const LoadPhotosEvent({
//     required this.loader,
//   }) : super();
// }

// @immutable
// class LoadPostsEvent extends AppEvent {
//   final HiveBoxKey boxKey = HiveBoxKey.posts;
//   final PostsLoader loader;

//   const LoadPostsEvent({
//     required this.loader,
//   }) : super();
// }

// @immutable
// class LoadCommentsEvent extends AppEvent {
//   final HiveBoxKey boxKey = HiveBoxKey.comments;
//   final CommentsLoader loader;

//   const LoadCommentsEvent({
//     required this.loader,
//   }) : super();
// }
