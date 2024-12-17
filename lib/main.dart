import 'package:flutter/material.dart';
import 'states/home_screen_state.dart'; // Home state
import 'states/calendar_state.dart'; // Calendar state
import 'states/nova_state.dart'; // Nova UI state
import 'app_state.dart'; // Abstract AppState base class

void main() {
  runApp(NovaApp());
}

class NovaApp extends StatefulWidget {
  const NovaApp({super.key}); // Added a key parameter to the constructor

  @override
  NovaAppState createState() => NovaAppState();
}

class NovaAppState extends State<NovaApp> {
  late AppState _currentState; // Late initialization for the current state

  /// Method to change active state dynamically.
  void _changeState(AppState newState) {
    setState(() {
      _currentState = newState;
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize the initial state
    _currentState = HomeScreenState(onStateChange: _changeState);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Nova',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          layoutBuilder: (currentChild, previousChildren) {
            return Stack(
              children: [
                if (currentChild != null) currentChild,
                ...previousChildren,
              ],
            );
          },
          child: _currentState, // Moved `child` to the last position
        ),
        drawer: AppDrawer(onStateChange: _changeState),
      ),
    );
  }
}

/// Drawer widget for navigation between states
class AppDrawer extends StatelessWidget {
  final Function(AppState) onStateChange;

  const AppDrawer({super.key, required this.onStateChange}); // Added super.key

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Text(
              'Navigation Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              onStateChange(HomeScreenState(onStateChange: onStateChange));
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Calendar'),
            onTap: () {
              onStateChange(CalendarState(onStateChange: onStateChange));
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_applications),
            title: const Text('Nova UI'),
            onTap: () {
              onStateChange(NovaUIState(onStateChange: onStateChange));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
