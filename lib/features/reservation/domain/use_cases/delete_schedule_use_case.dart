// domain/usecases/delete_schedule_usecase.dart
import 'package:injectable/injectable.dart';

import '../../../../core/models/api_message_response.dart';
import '../repository/schedule_repository.dart';

@injectable
class DeleteScheduleUseCase {
  final ScheduleRepository repository;

  DeleteScheduleUseCase(this.repository);

  Future<ApiMessageResponse> call(DateTime date) {
    return repository.deleteSchedule(date);
  }
}
