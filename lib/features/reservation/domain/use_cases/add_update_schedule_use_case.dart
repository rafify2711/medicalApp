
import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:graduation_medical_app/features/reservation/domain/repository/reservation_repository.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/add_update_schedule_response.dart';

@lazySingleton
class AddUpdateScheduleUseCase {
  final ReservationRepository repository;

  AddUpdateScheduleUseCase(this.repository);

  Future<AddUpdateScheduleResponse> call(String token, String userId,AddUpdateScheduleData schedule) {
    return repository.addUpdateSchedule(token, userId,schedule);
  }
}
