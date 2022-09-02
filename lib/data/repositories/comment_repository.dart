import 'package:jsonplaceholder_app/data/api/comment_api.dart';
import 'package:jsonplaceholder_app/data/models/comment_model.dart';
import 'package:jsonplaceholder_app/data/storage/storage.dart';

class CommentRepository {
  Future<Iterable<CommentModel>> getAll() async {
    final apiLoader = CommentApi().getAll();

    final data = await Storage().getCachedOrLoad(apiLoader);

    return (data as Iterable).map<CommentModel>((e) => CommentModel.fromMap(e));
  }

  Future<CommentModel> create(CommentModel comment) async {
    final apiLoader = CommentApi().create(comment.toMap());

    final data = await Storage().getCachedOrLoad(apiLoader);

    return CommentModel.fromMap(data);
  }

  Future<Iterable<CommentModel>> getForPost(int albumId) async {
    final apiLoader = CommentApi().getForPost(albumId);

    final data = await Storage().getCachedOrLoad(apiLoader);

    return (data as Iterable).map<CommentModel>((e) => CommentModel.fromMap(e));
  }
}
