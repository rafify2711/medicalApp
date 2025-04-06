import 'package:graduation_medical_app/core/network/api_client.dart';
import 'package:graduation_medical_app/features/auth/data/models/user_model/doctor_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../auth/data/models/user_model/doctors_model.dart';

@lazySingleton
class DoctorDataSource {
  final ApiClient apiManager;

  DoctorDataSource({required this.apiManager});

  Future<List<Doctor>> getDoctors() async {
    try {
      final response = await apiManager.getAllDoctors();
      return response;
    } catch (e) {
      throw Exception("Failed to load doctors: $e");
    }
  }
}