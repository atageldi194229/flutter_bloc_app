import 'package:jsonplaceholder_app/data/api/api_client.dart';

class AlbumApi {
  Future<dynamic> getAll() async {
    var response = await ApiClient.instance()
        .dio
        .get("https://jsonplaceholder.typicode.com/albums");

    return response.data;
  }

  Future<dynamic> getForUser(int userId) async {
    var response = await ApiClient.instance()
        .dio
        .get("https://jsonplaceholder.typicode.com/users/$userId/albums");

    return response.data;
  }
}
