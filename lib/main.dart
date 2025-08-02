import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:krex/utils/secures.dart';

import 'package:krex/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final secures = Secures();
  await secures.load();

  final showOnboard = await secures.showOnboard();
  final showLogin = secures.showLogin;
  print('showOnboard:$showOnboard showLogin:$showLogin');

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: secures)],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}
