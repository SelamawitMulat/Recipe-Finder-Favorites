// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: const Text('Settings',
              style: TextStyle(fontWeight: FontWeight.bold))),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Appearance',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Text('Customize how the app looks',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    subtitle:
                        Text(themeProv.isDarkMode ? 'Enabled' : 'Disabled'),
                    secondary: Icon(
                        themeProv.isDarkMode
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        color: Colors.orange),
                    activeColor: Colors.orange,
                    value: themeProv.isDarkMode,
                    onChanged: (val) => themeProv.toggleTheme(val),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
