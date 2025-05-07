import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/api_message_response.dart';
import '../../../../core/models/chat_message.dart';
import '../../data/models/chat_response.dart';
import '../../domain/use_cases/delete_chat_use-case.dart';
import '../../domain/use_cases/fetch_chat_history_use_case.dart';
import '../../domain/use_cases/send_message_use_case.dart';

import 'dart:async';

part 'chat_state.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  final FetchChatHistoryUseCase fetchChatHistory;
  final SendMessageUseCase sendMessage;
  final DeleteChatUseCase deleteChat;

  final _chatStreamController = StreamController<List<ChatMessage>>.broadcast();
  Timer? _pollingTimer;

  ChatCubit({
    required this.fetchChatHistory,
    required this.sendMessage,
    required this.deleteChat,
  }) : super(ChatInitial());

  Stream<List<ChatMessage>> get chatStream => _chatStreamController.stream;

  Future<void> loadChatHistory(String email) async {
    try {
      final messages = await fetchChatHistory();
      _chatStreamController.add(messages);
      emit(ChatLoaded(messages));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> sendNewMessage(String email, String message) async {
    final currentMessages = state is ChatLoaded ? (state as ChatLoaded).messages : [];
    emit(ChatSending(currentMessages));

    try {
      final response = await sendMessage(email, message);
      emit(ChatSent(response));
      await loadChatHistory(email); // refresh messages
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> deleteUserChat() async {
    emit(ChatDeleting());
    try {
      final result = await deleteChat();
      emit(ChatDeleted(result));
      _chatStreamController.add([]);
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void startPolling(String email) {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(Duration(seconds:1), (_) async {
      final messages = await fetchChatHistory();

      if ( messages.last.user == 'chatbot') {
        _chatStreamController.add(messages);
        stopPolling();
        emit(ChatLoaded(messages));

      } else {
        _chatStreamController.add(messages);
        emit(ChatLoaded(messages));
      }
    });
  }

  void stopPolling() {
    _pollingTimer?.cancel();
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    _chatStreamController.close();
    return super.close();
  }
}
