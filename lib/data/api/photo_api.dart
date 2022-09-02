import 'package:jsonplaceholder_app/data/api/api_client.dart';

class PhotoApi {
  ApiLoader getAll() => ApiLoader(
        path: "/photos",
        loader: (path) => ApiClient().dio.get(path),
      );

  ApiLoader getForAlbum(int albumId) => ApiLoader(
        path: "/albums/$albumId/photos",
        loader: (path) => ApiClient().dio.get(path),
      );
}
