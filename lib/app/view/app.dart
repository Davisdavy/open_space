import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_space/features/location_history/user.dart';
import 'package:on_space/l10n/l10n.dart';
import 'package:on_space/widgets/bottom_navigation_widget.dart';

class App extends StatelessWidget {
   const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider(
        create: (_) => LocationCubit(),
        child:const  BottomNavigationWidget(),
      ),
    );
  }
}
