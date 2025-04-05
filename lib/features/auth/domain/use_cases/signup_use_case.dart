import 'package:graduation_medical_app/features/auth/data/models/signup_model/signup_doctor_model.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/signup_model/signup_user_model.dart';
import '../../data/models/user_model/doctor_model.dart';
import '../../data/models/user_model/user_model.dart';
import '../repository/auth_repository.dart';

// Custom Exception for Signup Errors
class SignupFailure implements Exception {
  final String message;
  SignupFailure(this.message);
}

@lazySingleton
class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future<UserModel> call(SignupUserModel signupModel) async {
    try {
      return await repository.signupUser(signupModel);
    } catch (e) {
      throw SignupFailure(e.toString()).message; // Convert exception into failure
    }

  }

  Future<DoctorModel> callDoctor(SignupDoctorModel signupModel) async {

    try {
      return await repository.signupDoctor(signupModel);
    } catch (e) {
      throw SignupFailure(e.toString()).message; // Convert exception into failure
    }
  }
}
