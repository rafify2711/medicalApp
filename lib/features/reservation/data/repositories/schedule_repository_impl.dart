import 'package:graduation_medical_app/core/models/api_message_response.dart';
import 'package:graduation_medical_app/features/reservation/data/models/delete_schedule_data.dart';
import 'package:graduation_medical_app/features/reservation/domain/repository/schedule_repository.dart';
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

      final token = 'Bearer $storedToken' ?? "";
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

  @override
  Future<ApiMessageResponse> deleteSchedule(DateTime date) async {
    try {
      final storedToken = _sharedPrefs.getToken();

      final token = 'Bearer $storedToken' ?? "";
      final doctorId = _sharedPrefs.getUserId();

      if (token.isEmpty || doctorId.isEmpty) {
        throw Exception("Missing authentication data");
      }
      final response = await _apiClient.deleteSchedule(
          doctorId, token, DeleteScheduleData(date: date));
      ;
      return response;
    } catch (e) {
      throw Exception('Failed to fetch schedule: ${e.toString()}');
    }
  }
}