import 'dart:convert';

import 'package:graduation_medical_app/core/network/api_client.dart';
import 'package:graduation_medical_app/features/auth/data/models/changePassword/change_password_response.dart';
import 'package:graduation_medical_app/features/auth/data/models/signup_model/signup_doctor_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/models/doctor_model/doctor_model.dart';
import '../../../../core/models/user_model/user_model.dart';
import '../../../../core/utils/shared_prefs.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_local_data_source.dart';
import '../data_source/auth_remote_data_source__impl.dart';
import '../models/changePassword/change_password_data.dart';
import '../models/sign_in_model/sign_in_model.dart';
import '../models/signup_model/signup_user_model.dart';

import 'package:dio/dio.dart';

// Custom Exception
class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPreferences prefs;
  final AuthLocalDataSource localDataSource;
  final ApiClient apiClient;
  final SharedPrefs _sharedPrefs;

  AuthRepositoryImpl(this.prefs, this._sharedPrefs,
      {required this.remoteDataSource, required this.localDataSource,required this.apiClient});

  @override
  @override
  Future<UserModel> signupUser(SignupUserModel signupModel) async {
    try {
      final response = await remoteDataSource.signupPatient(signupModel);
      print("✅ Signup Success Response: $response");
      return response.user;
    } catch (e) {
      print("❌ Signup Error: $e");

      if (e is DioException) {
        final errorMessage = e.response?.data["message"] ?? "An unexpected error occurred.";
        throw AuthException(errorMessage).message; // ✅ استخدام AuthException بدل Exception
      }
      throw AuthException(e.toString()).message; // ✅ سيتم عرض نص الخطأ فقط
    }
  }



  Future<String> login(SignInModel signInModel) async {
    try{
      final loginResponse = await remoteDataSource.login(signInModel);

      if (loginResponse.token == null || loginResponse.userId == null) {
        throw Exception("Invalid login response: token or userId is null");
      }

      // ✅ تخزين البيانات في SharedPreferences بعد تسجيل الدخول
      await prefs.setString('token', loginResponse.token!);
      await prefs.setString('userId', loginResponse.userId!);
      await prefs.setString('role', loginResponse.role!);
      return loginResponse.token!;
    } on DioException catch (e) {
      throw AuthException(_handleDioError(e)).message; // ✅ الآن يُمرر نص وليس Exception
    } catch (e) {
      print("error");
      throw AuthException("$e").message;
    }
  }

  @override
  Future<DoctorModel> signupDoctor(SignupDoctorModel signupDoctorModel) async {
    try {
      final response = await remoteDataSource.signupDoctor(signupDoctorModel);
      print("Signup response: $response");
      return response.user;
    } on DioException catch (e) {
      throw AuthException(_handleDioError(e)).message; // ✅ الآن يُمرر نص وليس Exception
    } catch (e) {
      print("error");
      throw AuthException("$e").message;
    }
  }

  @override
  Future<ChangePasswordResponse> changePassword(String oldPassword, String newPassword) {
    try{
      final changePasswordData = ChangePasswordData(oldPassword: oldPassword, newPassword: newPassword,confirmPassword: newPassword);
      final token = _sharedPrefs.getToken();
      return apiClient.changePassword(  'Bearer $token', changePasswordData);
    } on DioException catch (e) {
      throw AuthException(_handleDioError(e)).message; // ✅ الآن يُمرر نص وليس Exception
    }

  }


  String _handleDioError(DioException e) {
    if (e.response != null && e.response!.data != null) {
      final responseData = e.response!.data is String
          ? jsonDecode(e.response!.data)
          : e.response!.data;

      return responseData is Map<String, dynamic> &&
          responseData.containsKey("message")
          ? responseData["message"]
          : "An unknown error occurred";
    } else {
      return "Something went wrong. Please check your connection.";
    }
  }

  @override
  Future<String?> getRole() async{
    return prefs.getString('role');
  }

  @override
  Future<String?> getToken() async {
    return prefs.getString('token');
  }

  @override
  Future<String?> getUserId() async {
    return prefs.getString('userId');
  }

  @override
  Future<void> logout() async {
    await prefs.clear();
  }





}

