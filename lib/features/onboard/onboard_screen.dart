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
      appBar: AppBar(
        title: Text('Onboard'),
        actions: [IconButton(onPressed: () => context.push(Routes.settings), icon: Icon(Icons.settings))],
      ),
      body: ScrollWidget(
        children: [
          Container(
            padding: EdgeInsetsGeometry.symmetric(vertical: 50),
            child: Column(children: [FlutterLogo(size: 120), SizedBox(height: 20), Text('WELCOME')]),
          ),
          SizedBox(height: 100),
          ElevatedButton(
            onPressed: () {
              final secures = context.read<Secures>();
              secures.didOnboard();
              context.go(secures.showLogin ? Routes.login : Routes.home);
            },
            child: Text('Enter'),
          ),
        ],
      ),
    );
  }
}
