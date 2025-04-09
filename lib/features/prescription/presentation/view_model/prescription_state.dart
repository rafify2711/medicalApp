part of 'prescription_cubit.dart';



abstract class PrescriptionState {}

class PrescriptionInitial extends PrescriptionState {}

class PrescriptionLoading extends PrescriptionState {}

class PrescriptionSuccess extends PrescriptionState {
  final PrescriptionResponse prescription;
  PrescriptionSuccess(this.prescription);
}

class PrescriptionFailure extends PrescriptionState {
  final String error;
  PrescriptionFailure(this.error);
}
