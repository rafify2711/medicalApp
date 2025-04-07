import 'package:graduation_medical_app/core/models/appointment_model/appointment_model.dart';
import 'package:graduation_medical_app/core/network/api_client.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/user_appointmet_repository.dart';
import '../models/user_get_reservation_response_model.dart';

@Injectable(as:UserAppointmentRepository)
class UserAppointmentRepositoryImpl implements UserAppointmentRepository {
  final ApiClient api;

  UserAppointmentRepositoryImpl(this.api);

  @override
  Future<UserGetReservationResponseModel> getUserAppointments(String userId, String token) {
    return api.getUserAppointments(userId,"Bearer $token");
  }}