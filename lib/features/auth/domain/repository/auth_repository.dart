

import '../../../../core/models/doctor_model/doctor_model.dart';
import '../../../../core/models/user_model/user_model.dart';
import '../../data/models/sign_in_model/sign_in_model.dart';
import '../../data/models/signup_model/signup_doctor_model.dart';
import '../../data/models/signup_model/signup_user_model.dart';


abstract class AuthRepository {
  Future<UserModel> signupUser(SignupUserModel signupModel);
  Future<DoctorModel> signupDoctor(SignupDoctorModel signupModel);
  Future<String> login(SignInModel signInModel);
  Future<String?> getToken();
  Future<String?> getUserId();
  Future<void> logout();
}