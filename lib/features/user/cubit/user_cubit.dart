import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:on_space/features/user/models/user.dart';

abstract class UserEvent {}

class FetchUsersEvent extends UserEvent {}

abstract class UserState {}

class InitialUserState extends UserState {}

class LoadingUserState extends UserState {}

class LoadedUserState extends UserState {
  LoadedUserState(this.users);
  final List<User> users;
  
}

class ErrorUserState extends UserState {
  ErrorUserState(this.message);
  final String message;
 
}

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(InitialUserState());

  Future<void> fetchUsers() async {
    try {
      emit(LoadingUserState());
      final response = await http.get(Uri.parse('https://www.jsonkeeper.com/b/OTQQ'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List<dynamic>;
        final users =
        jsonData.map((json) => User.fromJson(json as Map<String, dynamic>))
            .toList();
        emit(LoadedUserState(users));
      } else {
        emit(ErrorUserState('Failed to fetch users'));
      }
    } catch (e) {
      emit(ErrorUserState('Failed to fetch users'));
    }
  }
}
