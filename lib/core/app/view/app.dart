import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_space/features/locations/blocs/user_cubit.dart';
import 'package:on_space/features/locations/repositories/user_repository.dart';
import 'package:on_space/features/locations/view/locations_view.dart';
import 'package:on_space/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

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
        create: ( context) => UserCubit(UserRepository('https://www.jsonkeeper.com/b/OTQQ')),
        child: LocationsView(),
      ),
    );
  }
}
