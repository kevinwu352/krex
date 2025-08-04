import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/routing/routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  final items = const [
    _Item(name: 'Language', route: Routes.settingsLanguage),
    _Item(name: 'Theme', route: Routes.settingsTheme),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(thickness: 0),
        itemBuilder: (context, index) => index < items.length
            ? ListTile(
                title: Text(items[index].name),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () => context.push(items[index].route),
              )
            : Container(),
        itemCount: items.length + 1,
      ),
    );
  }
}

class _Item {
  const _Item({required this.name, required this.route});
  final String name;
  final String route;
}
