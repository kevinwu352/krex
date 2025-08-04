import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:hive/hive.dart';

final class Defaults extends ChangeNotifier {
  late Box<dynamic> _box;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    print(dir.path);
    Hive.init(join(dir.path, 'hive'));

    _box = await Hive.openBox('defaults');
  }

  Future<void> load() async {
    final themeVal = _box.get('theme_code');
    final themeStr = themeVal is String ? themeVal : null;
    _theme = ThemeMode.values.firstWhere((e) => e.name == themeStr, orElse: () => ThemeMode.system);

    final languageVal = _box.get('language_code');
    _language = languageVal is String ? languageVal : null;

    notifyListeners();
  }

  late ThemeMode _theme;
  ThemeMode get theme => _theme;
  set theme(ThemeMode value) {
    _theme = value;
    _box.put('theme_code', value.name);
    notifyListeners();
  }

  String? _language;
  String? get language => _language;
  set language(String? value) {
    _language = value;
    _box.put('language_code', value);
    notifyListeners();
  }
}
