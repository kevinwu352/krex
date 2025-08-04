import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/utils/storage/secures.dart';
import '/utils/storage/defaults.dart';
import '/ui/router.dart';
import '/ui/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final secures = Secures();
  await secures.load();
  print('showOnboard:${secures.showOnboard} showLogin:${secures.showLogin}');

  final defaults = Defaults();
  await defaults.init();
  await defaults.load();

  // print(ThemeMode.dark.index);
  // print(ThemeMode.dark.name);
  // final str = 'dark';
  // final val = ThemeMode.values.firstWhere((e) => e.name == str, orElse: () => ThemeMode.light);
  // print(val);

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
    final defaults = context.watch<Defaults>();
    return MaterialApp.router(
      theme: ThemeData(colorScheme: AppThemes.lightColorScheme),
      darkTheme: ThemeData(colorScheme: AppThemes.darkColorScheme),
      themeMode: defaults.theme,
      routerConfig: router(showOnboard, showLogin),
    );
  }
}
