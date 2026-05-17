import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.realBackgroundDark,
      appBar: AppBar(
        title: const Text('Settings',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.primaryCoral,
        iconTheme: const IconThemeData(
            color: Colors.white), // Ensures back arrow is visible and white
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appearance Section Card
            const Text(
              'Appearance',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackgroundDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading:
                    const Icon(Icons.dark_mode, color: AppColors.primaryCoral),
                title: const Text('Dark Mode',
                    style: TextStyle(color: Colors.white)),
                subtitle: Text(
                  themeProvider.isDarkMode ? 'Enabled' : 'Disabled',
                  style: const TextStyle(color: AppColors.textSecondaryDark),
                ),
                trailing: Switch(
                  value: themeProvider.isDarkMode,
                  activeThumbColor: AppColors.primaryCoral,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            // About Section Card
            const Text(
              'About',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackgroundDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recipe Finder',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                        color: AppColors.textSecondaryDark, fontSize: 14),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Discover, save, and organize your favorite recipes. Rate them, add personal notes, and build your perfect recipe collection.',
                    style: TextStyle(
                        color: Colors.white70, fontSize: 14, height: 1.4),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text('Made with ',
                          style: TextStyle(color: Colors.white70)),
                      Icon(Icons.favorite, color: Colors.red, size: 16),
                      Text(' for food lovers everywhere',
                          style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Bottom Motivational Gradient Card matching your screenshot layout perfectly
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryCoral, Color(0xFFFFD166)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Text(
                    'Enjoy Cooking!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Happy cooking and bon appétit! 🍳🍺',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
