
enum AppThemeMode {

  system,

  light,

  dark;

  static AppThemeMode fromString(String themeMode) {
    switch (themeMode) {
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      case 'system':
      default:
        return AppThemeMode.system;
    }
  }
}
