import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:graduation_medical_app/core/network/api_client.dart';
import 'package:injectable/injectable.dart';



@lazySingleton
class DoctorDataSource {
  final ApiClient apiManager;

  DoctorDataSource({required this.apiManager});

  Future<List<DoctorModel>> getDoctors() async {
    try {
      final response = await apiManager.getAllDoctors();
      return response;
    } catch (e) {
      throw Exception("Failed to load doctors: $e");
    }
  }
}