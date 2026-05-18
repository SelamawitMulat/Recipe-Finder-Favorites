import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.dark;

  ThemeMode get currentTheme => _currentTheme;
  bool get isDarkMode => _currentTheme == ThemeMode.dark;

  void toggleTheme(bool value) {
    _currentTheme = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
