import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/utils/secures.dart';
import '/utils/defaults.dart';
import '/routing/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final secures = Secures();
  await secures.load();

  final showOnboard = await secures.showOnboard();
  final showLogin = secures.showLogin;
  print('showOnboard:$showOnboard showLogin:$showLogin');

  final defaults = Defaults();
  await defaults.init();
  await defaults.load();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: secures)],
      child: MyApp(showOnboard: showOnboard, showLogin: showLogin),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.showOnboard, required this.showLogin});

  final bool showOnboard;
  final bool showLogin;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router(showOnboard, showLogin));
  }
}
