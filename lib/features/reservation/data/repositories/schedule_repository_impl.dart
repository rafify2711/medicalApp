import 'package:graduation_medical_app/features/reservation/data/repositories/schedule_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:graduation_medical_app/core/network/api_client.dart';
import '../../../../core/utils/shared_prefs.dart';
import '../models/schedule_model.dart';
import '../models/schedule_response.dart';



@Injectable(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  final ApiClient _apiClient;
  final SharedPrefs _sharedPrefs;

  ScheduleRepositoryImpl(this._apiClient, this._sharedPrefs);

  @override
  Future<List<ScheduleModel>> fetchSchedule() async {
    try {
      final storedToken = await _sharedPrefs.getToken();
      final storedUserId = await _sharedPrefs.getUserId();

      final token = 'Bearer ' + storedToken ?? "";
     final  doctorId = storedUserId ?? "";

      if (token.isEmpty || doctorId.isEmpty) {
        throw Exception("Missing authentication data");
      }
      final response = await _apiClient.fetchDoctorSchedule(doctorId, token);
      return response.schedule;
    } catch (e) {
      throw Exception('Failed to fetch schedule: ${e.toString()}');
    }
  }
} 