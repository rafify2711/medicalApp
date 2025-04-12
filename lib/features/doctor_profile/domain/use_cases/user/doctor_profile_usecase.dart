import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:injectable/injectable.dart';
import '../../../../user_appointment/data/repository/all_doctor_repo_impl.dart';

import '../../repository/doctor_profile_repository.dart';



@lazySingleton
class GetUserProfile {
  final DoctorProfileRepository repository;

  GetUserProfile(this.repository);

  Future<DoctorModel> call( String userId) {
    return repository.getDoctorProfile( userId);
  }
}
