import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/l10n/app_localizations.dart';

import '/storage/secures.dart';
import '/storage/defaults.dart';
import '/network/http_client.dart';
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
        ProxyProvider<Secures, HttpClient>(
          create: (context) => HttpClient.token(token: context.read<Secures>().accessToken),
          update: (context, value, previous) =>
              (previous?..setToken(value.accessToken)) ?? HttpClient.token(token: value.accessToken),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final secures = context.read<Secures>();
    final language = context.select((Defaults v) => v.language);
    final theme = context.select((Defaults v) => v.theme);
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: language,
      theme: ThemeData(colorScheme: AppThemes.lightColorScheme),
      darkTheme: ThemeData(colorScheme: AppThemes.darkColorScheme),
      themeMode: theme,
      routerConfig: router(secures.showOnboard, secures.showLogin),
    );
  }
}
