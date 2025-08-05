import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const currentAppVersion = '0.1.0';

final class Secures extends ChangeNotifier {
  Secures({bool onDisk = true}) {
    _raw = onDisk ? FlutterSecureStorage() : null;
  }
  FlutterSecureStorage? _raw;

  Future<void> load() async {
    kDebugMode ? print(await _raw?.readAll()) : null;

    _boardedVersion = await _raw?.read(key: 'boarded_version');

    _lastUsername = await _raw?.read(key: 'last_username');
    _accessToken = await _raw?.read(key: 'access_token');
  }

  String? _boardedVersion;
  String? get boardedVersion => _boardedVersion;
  set boardedVersion(String? value) {
    _boardedVersion = value;
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

extension SecuresExt on Secures {
  bool get showOnboard {
    final boarded = boardedVersion ?? '';
    if (boarded.isEmpty) {
      return true;
    } else {
      final current = currentAppVersion;
      if (current.isNotEmpty) {
        return boarded.versionNum < current.versionNum;
      }
    }
    return false;
  }

  void didOnboard() {
    boardedVersion = currentAppVersion;
  }

  bool get showLogin => (lastUsername ?? '').isEmpty;
}

extension StringVersion on String {
  // '1.2.3' => 1002003
  int get versionNum => split('.').map((e) => int.parse(e)).fold(0, (p, e) => p * 1000 + e);
}
