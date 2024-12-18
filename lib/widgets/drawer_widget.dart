import 'package:flutter/material.dart';
import '../app_state.dart';
import '../states/calendar_state.dart';
import '../states/home_screen_state.dart';
import '../states/nova_state.dart';
import '../widgets/custom_button.dart';

class AppDrawer extends StatelessWidget {
  final Function(AppState) onStateChange;

  const AppDrawer({super.key, required this.onStateChange});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: const Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomButton(
                  text: 'Home Screen',
                  onPressed: () {
                    Navigator.pop(context);
                    onStateChange(HomeScreenState(onStateChange: onStateChange));
                  },
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Calendar',
                  onPressed: () {
                    Navigator.pop(context);
                    onStateChange(CalendarState(onStateChange: onStateChange));
                  },
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Nova UI',
                  onPressed: () {
                    Navigator.pop(context);
                    onStateChange(NovaUIState(onStateChange: onStateChange));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
