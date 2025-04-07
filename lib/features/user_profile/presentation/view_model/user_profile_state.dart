part of 'user_profile_cubit.dart';

abstract class UserProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final UserProfileResponse profile;

  UserProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

class UserProfileError extends UserProfileState {
  final String message;

  UserProfileError(this.message);

  @override
  List<Object> get props => [message];
}
