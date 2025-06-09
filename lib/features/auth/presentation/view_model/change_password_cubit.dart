import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/change_password_usecase.dart';


part 'change_password_state.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUsecase changePasswordUsecase;

  ChangePasswordCubit(this.changePasswordUsecase) : super(ChangePasswordInitial());

  Future<void> changePassword(String oldPassword, String newPassword) async {
    emit(ChangePasswordLoading());
    try {
      final response = await changePasswordUsecase.changePassword(oldPassword, newPassword);
      emit(ChangePasswordSuccess(response.message ?? "Password changed successfully."));
    } catch (e) {
      emit(ChangePasswordError(e.toString()));
    }
  }
}
