
import 'package:graduation_medical_app/core/models/appointment_model/appointment_model.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/user_get_reservation_response_model.dart';
import '../repository/user_appointmet_repository.dart';

@Singleton()
class GetUserAppointmentsUseCase {
  final UserAppointmentRepository repository;

  GetUserAppointmentsUseCase(this.repository);

  Future<UserGetReservationResponseModel> call(String userId,String token) {
    return repository.getUserAppointments(userId,token);
  }
}
