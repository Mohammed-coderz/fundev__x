import '../models/user_model.dart';
import '../services/users_fake_api.dart';

class UsersRepository {
  final UsersFakeApi api;

  UsersRepository(this.api);

  Future<List<UserModel>> getUsers() async {
    return await api.getUsers();
  }
}