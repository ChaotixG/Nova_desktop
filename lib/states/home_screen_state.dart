import 'package:flutter/material.dart';
import '../app_state.dart';
import '../states/nova_state.dart';
import '../widgets/custom_button.dart'; // Import CustomButton widget

class HomeScreenState extends AppState {
  final Function(AppState) onStateChange;

  const HomeScreenState({super.key, required this.onStateChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistant'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Hello',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'What can I do for you?',
              onPressed: () {
                // Pass `onStateChange` for state management
                onStateChange(NovaUIState(onStateChange: onStateChange));
              },
            ),
          ],
        ),
      ),
    );
  }
}
