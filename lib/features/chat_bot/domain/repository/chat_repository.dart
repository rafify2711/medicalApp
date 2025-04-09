import '../../../../core/models/api_message_response.dart';
import '../../../../core/models/chat_message.dart';
import '../../data/models/chat_response.dart';

abstract class ChatRepository {
  Future<List<ChatMessage>> fetchChatHistory();
  Future<ChatResponse> sendMessage(String email ,String message);
  Future<ApiMessageResponse> deleteChat();
}
