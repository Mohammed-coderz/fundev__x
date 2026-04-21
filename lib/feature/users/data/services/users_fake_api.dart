import 'dart:math';
import '../models/user_model.dart';

class UsersFakeApi {
  Future<List<UserModel>> getUsers() async {
    await Future.delayed(const Duration(seconds: 2));

    final random = Random();

    // مرة ينجح ومرة يفشل للتجربة
    if (random.nextBool()) {
      return const [
        UserModel(id: 1, name: 'Mohammad', email: 'mohammad@email.com'),
        UserModel(id: 2, name: 'Ahmad', email: 'ahmad@email.com'),
        UserModel(id: 3, name: 'Sara', email: 'sara@email.com'),
        UserModel(id: 4, name: 'Lina', email: 'lina@email.com'),
      ];
    } else {
      throw Exception('Failed to load users');
    }
  }
}