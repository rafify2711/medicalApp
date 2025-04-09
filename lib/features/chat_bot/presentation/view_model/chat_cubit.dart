import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/api_message_response.dart';
import '../../../../core/models/chat_message.dart';
import '../../data/models/chat_response.dart';
import '../../domain/use_cases/delete_chat_use-case.dart';
import '../../domain/use_cases/fetch_chat_history_use_case.dart';
import '../../domain/use_cases/send_message_use_case.dart';

part 'chat_state.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  final FetchChatHistoryUseCase fetchChatHistory;
  final SendMessageUseCase sendMessage;
  final DeleteChatUseCase deleteChat;

  ChatCubit({
    required this.fetchChatHistory,
    required this.sendMessage,
    required this.deleteChat,
  }) : super(ChatInitial());

  Future<void> loadChatHistory(String email) async {
    emit(ChatLoading());
    try {
      final messages = await fetchChatHistory();
      emit(ChatLoaded(messages));
    } catch (e) {
      print("${e.toString()}--------------------");
      emit(ChatError(e.toString()));
    }
  }

  Future<void> sendNewMessage(String email ,String message) async {
    final currentMessages = state is ChatLoaded ? (state as ChatLoaded).messages : [];
    emit(ChatSending(currentMessages));
    try {
      final response = await sendMessage(email,message);
      emit(ChatSent(response));
    } catch (e) {
      print("${e.toString()}--------------------");
      emit(ChatError(e.toString()));
    }
  }

  Future<void> deleteUserChat() async {
    emit(ChatDeleting());
    try {
      final result = await deleteChat();
      emit(ChatDeleted(result));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
