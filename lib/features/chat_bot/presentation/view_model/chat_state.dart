part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatMessage> messages;
  ChatLoaded(this.messages);
}

class ChatSending extends ChatState {

  final List<dynamic> messages;
  ChatSending(this.messages);
}

class ChatSent extends ChatState {
  final ChatResponse response;
  ChatSent(this.response);
}

class ChatDeleting extends ChatState {}

class ChatDeleted extends ChatState {
  final ApiMessageResponse response;
  ChatDeleted(this.response);
}

class ChatError extends ChatState {
  final String error;
  ChatError(this.error);
}
