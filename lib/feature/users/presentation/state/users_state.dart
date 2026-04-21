import '../../data/models/user_model.dart';

class UsersState {
  final bool isLoading;
  final List<UserModel> users;
  final String? errorMessage;

  const UsersState({
    required this.isLoading,
    required this.users,
    required this.errorMessage,
  });

  factory UsersState.initial() {
    return const UsersState(
      isLoading: false,
      users: [],
      errorMessage: null,
    );
  }

  UsersState copyWith({
    bool? isLoading,
    List<UserModel>? users,
    String? errorMessage,
    bool clearError = false,
  }) {
    return UsersState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}