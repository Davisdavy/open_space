part of 'user_cubit.dart';

class UserState extends Equatable {
  const UserState({
    required this.users,
    required this.isLoading,
    required this.error,
  });

  factory UserState.initial() {
    return const UserState(
      users: [],
      isLoading: false,
      error: '',
    );
  }

  final List<User> users;
  final bool isLoading;
  final String error;

  UserState copyWith({
    List<User>? users,
    bool? isLoading,
    String? error,
  }) {
    return UserState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [users, isLoading, error];
}