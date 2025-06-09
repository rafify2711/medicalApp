
import 'package:injectable/injectable.dart';

import '../../data/models/changePassword/change_password_response.dart';
import '../repository/auth_repository.dart';

@injectable
class ChangePasswordUsecase {
  final AuthRepository authRepository;
  ChangePasswordUsecase(this.authRepository);
  Future<ChangePasswordResponse> changePassword(String oldPassword, String newPassword) {

    return authRepository.changePassword(oldPassword, newPassword);
  }

  }