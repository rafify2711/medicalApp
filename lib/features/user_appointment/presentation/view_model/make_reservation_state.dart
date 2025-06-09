import 'package:equatable/equatable.dart';
import '../../../reservation/data/models/create_reservation_response.dart';


abstract class CreateReservationState extends Equatable {
  const CreateReservationState();

  @override
  List<Object?> get props => [];
}

class CreateReservationInitial extends CreateReservationState {}

class CreateReservationLoading extends CreateReservationState {}

class CreateReservationSuccess extends CreateReservationState {
  final CreateReservationResponse response;

  const CreateReservationSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class CreateReservationFailure extends CreateReservationState {
  final String message;

  const CreateReservationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
