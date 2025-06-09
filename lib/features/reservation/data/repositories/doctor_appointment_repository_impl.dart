import 'package:injectable/injectable.dart';
import 'package:graduation_medical_app/core/network/api_client.dart';
import 'package:graduation_medical_app/core/models/doctor_appointment_model.dart';

import '../../../../core/utils/shared_prefs.dart';
abstract class DoctorAppointmentRepository {
  Future<ReservationResponse> fetchDoctorAppointments();
}

@Injectable(as: DoctorAppointmentRepository)
class DoctorAppointmentRepositoryImpl implements DoctorAppointmentRepository {
  final ApiClient _apiClient;
  final SharedPrefs _sharedPrefs;

  DoctorAppointmentRepositoryImpl(this._apiClient, this._sharedPrefs);

  @override
  Future<ReservationResponse> fetchDoctorAppointments() async {
    try {
      final storedToken = await _sharedPrefs.getToken();
      final storedUserId = await _sharedPrefs.getUserId();

      final token =  storedToken ?? "";
      final  doctorId = storedUserId ?? "";

      if (token.isEmpty || doctorId.isEmpty) {
        throw Exception("Missing authentication data");
      }
      return await _apiClient.fetchDoctorAppointments(
        doctorId,
        'Bearer $token',
      );
    } catch (e) {
      throw Exception('Failed to fetch doctor appointments: ${e.toString()}');
    }
  }
} 