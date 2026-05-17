import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.realBackgroundDark,
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryCoral,
        iconTheme: const IconThemeData(
            color: Colors.white), // Makes the back arrow white
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Profile Details Coming Soon',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
