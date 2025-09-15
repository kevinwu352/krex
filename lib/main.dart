import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/l10n/localizations.dart';

import '/core/core.dart';
import '/network/network.dart';
import '/storage/storage.dart';
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
        ProxyProvider<Secures, Networkable>(
          create: (context) => HttpClient.token(context.read<Secures>().accessToken),
          update: (context, value, previous) =>
              (previous is HttpClient) ? (previous..setToken(value.accessToken)) : HttpClient.token(value.accessToken),
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
