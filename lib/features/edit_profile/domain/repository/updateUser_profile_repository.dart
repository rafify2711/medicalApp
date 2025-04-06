import 'package:dio/dio.dart';
import '../../../Profile/data/models/user_profile_response.dart';

import '../../data/models/updated_user_model.dart';

abstract class UpdateUserProfileRepository {
  Future<UserProfileResponse> updateUserProfile(String token, UpdateUserModel user);
}