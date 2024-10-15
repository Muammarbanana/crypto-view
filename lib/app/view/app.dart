import 'package:crypto_view/core/core.dart';
import 'package:crypto_view/core/utils/injection_containers.dart';
import 'package:crypto_view/features/features.dart';
import 'package:crypto_view/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<CustomThemeCubit>(),
      child: BlocBuilder<CustomThemeCubit, bool>(
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            theme: switch (state) {
              true => CustomTheme.getDark(),
              false => CustomTheme.getLight()
            },
            home: const WatchlistPage(),
          );
        },
      ),
    );
  }
}
