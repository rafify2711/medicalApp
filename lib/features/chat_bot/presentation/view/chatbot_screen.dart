import 'package:flutter/material.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';

import '../../../../core/utils/app_colors.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});
  static const  routeName="chatbot_screen.dart";

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<_ChatMessage> _messages = [];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
    });

    _controller.clear();

    // Simulated bot response after delay
    Future.delayed(const Duration(milliseconds: 500), () {
      final reply = _getBotReply(text);
      setState(() {
        _messages.add(_ChatMessage(text: reply, isUser: false));
      });
    });
  }

  String _getBotReply(String userInput) {
    final input = userInput.toLowerCase();

    if (input.contains("hello") || input.contains("hi")) {
      return "Hey there! 👋 How can I assist you today?";
    } else if (input.contains("how are you")) {
      return "I'm just code, but I'm running smoothly 😄";
    } else if (input.contains("help")) {
      return "Sure! You can ask me anything like time, joke, or just chat.";
    } else if (input.contains("joke")) {
      return "Why don’t scientists trust atoms? Because they make up everything!";
    } else if (input.contains("time")) {
      final now = TimeOfDay.now();
      return "It's ${now.format(context)} 🕒";
    } else {
      return "I'm a simple demo bot 🤖. Try saying 'hello', 'help', or 'joke'.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: 'ChatBot'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _MessageBubble(message: message);
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: AppColors.primary),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;

  _ChatMessage({required this.text, required this.isUser});
}

class _MessageBubble extends StatelessWidget {
  final _ChatMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final bgColor = message.isUser ? AppColors.primary : Colors.grey[300];
    final textColor = message.isUser ? Colors.white : Colors.black87;
    final align = message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = message.isUser
        ? const BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
      bottomLeft: Radius.circular(16),
    )
        : const BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
      bottomRight: Radius.circular(16),
    );

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: radius,
          ),
          child: Text(message.text, style: TextStyle(color: textColor)),
        ),
      ],
    );
  }
}