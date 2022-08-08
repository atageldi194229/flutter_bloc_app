import 'package:jsonplaceholder_app/data/api/api_client.dart';

class PostApi {
  Future<dynamic> getAll() async {
    var response = await ApiClient.instance()
        .dio
        .get("https://jsonplaceholder.typicode.com/posts");

    return response.data;
  }

  Future<dynamic> getForUser(int userId) async {
    var response = await ApiClient.instance()
        .dio
        .get("https://jsonplaceholder.typicode.com/users/$userId/posts");

    return response.data;
  }
}
