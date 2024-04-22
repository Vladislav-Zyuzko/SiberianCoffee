import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:siberian_coffee/src/features/menu/view/menu_screen.dart';
import 'package:siberian_coffee/src/theme/theme.dart';

class SiberianCoffeeApp extends StatelessWidget {
  final Map repositories;
  const SiberianCoffeeApp({super.key, required this.repositories});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.title,
      title: 'SiberianCoffee',
      theme: lightTheme,
      home: MenuScreen(repositories: repositories),
    );
  }
}
