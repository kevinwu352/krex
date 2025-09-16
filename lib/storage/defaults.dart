import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:hive/hive.dart';
import 'hive_ext.dart';

enum _DefaultsKeys { kThemeCodeKey, kLanguageCodeKey }

final class Defaults extends ChangeNotifier {
  late Box<Object> _box;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    if (kDebugMode) debugPrint(dir.path);
    Hive.init(join(dir.path, 'hive'));

    _box = await Hive.openBox<Object>('defaults');

    if (kDebugMode) debugPrint('${_box.toMap()}');
  }

  Future<void> load() async {
    final themeVal = _box.getString(_DefaultsKeys.kThemeCodeKey.name);
    _theme = ThemeMode.values.firstWhere((e) => e.name == themeVal, orElse: () => ThemeMode.system);

    final languageVal = _box.getList(_DefaultsKeys.kLanguageCodeKey.name)?.whereType<String>().toList() ?? [];
    _language = languageVal.isNotEmpty ? Locale(languageVal[0], languageVal.elementAtOrNull(1)) : null;
  }

  late ThemeMode _theme;
  ThemeMode get theme => _theme;
  set theme(ThemeMode value) {
    _theme = value;
    _box.setValue(_DefaultsKeys.kThemeCodeKey.name, value.name);
    notifyListeners();
  }

  Locale? _language;
  Locale? get language => _language;
  set language(Locale? value) {
    _language = value;
    final list = value is Locale ? [value.languageCode, ?value.countryCode] : null;
    _box.setValue(_DefaultsKeys.kLanguageCodeKey.name, list);
    notifyListeners();
  }
}
