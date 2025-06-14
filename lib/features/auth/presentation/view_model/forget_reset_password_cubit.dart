import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/api_message_response.dart';
import '../../domain/use_cases/forget_password_use_case.dart';
import '../../domain/use_cases/reset_password_use_case.dart';
import 'forget_reset_password_state.dart';

@injectable
class ForgotResetPasswordCubit extends Cubit<ForgotResetPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  ForgotResetPasswordCubit(
      this.forgotPasswordUseCase,
      this.resetPasswordUseCase,
      ) : super(ForgotResetInitial());

  Future<void> forgotPassword(String email) async {
    emit(ForgotResetLoading());
    try {
      final ApiMessageResponse response = await forgotPasswordUseCase(email);
      emit(ForgotResetSuccess(response.message!));
    } catch (e) {
      emit(ForgotResetFailure(e.toString()));
    }
  }

  Future<void> resetPassword(String email, String otp, String newPassword) async {
    emit(ForgotResetLoading());
    try {
      final ApiMessageResponse response = await resetPasswordUseCase(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
      emit(ForgotResetSuccess(response.message!));
    } catch (e) {
      emit(ForgotResetFailure(e.toString()));
    }
  }
}
