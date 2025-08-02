import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:krex/utils/string_ext.dart';

final class Secures extends ChangeNotifier {
  Secures({bool onDisk = true}) {
    _raw = onDisk ? FlutterSecureStorage() : null;
  }
  FlutterSecureStorage? _raw;

  Future<void> load() async {
    _boardedVersion = await _raw?.read(key: 'boarded_version');

    _lastUsername = await _raw?.read(key: 'last_username');
    _accessToken = await _raw?.read(key: 'access_token');

    notifyListeners();
  }

  String? _boardedVersion;
  String? get boardedVersion => _boardedVersion;
  set boardedVersion(String? value) {
    _lastUsername = value;
    _raw?.write(key: 'boarded_version', value: value);
    notifyListeners();
  }

  String? _lastUsername;
  String? get lastUsername => _lastUsername;
  set lastUsername(String? value) {
    _lastUsername = value;
    _raw?.write(key: 'last_username', value: value);
    notifyListeners();
  }

  String? _accessToken;
  String? get accessToken => _accessToken;
  set accessToken(String? value) {
    _accessToken = value;
    _raw?.write(key: 'access_token', value: value);
    notifyListeners();
  }
}

extension Ext on Secures {
  Future<bool> showOnboard(String current) async {
    final boarded = boardedVersion ?? '';
    final current = (await PackageInfo.fromPlatform()).version;
    if (boarded.isNotEmpty && current.isNotEmpty) {
      return boarded.extendedVersionNumber < current.extendedVersionNumber;
    }
    return false;
  }

  bool get showLogin => lastUsername?.isEmpty != false;
}
