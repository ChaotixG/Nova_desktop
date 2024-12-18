import 'package:flutter/material.dart';
import 'dart:async';

// Abstract AppState Class
abstract class AppState extends StatelessWidget {
  const AppState({super.key});
}

// VoiceStateWidget, extends AppState
class VoiceStateWidget extends StatefulWidget {
  const VoiceStateWidget({super.key});

  @override
  _VoiceStateWidgetState createState() => _VoiceStateWidgetState();
}

class _VoiceStateWidgetState extends State<VoiceStateWidget> {
  final List<String> _messages = []; // Stores the chat messages
  final TextEditingController _controller = TextEditingController();
  bool _isButtonHeld = false; // Track if the button is being held
  double _buttonOpacity = 1.0; // Button opacity to simulate action on press
  ScrollController _scrollController = ScrollController(); // For auto-scrolling

  @override
  void initState() {
    super.initState();
    _addMessage("Welcome to Voice State. Hold or tap the button below.");
  }

  // Method to handle button tap action
  void _onButtonPressed() {
    setState(() {
      _isButtonHeld = false;
    });
    _addMessage("Button tapped!");
    // Here you can trigger a state transition, if necessary
    // Example: You can use a state transition logic, or navigate to another page/route
    _navigateToNextState();
  }

  // Method to handle button hold action
  void _onButtonHeld() {
    setState(() {
      _isButtonHeld = true;
    });
    _addMessage("Button being held!");
  }

  // Method to add messages (simulate chat below the button)
  void _addMessage(String message) {
    setState(() {
      _messages.add(message);
    });
    Timer(const Duration(milliseconds: 10), () {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  // Method to handle state transition logic
  void _navigateToNextState() {
    // Here you can push to another state/widget in your app if necessary
    // For example, you can use Navigator to switch between states.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NextStateWidget()), // Example: Navigate to another state
    );
  }

  // Builds the UI for displaying messages
  Widget _buildMessageList() {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        reverse: true,
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          return _buildMessageBubble(_messages[index]);
        },
      ),
    );
  }

  // Builds the individual message bubble
  Widget _buildMessageBubble(String message) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  // Builds the central button UI with action and hold logic
  Widget _buildActionButton() {
    return GestureDetector(
      onTap: _onButtonPressed,
      onLongPress: _onButtonHeld,
      child: AnimatedOpacity(
        opacity: _buttonOpacity,
        duration: const Duration(milliseconds: 300),
        child: CircleAvatar(
          radius: 50,
          backgroundColor: _isButtonHeld ? Colors.red : Colors.blue,
          child: Icon(
            _isButtonHeld ? Icons.mic_off : Icons.mic,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }

  // Build the chat screen UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildActionButton(), // Centered button for press/hold actions
            const SizedBox(height: 20), // Padding between button and chat
            Expanded(
              child: Stack(
                children: [
                  _buildMessageList(),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: _buildActionButton(), // Make sure button stays centered
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Example of another widget or page that can represent the next state after transition.
class NextStateWidget extends StatelessWidget {
  const NextStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Next State')),
      body: const Center(child: Text('You have transitioned to the next state!')),
    );
  }
}
