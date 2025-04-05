import 'package:dio/dio.dart';
import 'package:graduation_medical_app/features/auth/data/models/sign_in_model/sign_in_model.dart';
import 'package:graduation_medical_app/features/auth/data/models/sign_in_model/login_response.dart';
import 'package:graduation_medical_app/features/auth/data/models/signup_model/register_doctor_response.dart';
import 'package:graduation_medical_app/features/auth/data/models/signup_model/register_user_response.dart';
import 'package:graduation_medical_app/features/auth/data/models/signup_model/signup_doctor_model.dart';
import 'package:graduation_medical_app/features/auth/data/models/signup_model/signup_user_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_client.dart';

abstract class AuthRemoteDataSource {
  Future<RegisterUserResponse> signupPatient(SignupUserModel model);
  Future<LoginResponse> login(SignInModel model);
  Future<RegisterDoctorResponse> signupDoctor(SignupDoctorModel model);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<RegisterUserResponse> signupPatient(SignupUserModel signupModel) async {
    try {
      return await apiClient.signupPatient(signupModel);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<RegisterDoctorResponse> signupDoctor(SignupDoctorModel model) async {
    try {
      return await apiClient.signupDoctor(model);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<LoginResponse> login(SignInModel signInModel) async {
    try {
      return await apiClient.login(signInModel);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response != null && e.response!.data != null) {
      final message = e.response!.data['message'] ?? 'An unknown error occurred';
      return Exception(message);
    } else {
      return Exception("Something went wrong. Please check your connection.");
    }
  }
}
