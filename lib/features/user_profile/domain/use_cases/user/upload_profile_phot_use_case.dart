
import 'dart:io';


import 'package:graduation_medical_app/features/user_profile/domain/repository/user_profile_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/Profile_image_response.dart';

@lazySingleton
class UploadProfilePhotoUseCase {
  final  UserRepository userRepository;

  UploadProfilePhotoUseCase(this.userRepository);

  Future<ProfileImageResponse> read( File imagePath) {
    return userRepository.updateProfileImage(imagePath);

  }
}