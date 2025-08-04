import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/l10n/app_localizations.dart';
import '/utils/storage/defaults.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});

  final items = AppLocalizations.supportedLocales.map((e) => _Item(name: e.toLanguageTag(), value: e)).toList();

  @override
  Widget build(BuildContext context) {
    final defaults = context.read<Defaults>();
    return Scaffold(
      appBar: AppBar(title: Text('Language')),
      body: ListView.separated(
        itemCount: items.length + 1,
        separatorBuilder: (context, index) => Divider(thickness: 0),
        itemBuilder: (context, index) {
          if (index < items.length) {
            final item = items[index];
            return ListTile(
              title: Text(item.name),
              trailing: item.value == defaults.language ? Icon(Icons.check) : null,
              onTap: () => defaults.language = item.value,
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
  final Locale value;
}
