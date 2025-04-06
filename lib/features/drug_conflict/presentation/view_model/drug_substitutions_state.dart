// drug_substitutions_state.dart
part of 'drug_substitutions_cubit.dart';

abstract class DrugSubstitutionsState {}

class DrugSubstitutionsInitial extends DrugSubstitutionsState {}

class DrugSubstitutionsLoading extends DrugSubstitutionsState {}

class DrugSubstitutionsSuccess extends DrugSubstitutionsState {
  final DrugInteractionResponse response;
  DrugSubstitutionsSuccess(this.response);
}

class DrugSubstitutionsError extends DrugSubstitutionsState {
  final String message;
  DrugSubstitutionsError(this.message);
}
