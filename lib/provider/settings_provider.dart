// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  String languageCode = 'en';
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDark => themeMode == ThemeMode.dark;
  void setTheme(ThemeMode theme) {
    themeMode = theme;
    notifyListeners();
  }
}
