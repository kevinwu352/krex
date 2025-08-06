import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '/features/onboard/onboard_screen.dart';
import '/features/auth/login_screen.dart';

import '/features/home/home_screen.dart';
import '/features/live/live_screen.dart';
import '/features/profile/profile_screen.dart';

import '/features/settings/settings_screen.dart';
import '/features/settings/language_screen.dart';
import '/features/settings/theme_screen.dart';

import '/features/message/message_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) => shell.goBranch(value),
        selectedIndex: shell.currentIndex,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.live_tv), label: 'Live'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: shell,
    );
  }
}

abstract final class Routes {
  static const onboard = '/onboard';
  static const login = '/login';

  static const home = '/home';
  static const live = '/live';
  static const profile = '/profile';

  static const settings = '/settings';
  static const settingsLanguage = '$settings/$_settingsLanguage';
  static const _settingsLanguage = 'language';
  static const settingsTheme = '$settings/$_settingsTheme';
  static const _settingsTheme = 'theme';

  static const message = '/message';

  // static String bookingWithId(int id) => '$booking/$id';
}

GoRouter router(bool showOnboard, bool showLogin) => GoRouter(
  initialLocation: showOnboard
      ? Routes.onboard
      : showLogin
      ? Routes.login
      : Routes.home,
  routes: [
    GoRoute(path: Routes.onboard, builder: (context, state) => OnboardScreen()),
    GoRoute(path: Routes.login, builder: (context, state) => LoginScreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => MainScreen(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [GoRoute(path: Routes.home, builder: (context, state) => HomeScreen())],
        ),
        StatefulShellBranch(
          routes: [GoRoute(path: Routes.live, builder: (context, state) => LiveScreen())],
        ),
        StatefulShellBranch(
          routes: [GoRoute(path: Routes.profile, builder: (context, state) => ProfileScreen())],
        ),
      ],
    ),
    GoRoute(
      path: Routes.settings,
      builder: (context, state) => SettingsScreen(),
      routes: [
        GoRoute(path: Routes._settingsLanguage, builder: (context, state) => LanguageScreen()),
        GoRoute(path: Routes._settingsTheme, builder: (context, state) => ThemeScreen()),
      ],
    ),
    GoRoute(
      path: Routes.message,
      builder: (context, state) => MessageScreen.create(network: context.read()),
    ),
  ],
);
