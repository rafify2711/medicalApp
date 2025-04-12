
import 'package:graduation_medical_app/features/user_appointment/data/models/doctor_model/doctor_model.dart';
import 'package:injectable/injectable.dart';

import '../data_source/all_doctors_data_source/all_doctors_data_source.dart';
@injectable
class DoctorRepository {
  final DoctorDataSource doctorDataSource;

  DoctorRepository({required this.doctorDataSource});



  Future<List<DoctorsModel>> getAllDoctors() async {
    try {
      final doctors = await doctorDataSource.getDoctors();
      return doctors;
    } catch (e) {
      throw Exception("Failed to load doctors: $e");
    }
  }
}