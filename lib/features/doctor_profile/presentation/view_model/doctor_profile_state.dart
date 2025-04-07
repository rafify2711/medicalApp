part of 'doctor_profile_cubit.dart';


abstract class DoctorProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class DoctorProfileInitial extends DoctorProfileState {}

class DoctorProfileLoading extends DoctorProfileState {}

class DoctorProfileLoaded extends DoctorProfileState {
  final DoctorModel profile;

  DoctorProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

class DoctorProfileError extends DoctorProfileState {
  final String message;

  DoctorProfileError(this.message);

  @override
  List<Object> get props => [message];
}
