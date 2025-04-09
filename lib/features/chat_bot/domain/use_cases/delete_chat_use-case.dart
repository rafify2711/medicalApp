
import 'package:injectable/injectable.dart';

import '../../../../core/models/api_message_response.dart';
import '../repository/chat_repository.dart';

@injectable
class DeleteChatUseCase {
  final ChatRepository repo;

  DeleteChatUseCase(this.repo);

  Future<ApiMessageResponse> call() {
    return repo.deleteChat();
  }
}