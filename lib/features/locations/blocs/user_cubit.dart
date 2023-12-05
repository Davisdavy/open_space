
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:on_space/features/locations/models/user.dart';
import 'package:on_space/features/locations/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepository) : super(UserState.initial());

  final UserRepository userRepository;

  Future<void> getUsers() async {
    try {
      emit(state.copyWith(isLoading: true, error: ''));

      final users = await userRepository.getUsers();

      emit(state.copyWith(users: users, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Failed to fetch users'));
    }
  }
}