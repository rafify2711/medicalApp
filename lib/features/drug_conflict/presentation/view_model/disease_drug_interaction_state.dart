// disease_drug_interaction_state.dart
part of 'disease_drug_interaction_cubit.dart';

abstract class DiseaseDrugInteractionState {}

class DiseaseDrugInteractionInitial extends DiseaseDrugInteractionState {}

class DiseaseDrugInteractionLoading extends DiseaseDrugInteractionState {}

class DiseaseDrugInteractionSuccess extends DiseaseDrugInteractionState {
  final DrugInteractionResponse response;
  DiseaseDrugInteractionSuccess(this.response);
}

class DiseaseDrugInteractionError extends DiseaseDrugInteractionState {
  final String message;
  DiseaseDrugInteractionError(this.message);
}
