import 'package:flutter/material.dart';
import '../app_state.dart'; // Import the abstract base class
import 'nova_state.dart'; // Ensure NovaUI is correctly imported

/// Concrete State: Home Screen State
class HomeScreenState extends AppState {
  final Function(AppState) onStateChange;

  const HomeScreenState({super.key, required this.onStateChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Assistant'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Hello, I\'m Nova.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Pass `onStateChange` to NovaUIState when navigating
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NovaUIState(onStateChange: onStateChange),
                  ),
                );
              },
              child: const Text('What can I do for you?'),
            ),
          ],
        ),
      ),
    );
  }
}
