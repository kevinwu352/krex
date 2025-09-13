import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:hive/hive.dart';
import 'hive_ext.dart';

final class Defaults extends ChangeNotifier {
  late Box<dynamic> _box;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    if (kDebugMode) debugPrint(dir.path);
    Hive.init(join(dir.path, 'hive'));

    _box = await Hive.openBox('defaults');

    if (kDebugMode) debugPrint('${_box.toMap()}');
  }

  Future<void> load() async {
    final themeVal = _box.getString('theme_code');
    _theme = ThemeMode.values.firstWhere((e) => e.name == themeVal, orElse: () => ThemeMode.system);

    final languageVal = _box.getList('language_code');
    final languageAry = languageVal is List<String> ? languageVal : List<String>.empty();
    _language = languageAry.isNotEmpty ? Locale(languageAry[0], languageAry.elementAtOrNull(1)) : null;
  }

  late ThemeMode _theme;
  ThemeMode get theme => _theme;
  set theme(ThemeMode value) {
    _theme = value;
    _box.put('theme_code', value.name);
    notifyListeners();
  }

  Locale? _language;
  Locale? get language => _language;
  set language(Locale? value) {
    _language = value;
    final list = value is Locale ? [value.languageCode, ?value.countryCode] : null;
    _box.put('language_code', list);
    notifyListeners();
  }
}
