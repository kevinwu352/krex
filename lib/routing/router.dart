import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

import '/features/onboard/onboard_screen.dart';
import '/features/auth/login_screen.dart';

import '/features/home/home_screen.dart';
import '/features/live/live_screen.dart';
import '/features/profile/profile_screen.dart';

import '/features/settings/settings_screen.dart';

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
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) => HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.live,
              builder: (context, state) => LiveScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.profile,
              builder: (context, state) => ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: Routes.settings,
      builder: (context, state) => SettingsScreen(),
    ),
  ],
);
