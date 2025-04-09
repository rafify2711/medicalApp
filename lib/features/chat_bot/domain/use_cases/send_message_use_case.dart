import 'package:injectable/injectable.dart';

import '../../../../core/models/chat_message.dart';
import '../../data/models/chat_response.dart';
import '../repository/chat_repository.dart';

@injectable
class SendMessageUseCase {
  final ChatRepository repo;

  SendMessageUseCase(this.repo);

  Future<ChatResponse> call(String email ,String message) {
    return repo.sendMessage(email,message);
  }
}