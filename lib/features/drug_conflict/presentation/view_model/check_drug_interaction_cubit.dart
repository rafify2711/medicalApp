// check_drug_interaction_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


import '../../data/models/drug_interaction_response.dart';
import '../../domain/use_cases/drug_interaction_use_case.dart';

part 'check_drug_interaction_state.dart';

@injectable
class CheckDrugInteractionCubit extends Cubit<CheckDrugInteractionState> {
  final DrugInteractionsUseCase useCase;

  CheckDrugInteractionCubit(this.useCase) : super(CheckDrugInteractionInitial());

  Future<void> checkDrugInteraction(String drug1, String drug2) async {
    emit(CheckDrugInteractionLoading());
    try {
      final result = await useCase.checkDrugInteraction(drug1, drug2);
      emit(CheckDrugInteractionSuccess(result));
    } catch (e) {
      emit(CheckDrugInteractionError(e.toString()));
    }
  }
}
