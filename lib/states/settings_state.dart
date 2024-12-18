// states/settings_state.dart
import 'package:flutter/material.dart';
import '../app_state.dart'; // Importing the base class

class SettingsState extends AppState {
  final Function(AppState) onStateChange;

  SettingsState({required this.onStateChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('General Settings'),
              onTap: () {
                // Here you could implement specific settings actions
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('General Settings clicked')),
                );
              },
            ),
            ListTile(
              title: const Text('Notifications'),
              onTap: () {
                // Action to take when Notifications is clicked
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notifications clicked')),
                );
              },
            ),
            ListTile(
              title: const Text('Privacy'),
              onTap: () {
                // Action to take when Privacy is clicked
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Privacy clicked')),
                );
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                // Action to take when About is clicked
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('About clicked')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}