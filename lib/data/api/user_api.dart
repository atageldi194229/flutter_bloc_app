import 'package:jsonplaceholder_app/data/api/api_client.dart';

class UserApi {
  Future<dynamic> getAll() async {
    var response = await ApiClient.instance()
        .dio
        .get("https://jsonplaceholder.typicode.com/users");

    return response.data;
  }
}
