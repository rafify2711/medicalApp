import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:graduation_medical_app/features/doctor_profile/data/models/update_doctor_model.dart';

abstract class DoctorProfileRepository {
  Future<DoctorModel> getDoctorProfile(String userId);
  Future<DoctorModel> updateDoctorProfile(String userId, String token, UpdateDoctorModel model);
}
