import 'package:injectable/injectable.dart';
import '../../../../core/models/api_message_response.dart';

import '../repository/auth_repository.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<ApiMessageResponse> call({
    required String email,
    required String otp,
    required String newPassword,
  }) {
    return _repository.resetPassword(email, otp, newPassword);
  }
}
