import 'package:injectable/injectable.dart';
import '../../../data/models/user_profile_response.dart';
import '../../repository/user_profile_repository.dart';


@lazySingleton
class GetUserProfile {
  final UserRepository repository;

  GetUserProfile(this.repository);

  Future<UserProfileResponse> call(String token, String userId) {
    return repository.getUserProfile(token, userId);
  }
}
