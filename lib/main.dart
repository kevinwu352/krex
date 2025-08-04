import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/l10n/app_localizations.dart';

import '/storage/secures.dart';
import '/storage/defaults.dart';
import '/ui/router.dart';
import '/ui/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final secures = Secures();
  await secures.load();

  final defaults = Defaults();
  await defaults.init();
  await defaults.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: secures),
        ChangeNotifierProvider.value(value: defaults),
      ],
      child: MyApp(showOnboard: secures.showOnboard, showLogin: secures.showLogin),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.showOnboard, required this.showLogin});

  final bool showOnboard;
  final bool showLogin;

  @override
  Widget build(BuildContext context) {
    final language = context.select((Defaults v) => v.language);
    final theme = context.select((Defaults v) => v.theme);
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: language,
      theme: ThemeData(colorScheme: AppThemes.lightColorScheme),
      darkTheme: ThemeData(colorScheme: AppThemes.darkColorScheme),
      themeMode: theme,
      routerConfig: router(showOnboard, showLogin),
    );
  }
}
