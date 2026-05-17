import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryCoral,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryCoral,
        secondary: AppColors.accentOrange,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.realBackgroundDark,
      primaryColor: AppColors.primaryCoral,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryCoral,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryCoral,
        surface: AppColors.cardBackgroundDark,
        background: AppColors.realBackgroundDark,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: AppColors.textSecondaryDark),
      ),
    );
  }
}
