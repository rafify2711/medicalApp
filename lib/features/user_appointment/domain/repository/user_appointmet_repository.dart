import 'package:graduation_medical_app/core/models/appointment_model/appointment_model.dart';

import '../../data/models/user_get_reservation_response_model.dart';

abstract class UserAppointmentRepository {
  Future<UserGetReservationResponseModel> getUserAppointments(String userId, String token);
}