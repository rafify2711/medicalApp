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


part 'auth_state.dart';

@injectable

class AuthCubit extends Cubit<AuthState> {
  final LogInUseCase logInUseCase;
  final SignupUseCase signupUseCase;

  AuthCubit(this.logInUseCase, this.signupUseCase) : super(AuthInitial());

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

      emit(AuthLoginSuccess(token, userId, role));
    } catch (e) {
      print("error:$e");
      emit(AuthFailure(_handleError(e)));
      print("${_handleError(e)}");

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
