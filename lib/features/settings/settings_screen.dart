import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          ListTile(title: Text('Language'), trailing: Icon(Icons.keyboard_arrow_right)),
          ListTile(title: Text('Theme'), trailing: Icon(Icons.keyboard_arrow_right)),
        ],
      ),
    );
  }
}
