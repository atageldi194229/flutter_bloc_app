import 'package:jsonplaceholder_app/data/api/post_api.dart';
import 'package:jsonplaceholder_app/data/models/post_model.dart';

class PostRepository {
  Future<Iterable<PostModel>> getAll() async {
    final data = await PostApi().getAll();
    return (data as Iterable).map<PostModel>((e) => PostModel.fromMap(e));
  }

  Future<Iterable<PostModel>> getForUser(int userId) async {
    final data = await PostApi().getForUser(userId);
    return (data as Iterable).map<PostModel>((e) => PostModel.fromMap(e));
  }
}
