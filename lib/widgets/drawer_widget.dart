import 'package:flutter/material.dart';
import '../app_state.dart';
import '../states/calendar_state.dart';
import '../states/nova_state.dart';
import '../states/settings_state.dart';
import '../widgets/custom_button.dart';

class AppDrawer extends Drawer {
  final Function(AppState) onStateChange;

  AppDrawer({super.key, required this.onStateChange})
      : super(
          child: Builder(
            builder: (BuildContext context) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text(
                    'Menu',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CustomButton(
                        text: 'Calendar',
                        onPressed: () {
                          Navigator.pop(context); // Use context here
                          onStateChange(CalendarState(onStateChange: onStateChange));
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'Nova UI',
                        onPressed: () {
                          Navigator.pop(context); // Use context here
                          onStateChange(NovaUIState(onStateChange: onStateChange));
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'Settings',
                        onPressed: () {
                          Navigator.pop(context); // Use context here
                          onStateChange(SettingsState(onStateChange: onStateChange));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
}