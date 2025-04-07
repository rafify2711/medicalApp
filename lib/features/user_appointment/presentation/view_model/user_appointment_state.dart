import '../../../../core/models/appointment_model/appointment_model.dart';
import '../../data/models/user_get_reservation_response_model.dart';


abstract class UserAppointmentState {}

class AppointmentInitial extends UserAppointmentState {}

class AppointmentLoading extends UserAppointmentState {}

class AppointmentLoaded extends UserAppointmentState {
  final UserGetReservationResponseModel appointments;

  AppointmentLoaded(this.appointments);
}

class AppointmentError extends UserAppointmentState {
  final String message;

  AppointmentError(this.message);
}
