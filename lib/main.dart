import 'package:flutter/material.dart';
import 'states/home_screen_state.dart'; // Home state
//import 'states/calendar_state.dart'; // Calendar state
//import 'states/nova_state.dart'; // Nova UI state
import 'app_state.dart'; // Abstract AppState base class
import 'widgets/drawer_widget.dart'; // Updated AppDrawer widget

void main() {
  runApp(const NovaApp());
}

class NovaApp extends StatefulWidget {
  const NovaApp({super.key});

  @override
  NovaAppState createState() => NovaAppState();
}

class NovaAppState extends State<NovaApp> {
  late AppState _currentState;

  /// Method to change the active state dynamically.
  void _changeState(AppState newState) {
    setState(() {
      _currentState = newState;
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize the home screen as the default state
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
        appBar: AppBar(
          title: const Text('Project Nova'),
          centerTitle: true,
        ),
        drawer: AppDrawer(onStateChange: _changeState), // Updated Drawer
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
          child: KeyedSubtree(
            key: ValueKey(_currentState.runtimeType), // Ensures correct state rendering
            child: _currentState,
          ),
        ),
      ),
    );
  }
}
