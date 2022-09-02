import 'package:jsonplaceholder_app/data/api/photo_api.dart';
import 'package:jsonplaceholder_app/data/models/photo_model.dart';
import 'package:jsonplaceholder_app/data/storage/storage.dart';

class PhotoRepository {
  Future<Iterable<PhotoModel>> getAll() async {
    final apiLoader = PhotoApi().getAll();

    final data = await Storage().getCachedOrLoad(apiLoader);

    return (data as Iterable).map<PhotoModel>((e) => PhotoModel.fromMap(e));
  }

  Future<Iterable<PhotoModel>> getForAlbum(int albumId) async {
    final apiLoader = PhotoApi().getForAlbum(albumId);

    final data = await Storage().getCachedOrLoad(apiLoader);

    return (data as Iterable).map<PhotoModel>((e) => PhotoModel.fromMap(e));
  }
}
