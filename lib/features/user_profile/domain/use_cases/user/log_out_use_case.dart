

import 'package:injectable/injectable.dart';

import '../../repository/user_profile_repository.dart';


@lazySingleton
class GetUserProfile {
  final UserRepository repository;

  GetUserProfile(this.repository);

  Future<void> call(String token, String userId) {
    return repository.logout();
  }
}
