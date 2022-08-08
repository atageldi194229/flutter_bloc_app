import 'package:jsonplaceholder_app/data/api/user_api.dart';
import 'package:jsonplaceholder_app/data/models/user_model.dart';

class UserRepository {
  Future<Iterable<UserModel>> getAll() async {
    final data = await UserApi().getAll();
    return (data as Iterable).map<UserModel>((e) => UserModel.fromMap(e));
  }
}
