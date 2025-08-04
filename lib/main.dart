import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/utils/storage/secures.dart';
import '/utils/storage/defaults.dart';
import '/ui/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final secures = Secures();
  await secures.load();
  print('showOnboard:${secures.showOnboard} showLogin:${secures.showLogin}');

  final defaults = Defaults();
  await defaults.init();
  await defaults.load();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: secures)],
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
    return MaterialApp.router(routerConfig: router(showOnboard, showLogin));
  }
}
