part of 'change_password_cubit.dart';

abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  final String message;
  ChangePasswordSuccess(this.message);
}

class ChangePasswordError extends ChangePasswordState {
  final String error;
  ChangePasswordError(this.error);
}
