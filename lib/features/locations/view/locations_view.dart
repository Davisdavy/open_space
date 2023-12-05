import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_space/features/locations/blocs/user_cubit.dart';


class LocationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);

    return Scaffold(
      body: Center(
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state.isLoading) {
              return CircularProgressIndicator();
            } else if (state.error.isNotEmpty) {
              return Text('Error: ${state.error}');
            } else {
              // Build UI using the list of users from state.users
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  // Build UI for each user
                  return ListTile(
                    title: Text(user.name),
                    // Add more details as needed
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}