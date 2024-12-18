import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  ChatWidgetState createState() => ChatWidgetState();
}

class ChatWidgetState extends State<ChatWidget> {
  final List<Message> messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _addAIMessage("Hello! I'm Nova. How can I assist you?");
  }

  Future<void> _addAIMessage(String fullMessage) async {
    setState(() {
      _isTyping = true;
      messages.add(Message(text: "", isSender: false));
    });

    int index = messages.length - 1;
    String currentMessage = "";
    for (int i = 0; i < fullMessage.length; i++) {
      await Future.delayed(Duration(milliseconds: 40));
      setState(() {
        currentMessage += fullMessage[i];
        messages[index] = Message(text: currentMessage, isSender: false);
      });
    }
    setState(() => _isTyping = false);
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add(Message(text: text, isSender: true));
      });
      _controller.clear();
      Future.delayed(Duration(seconds: 1), () => _addAIMessage("I received: \"$text\""));
    }
  }

  void _onMessageLongPress(BuildContext context, Message message) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text("Copy"),
            onTap: () {
              Navigator.pop(context);
              Clipboard.setData(ClipboardData(text: message.text));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Message copied to clipboard.")),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text("Delete"),
            onTap: () {
              setState(() => messages.remove(message));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isTyping && index == 0) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text("Nova is typing...", style: TextStyle(color: Colors.grey)),
                    ),
                  );
                }

                final reversedIndex = _isTyping ? index - 1 : index;
                final message = messages[messages.length - 1 - reversedIndex];
                return GestureDetector(
                  onLongPress: () => _onMessageLongPress(context, message),
                  child: Align(
                    alignment: message.isSender ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: message.isSender
                            ? Colors.blueAccent.withAlpha(51)
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message.text,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (_) => _sendMessage(), // Sends message on Enter key press
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              minLines: 1, // Starts with one row
              maxLines: 4, // Expands up to four rows for long messages
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blueAccent),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isSender;

  Message({required this.text, this.isSender = false});
}
