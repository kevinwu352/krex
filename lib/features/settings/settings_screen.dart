import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '/storage/secures.dart';
import '/ui/router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  final items = const [
    _Item(name: 'Language', value: Routes.settingsLanguage),
    _Item(name: 'Theme', value: Routes.settingsTheme),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            onPressed: () {
              final secures = context.read<Secures>();
              secures.boardedVersion = null;
              context.go(Routes.onboard);
            },
            icon: Icon(Icons.slideshow),
          ),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(thickness: 0),
        itemBuilder: (context, index) => index < items.length
            ? ListTile(
                title: Text(items[index].name),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () => context.push(items[index].value),
              )
            : Container(),
        itemCount: items.length + 1,
      ),
    );
  }
}

class _Item {
  const _Item({required this.name, required this.value});
  final String name;
  final String value;
}
