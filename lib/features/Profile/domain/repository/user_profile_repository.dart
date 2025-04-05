

import 'package:graduation_medical_app/features/Profile/data/models/user_profile_response.dart';

abstract class UserRepository {
  Future<UserProfileResponse> getUserProfile(String token, String userId);
}
