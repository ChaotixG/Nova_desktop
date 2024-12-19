import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../app_state.dart'; // Import AppState for dynamic state handling

class VoiceStateWidget extends AppState {
  final VoidCallback onBackToNova;

  const VoiceStateWidget({super.key, required this.onBackToNova});

  @override
  Widget build(BuildContext context) {
    return _VoiceState(onBackToNova: onBackToNova);
  }
}

class _VoiceState extends StatefulWidget {
  final VoidCallback onBackToNova;

  const _VoiceState({required this.onBackToNova});

  @override
  _VoiceStateState createState() => _VoiceStateState();
}

class _VoiceStateState extends State<_VoiceState> {
  bool isTalking = false; // Indicates whether the button is in talking mode
  bool isListening = true; // Indicates whether the button is in listening mode
  int counter = 0; // Counter for duration in listening mode
  Timer? timer; // Timer instance
  final List<String> chat = []; // Chat list for AI responses

  void _startListening() {
    if (!isListening) return;

    setState(() {
      counter = 0;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        counter++;
      });
    });
  }

  void _stopListening() {
    if (timer != null) {
      timer!.cancel();
      timer = null;

      setState(() {
        chat.add("Listening duration: $counter seconds");
        counter = 0; // Reset counter after recording in the chat
      });
    }
  }

  void _toggleTalkingMode() {
    if (!isTalking) {
      setState(() {
        isTalking = true;
        isListening = false;
      });
    }
  }

  void _toggleListeningMode() {
    if (!isListening) {
      setState(() {
        isListening = true;
        isTalking = false;
      });
    }
  }

  void _handleTalkingClick() {
    if (isTalking) {
      setState(() {
        chat.add("Talking action performed");
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel timer if active
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: chat.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(chat[chat.length - 1 - index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 100), // Leave space for the button
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: isTalking ? _handleTalkingClick : null,
                  onLongPress: isListening ? _startListening : null,
                  onLongPressUp: isListening ? _stopListening : null,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Lottie.asset('assets/animations/ai_speech.json'),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _toggleListeningMode,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isListening ? Colors.blue : Colors.grey,
                      ),
                      child: const Text("Listening Mode"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _toggleTalkingMode,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isTalking ? Colors.blue : Colors.grey,
                      ),
                      child: const Text("Talking Mode"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: widget.onBackToNova,
            ),
          ),
        ],
      ),
    );
  }
}
