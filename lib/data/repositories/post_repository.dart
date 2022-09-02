import 'package:jsonplaceholder_app/data/api/post_api.dart';
import 'package:jsonplaceholder_app/data/models/post_model.dart';
import 'package:jsonplaceholder_app/data/storage/storage.dart';

class PostRepository {
  Future<Iterable<PostModel>> getAll() async {
    final apiLoader = PostApi().getAll();

    final data = await Storage().getCachedOrLoad(apiLoader);

    return (data as Iterable).map<PostModel>((e) => PostModel.fromMap(e));
  }

  Future<Iterable<PostModel>> getForUser(int userId) async {
    final apiLoader = PostApi().getForUser(userId);

    final data = await Storage().getCachedOrLoad(apiLoader);

    return (data as Iterable).map<PostModel>((e) => PostModel.fromMap(e));
  }
}
