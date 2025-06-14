import 'package:injectable/injectable.dart';

import '../../../../core/models/api_message_response.dart';
import '../repository/auth_repository.dart';

@injectable
class ForgotPasswordUseCase {
  final AuthRepository _repository;

  ForgotPasswordUseCase(this._repository);

  Future<ApiMessageResponse> call(String email) {
    return _repository.forgotPassword(email);
  }
}
