import 'package:injectable/injectable.dart';

import '../../../../core/models/chat_message.dart';
import '../repository/chat_repository.dart';

@injectable
class FetchChatHistoryUseCase {
  final ChatRepository repo;

  FetchChatHistoryUseCase(this.repo);

  Future<List<ChatMessage>> call() {
    return repo.fetchChatHistory();
  }
}
