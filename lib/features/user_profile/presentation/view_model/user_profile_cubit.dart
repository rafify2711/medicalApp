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
}
