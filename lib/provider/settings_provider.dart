// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  String languageCode = 'en';
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDark => themeMode == ThemeMode.dark;
  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeMode =
        (prefs.getBool("theme") ?? false) ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> setTheme(ThemeMode theme) async {
    themeMode = theme;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("theme", isDark);
    notifyListeners();
  }
}
