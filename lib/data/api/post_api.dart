import 'package:jsonplaceholder_app/data/api/api_client.dart';

class PostApi {
  ApiLoader getAll() => ApiLoader(
        path: "/posts",
        loader: (path) => ApiClient().dio.get(path),
      );

  ApiLoader getForUser(int userId) => ApiLoader(
        path: "/users/$userId/posts",
        loader: (path) => ApiClient().dio.get(path),
      );
}
