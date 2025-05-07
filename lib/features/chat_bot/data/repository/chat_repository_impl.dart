import 'dart:developer';

import 'package:graduation_medical_app/core/network/api_client.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/api_message_response.dart';
import '../../../../core/models/chat_message.dart';
import '../../../../core/utils/shared_prefs.dart';
import '../../domain/repository/chat_repository.dart';
import '../models/chat_response.dart';


@Injectable(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final ApiClient api;
  final SharedPrefs _sharedPrefs;

  ChatRepositoryImpl(this.api,this._sharedPrefs);

  @override
  Future<List<ChatMessage>> fetchChatHistory() async {
    final storedUserId =await _sharedPrefs.getUserId();
    return api.fetchChatHistory(storedUserId);
  }

  @override
  Future<ChatResponse> sendMessage(String email ,String message) async {
    final storedUserId =await _sharedPrefs.getUserId();
    log("-----------------------------$storedUserId");
    return api.sendMessage(SendMessageData(user: email, email: storedUserId , message: message));
  }

  @override
  Future<ApiMessageResponse> deleteChat() async {

    final storedUserId =await _sharedPrefs.getUserId();
    return api.deleteChat(storedUserId);
  }
}
