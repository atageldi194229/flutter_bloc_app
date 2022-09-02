import 'package:jsonplaceholder_app/data/api/api_client.dart';

class AlbumApi {
  ApiLoader getAll() => ApiLoader(
        path: "/albums",
        loader: (path) => ApiClient().dio.get(path),
      );

  ApiLoader getForUser(int userId) => ApiLoader(
        path: "/users/$userId/albums",
        loader: (path) => ApiClient().dio.get(path),
      );
}
