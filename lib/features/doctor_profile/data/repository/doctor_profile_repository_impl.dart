import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:graduation_medical_app/features/user_appointment/data/data_source/all_doctors_data_source/all_doctors_data_source.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/shared_prefs.dart';
import '../../../user_appointment/data/repository/all_doctor_repo_impl.dart';

import '../../domain/repository/doctor_profile_repository.dart';

@LazySingleton(as: DoctorProfileRepository)
class DoctorProfileRepositoryImpl implements DoctorProfileRepository {
  final ApiClient _apiService;
  final SharedPrefs _sharedPrefs;

  DoctorProfileRepositoryImpl(this._apiService, this._sharedPrefs);

  @override
  Future<DoctorModel> getDoctorProfile( String userId) async {
    try {

      final storedUserId =await _sharedPrefs.getUserId();

      userId = userId.isNotEmpty ? userId : (storedUserId ?? "");

      if ( userId.isEmpty) {
        throw Exception("Missing authentication data");
      }

      final response = await _apiService.getDoctorProfile(userId);
      return response;
    } catch (e) {
      throw Exception("Failed to fetch user profile: ${e.toString()}");
    }
  }



}
