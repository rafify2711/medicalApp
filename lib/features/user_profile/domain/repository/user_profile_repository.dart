


import 'dart:io';

import '../../data/models/Profile_image_response.dart';
import '../../data/models/user_profile_response.dart';

abstract class UserRepository {
  Future<UserProfileResponse> getUserProfile(String token, String userId);
  Future<void> logout();
  Future<ProfileImageResponse> updateProfileImage( File? imagePath);
}
