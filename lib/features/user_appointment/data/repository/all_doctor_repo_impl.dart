import 'package:graduation_medical_app/features/auth/data/models/user_model/doctor_model.dart';
import 'package:injectable/injectable.dart';

import '../../../auth/data/models/user_model/doctors_model.dart';
import '../data_source/all_doctors_data_source/all_doctors_data_source.dart';
@injectable
class DoctorRepository {
  final DoctorDataSource doctorDataSource;

  DoctorRepository({required this.doctorDataSource});

  Future<List<Doctor>> getAllDoctors() async {
    try {
      final doctors = await doctorDataSource.getDoctors();
      return doctors;
    } catch (e) {
      throw Exception("Failed to load doctors: $e");
    }
  }
}