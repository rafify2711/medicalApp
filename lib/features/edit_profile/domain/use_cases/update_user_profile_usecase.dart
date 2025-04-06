import 'package:graduation_medical_app/features/edit_profile/domain/repository/updateUser_profile_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../Profile/data/models/user_profile_response.dart';
import '../../data/models/updated_user_model.dart';

@singleton
class UpdateUserProfileUseCase {
  final UpdateUserProfileRepository userRepository;

  UpdateUserProfileUseCase(this.userRepository);

  Future<UserProfileResponse> call(String token, UpdateUserModel user) async {
    return await userRepository.updateUserProfile(token, user);
  }
}