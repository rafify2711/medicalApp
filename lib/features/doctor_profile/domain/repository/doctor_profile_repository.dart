


import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';


abstract class DoctorProfileRepository {
  Future<DoctorModel> getDoctorProfile( String userId);
}
