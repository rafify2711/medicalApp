import 'package:dio/dio.dart';

import '../../../user_profile/data/models/user_profile_response.dart';
import '../../data/models/updated_user_model.dart';

abstract class UpdateUserProfileRepository {
  Future<UserProfileResponse> updateUserProfile(String token, UpdateUserModel user);
}