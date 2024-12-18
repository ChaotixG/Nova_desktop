import 'package:flutter/material.dart';
import '../app_state.dart'; // Abstract AppState class
import '../widgets/chat_widget.dart'; // Chat widget component
import '../widgets/drawer_widget.dart'; // AppDrawer component

class NovaUIState extends AppState {
  final Function(AppState) onStateChange;

  const NovaUIState({super.key, required this.onStateChange}); // Using super.key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(onStateChange: onStateChange),
      body: Column(
        children: [
          // Ensuring ChatWidget is displayed as the main content
          const Expanded(
            child: ChatWidget(),
          ),
          const SizedBox(height: 8), // Use SizedBox instead of Container for spacing
          const Text(
            'Welcome to Nova!',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
