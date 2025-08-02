import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:krex/utils/secures.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:krex/home_screen.dart';

int getExtendedVer(String ver) {
  // final list = ver.split('.').map((e) => int.parse(e)).fold(0, (p, e) {
  //   print('$p $e');
  //   return p * 1000 + e;
  // });
  // print(list);

  final list = ver
      .split('.')
      .map((e) => int.parse(e))
      .fold(0, (p, e) => p * 1000 + e);
  print(list);

  return 0;
  // List versionCells = version.split('.');
  // versionCells = versionCells.map((i) => int.parse(i)).toList();
  // return versionCells[0] * 1000000 + versionCells[1] * 1000 + versionCells[2];
}

int getExtendedVersionNumber(String version) {
  List versionCells = version.split('.');
  versionCells = versionCells.map((i) => int.parse(i)).toList();
  return versionCells[0] * 1000000 + versionCells[1] * 1000 + versionCells[2];
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final secures = Secures();
  await secures.load();

  final version = (await PackageInfo.fromPlatform()).version;
  final showOnboard = await secures.showOnboard(version);
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
