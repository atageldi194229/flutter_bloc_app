import 'package:jsonplaceholder_app/data/api/album_api.dart';
import 'package:jsonplaceholder_app/data/models/album_model.dart';
import 'package:jsonplaceholder_app/data/storage/storage.dart';

class AlbumRepository {
  Future<Iterable<AlbumModel>> getAll() async {
    final apiLoader = AlbumApi().getAll();

    final data = await Storage().getCachedOrLoad(apiLoader);

    return (data as Iterable).map<AlbumModel>((e) => AlbumModel.fromMap(e));
  }

  Future<Iterable<AlbumModel>> getForUser(int userId) async {
    final apiLoader = AlbumApi().getForUser(userId);

    final data = await Storage().getCachedOrLoad(apiLoader);

    return (data as Iterable).map<AlbumModel>((e) => AlbumModel.fromMap(e));
  }
}
