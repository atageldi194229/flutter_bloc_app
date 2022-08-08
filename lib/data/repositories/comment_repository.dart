import 'package:jsonplaceholder_app/data/api/comment_api.dart';
import 'package:jsonplaceholder_app/data/models/comment_model.dart';

class CommentRepository {
  Future<Iterable<CommentModel>> getAll() async {
    final data = await CommentApi().getAll();
    return (data as Iterable).map<CommentModel>((e) => CommentModel.fromMap(e));
  }

  Future<CommentModel> create(CommentModel comment) async {
    final data = await CommentApi().create(comment.toMap());
    return CommentModel.fromMap(data);
  }
}
