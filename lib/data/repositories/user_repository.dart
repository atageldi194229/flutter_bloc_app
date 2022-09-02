import 'package:jsonplaceholder_app/data/api/user_api.dart';
import 'package:jsonplaceholder_app/data/models/user_model.dart';
import 'package:jsonplaceholder_app/data/storage/storage.dart';

class UserRepository {
  Future<Iterable<UserModel>> getAll() async {
    final apiLoader = UserApi().getAll();

    final data = await Storage().getCachedOrLoad(apiLoader);

    return (data as Iterable).map<UserModel>((e) => UserModel.fromMap(e));
  }
}
