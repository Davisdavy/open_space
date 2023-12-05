import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_space/user/user.dart';
import 'package:on_space/l10n/l10n.dart';

class App extends StatelessWidget {
   App({super.key});
  final UserCubit _userCubit = UserCubit();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider(
        create: (_) => UserCubit()..fetchUsers(),
        child: UserView(userCubit: _userCubit,),
      ),
    );
  }
}
