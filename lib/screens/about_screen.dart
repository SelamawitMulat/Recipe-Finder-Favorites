import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.realBackgroundDark,
      appBar: AppBar(
        title: const Text('About App', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryCoral,
        iconTheme: const IconThemeData(
            color: Colors.white), // Makes the back arrow white
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Recipe Finder v1.0.0',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
