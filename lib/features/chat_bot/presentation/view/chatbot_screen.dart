import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import '../../../../core/models/chat_message.dart';
import '../../../../core/utils/app_colors.dart';
import '../view_model/chat_cubit.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});
  static const routeName = "chatbot_screen.dart";

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().loadChatHistory("");
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    context.read<ChatCubit>().sendNewMessage('user', text);
    _controller.clear();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _clearChat() {
    // Calls the method to delete all chat messages
    context.read<ChatCubit>().deleteUserChat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(
        title: 'ChatBot',
        action: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: _clearChat, // This will trigger the deletion of all chat
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("❌ Error: ${state.error}")),
                  );
                } else if (state is ChatSent || state is ChatDeleted) {
                  context.read<ChatCubit>().loadChatHistory("");
                }

                // Scroll عند وصول رسالة جديدة
                if (state is ChatLoaded || state is ChatSending) {
                  _scrollToBottom();
                }
              },
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatLoaded || state is ChatSending) {
                  final rawMessages = state is ChatLoaded
                      ? state.messages
                      : (state as ChatSending).messages;

                  final allMessages = rawMessages
                      .map((msg) => _ChatMessage(
                    text: msg.message,
                    isUser: msg.user != 'chatbot',
                  ))
                      .toList();

                  if (state is ChatSending) {
                    allMessages.add(_ChatMessage(text: "Typing...", isUser: false));
                  }

                  if (allMessages.isEmpty) {
                    return const Center(child: Text("No messages yet."));
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    itemCount: allMessages.length,
                    itemBuilder: (context, index) {
                      final message = allMessages[index];
                      return FadeTransition(
                        opacity: Tween<double>(begin: 0, end: 1)
                            .animate(CurvedAnimation(
                            parent: _animationController..forward(),
                            curve: Curves.easeIn)),
                        child: _MessageBubble(message: message),
                      );
                    },
                  );
                } else if (state is ChatError) {
                  return Center(child: Text("Error: ${state.error}"));
                } else {
                  return const Center(child: Text("Start the conversation!"));
                }
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
