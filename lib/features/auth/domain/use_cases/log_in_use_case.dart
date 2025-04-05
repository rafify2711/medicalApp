import 'package:injectable/injectable.dart';
import '../../data/models/sign_in_model/sign_in_model.dart';
import '../repository/auth_repository.dart';

// Custom Failure Class
class LogInFailure implements Exception {
  final String message;
  LogInFailure(this.message);
}

@lazySingleton
class LogInUseCase {
  final AuthRepository repository;

  LogInUseCase(this.repository);

  Future<String> call(SignInModel signInModel) async {
    try {
      final token = await repository.login(signInModel);

      if (token.isEmpty) {
        throw LogInFailure("Login failed: Token is empty");
      }

      return token;
    } catch (e) {
      throw LogInFailure(e.toString());
    }
  }
}
