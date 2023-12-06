import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_space/features/user/cubit/user_cubit.dart';

class UserView extends StatelessWidget {
  const UserView({required this.userCubit, super.key});

  final UserCubit userCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is LoadingUserState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedUserState) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text('User ID: ${user.id}'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                  ),
                );
              },
            );
          } else if (state is ErrorUserState) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}

