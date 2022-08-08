import 'package:jsonplaceholder_app/data/api/api_client.dart';

class PhotoApi {
  Future<dynamic> getAll() async {
    var response = await ApiClient.instance()
        .dio
        .get("https://jsonplaceholder.typicode.com/photos");

    return response.data;
  }

  Future<dynamic> getForAlbum(int albumId) async {
    var response = await ApiClient.instance()
        .dio
        .get("https://jsonplaceholder.typicode.com/albums/$albumId/photos");

    return response.data;
  }
}
