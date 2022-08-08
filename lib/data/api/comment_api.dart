import 'package:jsonplaceholder_app/data/api/api_client.dart';

class CommentApi {
  Future<dynamic> getAll() async {
    var response = await ApiClient.instance()
        .dio
        .get("https://jsonplaceholder.typicode.com/comments");

    return response.data;
  }

  Future<dynamic> getForPost(int postId) async {
    var response = await ApiClient.instance()
        .dio
        .get("https://jsonplaceholder.typicode.com/posts/$postId/comments");

    return response.data;
  }

  Future<dynamic> create(dynamic data) async {
    var response = await ApiClient.instance()
        .dio
        .post("https://jsonplaceholder.typicode.com/comments", data: data);

    return response.data;
  }
}
