import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/shared_prefs.dart';
import '../../domain/repository/doctor_profile_repository.dart';
import '../models/update_doctor_model.dart';

@LazySingleton(as: DoctorProfileRepository)
class DoctorProfileRepositoryImpl implements DoctorProfileRepository {
  final ApiClient _apiService;
  final SharedPrefs _sharedPrefs;

  DoctorProfileRepositoryImpl(this._apiService, this._sharedPrefs);

  @override
  Future<DoctorModel> getDoctorProfile(String userId) async {
    try {
      final storedUserId =  _sharedPrefs.getUserId();
      userId = userId.isNotEmpty ? userId : (storedUserId ?? "");

      if (userId.isEmpty) {
        throw Exception("Missing authentication data");
      }

      final response = await _apiService.getDoctorProfile(userId);
      return response;
    } catch (e) {
      throw Exception("Failed to fetch user profile: ${e.toString()}");
    }
  }

  @override
  Future<DoctorModel> updateDoctorProfile(String userId, String token, UpdateDoctorModel model) async {
    try {
      final storedUserId =  _sharedPrefs.getUserId();
      userId = userId.isNotEmpty ? userId : (storedUserId ?? "");

      if (userId.isEmpty) {
        throw Exception("Missing authentication data");
      }

      final response = await _apiService.updateDoctorProfile(userId, model);
      return response.updatedDoctor;
    } catch (e) {
      throw Exception("Failed to update doctor profile: ${e.toString()}");
    }
  }
}
