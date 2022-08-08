import 'package:jsonplaceholder_app/data/api/album_api.dart';
import 'package:jsonplaceholder_app/data/models/album_model.dart';

class AlbumRepository {
  Future<Iterable<AlbumModel>> getAll() async {
    final data = await AlbumApi().getAll();
    return (data as Iterable).map<AlbumModel>((e) => AlbumModel.fromMap(e));
  }

  Future<Iterable<AlbumModel>> getForUser(int userId) async {
    final data = await AlbumApi().getForUser(userId);
    return (data as Iterable).map<AlbumModel>((e) => AlbumModel.fromMap(e));
  }
}
