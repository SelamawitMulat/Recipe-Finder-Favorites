import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../core/constants/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.realBackgroundDark,
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primaryCoral),
            child: Center(
              child: Text(
                '🎛 Recipe Dashboard',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.home),
          ),
          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.white),
            title:
                const Text('Favorites', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushNamed(context, AppRoutes.favorites),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text('Profile', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title:
                const Text('Settings', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.white),
            title:
                const Text('About App', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushNamed(context, AppRoutes.about),
          ),
        ],
      ),
    );
  }
}
