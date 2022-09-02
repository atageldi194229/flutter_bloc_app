import 'package:jsonplaceholder_app/data/api/api_client.dart';

class CommentApi {
  ApiLoader getAll() => ApiLoader(
        path: "/comments",
        loader: (path) => ApiClient().dio.get(path),
      );

  ApiLoader getForPost(int postId) => ApiLoader(
        path: "/posts/$postId/comments",
        loader: (path) => ApiClient().dio.get(path),
      );

  ApiLoader create(data) => ApiLoader(
        path: "/comments",
        loader: (path) => ApiClient().dio.post(path, data: data),
      );
}
