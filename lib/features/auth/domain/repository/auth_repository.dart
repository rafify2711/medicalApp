

import 'package:graduation_medical_app/core/models/api_message_response.dart';
import 'package:graduation_medical_app/features/auth/data/models/changePassword/change_password_response.dart';


import '../../../../core/models/doctor_model/doctor_model.dart';
import '../../../../core/models/user_model/user_model.dart';
import '../../data/models/sign_in_model/sign_in_model.dart';
import '../../data/models/signup_model/signup_doctor_model.dart';
import '../../data/models/signup_model/signup_user_model.dart';

abstract class AuthRepository {
  Future<UserModel> signupUser(SignupUserModel signupModel);
  Future<DoctorModel> signupDoctor(SignupDoctorModel signupModel);
  Future<String> login(SignInModel signInModel);
  Future<ApiMessageResponse>forgotPassword(String email);
  Future<ApiMessageResponse>resetPassword(String email,String otp,String newPassword);
  Future<String?> getToken();
  Future<String?> getUserId();
  Future<String?> getRole();
  Future<void> logout();
  Future<ChangePasswordResponse> changePassword(String oldPassword, String newPassword);
}