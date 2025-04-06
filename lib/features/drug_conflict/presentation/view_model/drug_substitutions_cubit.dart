// drug_substitutions_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/drug_conflict/data/models/drug_interaction_response.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/drug_interaction_use_case.dart';

part 'drug_substitutions_state.dart';

@injectable

class DrugSubstitutionsCubit extends Cubit<DrugSubstitutionsState> {
  final DrugInteractionsUseCase useCase;

  DrugSubstitutionsCubit(this.useCase) : super(DrugSubstitutionsInitial());

  Future<void> getDrugSubstitutions(String drug) async {
    emit(DrugSubstitutionsLoading());
    try {
      final result = await useCase.getDrugSubstitutions(drug);
      emit(DrugSubstitutionsSuccess(result));
    } catch (e) {
      emit(DrugSubstitutionsError(e.toString()));
    }
  }
}
