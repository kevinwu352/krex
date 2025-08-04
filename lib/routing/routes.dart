abstract final class Routes {
  static const onboard = '/onboard';
  static const login = '/login';

  static const home = '/home';
  static const live = '/live';
  static const profile = '/profile';

  static const settings = '/settings';
  static const settingsLanguage = '$settings/$settingsLanguageRel';
  static const settingsLanguageRel = 'language';
  static const settingsTheme = '$settings/$settingsThemeRel';
  static const settingsThemeRel = 'theme';

  // static String bookingWithId(int id) => '$booking/$id';
}
