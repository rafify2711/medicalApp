import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/utils/shared_prefs.dart';
import '../../domain/repository/reservation_repository.dart';
import '../models/add_update_schedule_response.dart';

@Injectable(as:ReservationRepository)
class ReservationRepositoryImpl implements ReservationRepository {

  final ApiClient _apiService;
  final SharedPrefs _sharedPrefs;

  ReservationRepositoryImpl(this._sharedPrefs, this._apiService);

  @override
  Future<List<ScheduleModel>> addUpdateSchedule(String doctorId,
      String token, AddUpdateScheduleData schedule) async {
    try {
      final storedToken = await _sharedPrefs.getToken();
      final storedUserId = await _sharedPrefs.getUserId();

      token = token.isNotEmpty ? token : (storedToken ?? "");
      doctorId = doctorId.isNotEmpty ? doctorId : (storedUserId ?? "");

      if (token.isEmpty || doctorId.isEmpty) {
        throw Exception("Missing authentication data");
      }

      final response = await _apiService.addUpdateSchedule(
          doctorId, "Bearer $token",schedule);
      return response;
    } catch (e) {
      throw Exception("Failed to update schedule: ${e.toString()}");
    }
  }}


