import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/user_profile_response.dart';
import '../../domain/repository/user_profile_repository.dart';

part 'user_profile_state.dart';
@injectable
class UserProfileCubit extends Cubit<UserProfileState> {
  final UserRepository _userRepository;

  UserProfileCubit(this._userRepository) : super(UserProfileInitial());

  Future<void> fetchUserProfile(String token, String userId) async {
    emit(UserProfileLoading());
    try {
      final profile = await _userRepository.getUserProfile(token, userId);
      emit(UserProfileLoaded(profile));
    } catch (e) {
      emit(UserProfileError(e.toString()));
    }
  }
  // Add logout functionality to the cubit
  Future<void> logout() async {
    try {
      // Emit loading state before performing logout
      emit(UserProfileLoading());

      // Call the logout function from the repository
      await _userRepository.logout();

      // After successful logout, you can emit a success state or reset the app state
      emit(UserProfileLoggedOut());
    } catch (e) {
      // Emit error if logout fails
      emit(UserProfileError("Failed to logout: ${e.toString()}"));
    }
  }
}

