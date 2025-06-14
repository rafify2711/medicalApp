import 'package:equatable/equatable.dart';

abstract class ForgotResetPasswordState extends Equatable {
  const ForgotResetPasswordState();

  @override
  List<Object?> get props => [];
}

class ForgotResetInitial extends ForgotResetPasswordState {}

class ForgotResetLoading extends ForgotResetPasswordState {}

class ForgotResetSuccess extends ForgotResetPasswordState {
  final String message;

  const ForgotResetSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ForgotResetFailure extends ForgotResetPasswordState {
  final String error;

  const ForgotResetFailure(this.error);

  @override
  List<Object?> get props => [error];
}
