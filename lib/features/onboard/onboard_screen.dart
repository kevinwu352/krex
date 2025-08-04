import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '/utils/storage/secures.dart';
import '/routing/routes.dart';

import '/ui/widgets/scroll_widget.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Onboard')),
      body: ScrollWidget(
        children: [
          ElevatedButton(
            onPressed: () {
              final secures = context.read<Secures>();
              secures.didOnboard();
              context.go(secures.showLogin ? Routes.login : Routes.home);
            },
            child: Text('Done'),
          ),
          ElevatedButton(
            onPressed: () {
              context.push(Routes.settings);
            },
            child: Text('settings'),
          ),
        ],
      ),
    );
  }
}
