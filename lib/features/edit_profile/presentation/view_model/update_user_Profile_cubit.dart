import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../user_profile/data/models/user_profile_response.dart';
import '../../data/models/updated_user_model.dart';
import '../../domain/use_cases/update_user_profile_usecase.dart';

class UpdateUserProfileState {
  final bool isLoading;
  final UserProfileResponse? userProfile;
  final String? errorMessage;

  UpdateUserProfileState({
    this.isLoading = false,
    this.userProfile,
    this.errorMessage,
  });
}
@injectable
class UpdateUserProfileCubit extends Cubit<UpdateUserProfileState> {
  final UpdateUserProfileUseCase updateUserProfileUseCase;

  UpdateUserProfileCubit(this.updateUserProfileUseCase)
      : super(UpdateUserProfileState(isLoading: false));

  Future<void> updateProfile(String token, UpdateUserModel user) async {
    try {
      emit(UpdateUserProfileState(isLoading: true));

      final updatedUserProfile =
      await updateUserProfileUseCase.call(token, user);

      emit(UpdateUserProfileState(
        isLoading: false,
        userProfile: updatedUserProfile,
      ));
    } catch (e) {
      emit(UpdateUserProfileState(
        isLoading: false,
        errorMessage: 'Error updating profile: ${e.toString()}',
      ));
    }
  }
}
