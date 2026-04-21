import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/repositories/users_repository.dart';
import '../../data/services/users_fake_api.dart';
import '../state/users_state.dart';

final usersFakeApiProvider = Provider<UsersFakeApi>((ref) {
  return UsersFakeApi();
});

final usersRepositoryProvider = Provider<UsersRepository>((ref) {
  final api = ref.read(usersFakeApiProvider);
  return UsersRepository(api);
});

final usersProvider =
StateNotifierProvider<UsersNotifier, UsersState>((ref) {
  final repository = ref.read(usersRepositoryProvider);
  return UsersNotifier(repository);
});

class UsersNotifier extends StateNotifier<UsersState> {
  final UsersRepository repository;

  UsersNotifier(this.repository) : super(UsersState.initial());

  Future<void> loadUsers() async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      final users = await repository.getUsers();

      state = state.copyWith(
        isLoading: false,
        users: users,
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        users: [],
        errorMessage: e.toString(),
      );
    }
  }

  void reset() {
    state = UsersState.initial();
  }
}