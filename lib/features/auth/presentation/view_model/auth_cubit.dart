import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:graduation_medical_app/features/auth/data/models/signup_model/signup_doctor_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/di/di.dart';
import '../../../../core/models/user_model/user_model.dart';

import '../../domain/repository/auth_repository.dart';
import '../../domain/use_cases/log_in_use_case.dart';
import '../../domain/use_cases/signup_use_case.dart';
import '../../data/models/sign_in_model/sign_in_model.dart';
import '../../data/models/signup_model/signup_user_model.dart';
import '../../data/data_source/auth_local_data_source.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LogInUseCase logInUseCase;
  final SignupUseCase signupUseCase;
  final AuthLocalDataSource _localDataSource;

  AuthCubit(this.logInUseCase, this.signupUseCase, this._localDataSource) : super(AuthInitial());

  // 🔹 Login Function
  Future<void> logIn(SignInModel signInModel) async {
    emit(AuthLoading());
    try {
      final token = await logInUseCase(signInModel);

      final userId = await getIt<AuthRepository>().getUserId();
      if (userId == null || userId.isEmpty) {
        throw Exception("User ID is missing after login");
      }

      final role = await getIt<AuthRepository>().getRole();

      // Store biometric status after successful login
      await _localDataSource.storeBiometricStatus(true);

      emit(AuthLoginSuccess(token, userId, role));
    } catch (e) {
      print("error:$e");
      emit(AuthFailure(_handleError(e)));
      print("${_handleError(e)}");
    }
  }

  // 🔹 Biometric Login Function
  Future<void> loginWithBiometrics() async {
    emit(AuthLoading());
    try {
      // First check if we have stored credentials
      final token = await getIt<AuthRepository>().getToken();
      final userId = await getIt<AuthRepository>().getUserId();
      final role = await getIt<AuthRepository>().getRole();

      if (token == null || token.isEmpty || userId == null || userId.isEmpty || role == null || role.isEmpty) {
        emit(AuthFailure("Please login with email and password first to enable biometric login"));
        return;
      }

      // Check if biometric authentication is enabled
      final isBiometricEnabled = await _localDataSource.getBiometricStatus();
      if (!isBiometricEnabled) {
        emit(AuthFailure("Biometric login is not enabled. Please login with email and password first."));
        return;
      }

      // Attempt biometric authentication
      final isAuthenticated = await _localDataSource.authenticateWithBiometrics();
      if (!isAuthenticated) {
        emit(AuthFailure("Biometric authentication failed. Please try again or use email/password login."));
        return;
      }

      // If we get here, biometric auth was successful
      emit(AuthLoginSuccess(token, userId, role));
    } catch (e) {
      print("Biometric login error: $e");
      emit(AuthFailure(_handleError(e)));
    }
  }

  Future<void> signUpDoctor(SignupDoctorModel signupModel) async {
    emit(AuthLoading());
    try {
      final user = await signupUseCase.callDoctor(signupModel);

      if (user.role == "Doctor") {
        emit(AuthSignupSuccessDoctor(user));
      } else if (user.role == "User") {
        emit(AuthSignupSuccessDoctor(user));
      } else {
        emit(AuthFailure("Invalid role"));
      }
    } catch (e) {
      print("error:$e");
      emit(AuthFailure(_handleError(e)));
      print("${_handleError(e)}");

    }


  }


  // 🔹 Signup Function (Handling Roles)
  Future<void> signUpUser(SignupUserModel signupModel) async {
    emit(AuthLoading());
    try {
      final user = await signupUseCase.call(signupModel);

      if (user.role == "Doctor") {
        emit(AuthSignupSuccessPatient(user));
      } else if (user.role == "User") {
        emit(AuthSignupSuccessPatient(user));
      } else {
        emit(AuthFailure("Invalid role"));
      }
    } catch (e) {
      print("error:$e");
      emit(AuthFailure(_handleError(e)));
      print("${_handleError(e)}");

    }


  }

  String _handleError(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        print("❌ Dio Error Response: ${error.response?.data}"); // ✅ اطبع الداتا وتأكد
        return error.response?.data["message"] ?? "An unexpected error occurred.";
      }
      return "Network error. Please check your connection.";
    }
    return error.toString(); // في حالة وجود خطأ عام
  }





}
