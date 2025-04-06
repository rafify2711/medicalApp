// check_drug_interaction_state.dart
part of 'check_drug_interaction_cubit.dart';


abstract class CheckDrugInteractionState {}

class CheckDrugInteractionInitial extends CheckDrugInteractionState {}

class CheckDrugInteractionLoading extends CheckDrugInteractionState {}

class CheckDrugInteractionSuccess extends CheckDrugInteractionState {
  final DrugInteractionResponse response;
  CheckDrugInteractionSuccess(this.response);
}

class CheckDrugInteractionError extends CheckDrugInteractionState {
  final String message;
  CheckDrugInteractionError(this.message);
}