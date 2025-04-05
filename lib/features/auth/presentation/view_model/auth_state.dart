part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final String token;
  final String userId;


  AuthLoginSuccess(this.token, this.userId);

  @override
  List<Object> get props => [token];
}

// 🔹 Role-Specific States for Signup
class AuthSignupSuccessDoctor extends AuthState {
  final UserModel doctor;
  AuthSignupSuccessDoctor(this.doctor);

  @override
  List<Object> get props => [doctor];
}

class AuthSignupSuccessPatient extends AuthState {
  final UserModel patient;
  AuthSignupSuccessPatient(this.patient);

  @override
  List<Object> get props => [patient];
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
  @override
  List<Object> get props => [message];
}




