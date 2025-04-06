// disease_drug_interaction_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/drug_conflict/data/models/drug_interaction_response.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/drug_interaction_use_case.dart';

part 'disease_drug_interaction_state.dart';

@injectable
class DiseaseDrugInteractionCubit extends Cubit<DiseaseDrugInteractionState> {
  final DrugInteractionsUseCase useCase;



  DiseaseDrugInteractionCubit(this.useCase) : super(DiseaseDrugInteractionInitial());

  Future<void> checkDiseaseDrugInteraction(String drug, String disease) async {
    emit(DiseaseDrugInteractionLoading());
    try {
      final result = await useCase.checkDiseaseDrugInteraction(drug, disease);
      emit(DiseaseDrugInteractionSuccess(result));
    } catch (e) {
      emit(DiseaseDrugInteractionError(e.toString()));
    }
  }
}
