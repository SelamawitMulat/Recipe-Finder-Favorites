import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/recipe_detail_screen.dart';
import '../screens/profile_screen.dart'; // Import Profile
import '../screens/about_screen.dart'; // Import About

class AppRoutes {
  static const String home = '/';
  static const String favorites = '/favorites';
  static const String settings = '/settings';
  static const String recipeDetail = '/recipe-detail';
  static const String profile = '/profile';
  static const String about = '/about';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());

      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      case profile:
        return MaterialPageRoute(
            builder: (_) => const ProfileScreen()); // Updated

      case about:
        return MaterialPageRoute(
            builder: (_) => const AboutScreen()); // Updated

      case recipeDetail:
        final recipeId = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => RecipeDetailScreen(recipeId: recipeId),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route Not Found')),
          ),
        );
    }
  }
}
