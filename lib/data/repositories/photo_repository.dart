import 'package:jsonplaceholder_app/data/api/photo_api.dart';
import 'package:jsonplaceholder_app/data/models/photo_model.dart';

class PhotoRepository {
  Future<Iterable<PhotoModel>> getAll() async {
    final data = await PhotoApi().getAll();
    return (data as Iterable).map<PhotoModel>((e) => PhotoModel.fromMap(e));
  }

  Future<Iterable<PhotoModel>> getForAlbum(int albumId) async {
    final data = await PhotoApi().getForAlbum(albumId);
    return (data as Iterable).map<PhotoModel>((e) => PhotoModel.fromMap(e));
  }
}
