import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/utils/storage/defaults.dart';

class ThemeScreen extends StatelessWidget {
  ThemeScreen({super.key});

  final items = ThemeMode.values.map((e) => _Item(name: e.name, value: e)).toList();

  @override
  Widget build(BuildContext context) {
    final defaults = context.read<Defaults>();
    return Scaffold(
      appBar: AppBar(title: Text('Theme')),
      body: ListView.separated(
        itemCount: items.length + 1,
        separatorBuilder: (context, index) => Divider(thickness: 0),
        itemBuilder: (context, index) {
          if (index < items.length) {
            final item = items[index];
            return ListTile(
              title: Text(item.name),
              trailing: item.value == defaults.theme ? Icon(Icons.check) : null,
              onTap: () => defaults.theme = item.value,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class _Item {
  const _Item({required this.name, required this.value});
  final String name;
  final ThemeMode value;
}
