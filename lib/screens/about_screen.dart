import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('About App',
              style: TextStyle(fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.restaurant_menu,
                    size: 60, color: Colors.orange),
                const SizedBox(height: 12),
                const Text('Recipe Finder',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const Text('Version 1.0.0',
                    style: TextStyle(color: Colors.grey)),
                const Divider(height: 24),
                const Text(
                  'Discover, save, and organize your favorite recipes. Add personal textual notes, and manage your culinary lifestyle completely offline or online.',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.4),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text('Made for food lovers everywhere 🍳',
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.w500)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
