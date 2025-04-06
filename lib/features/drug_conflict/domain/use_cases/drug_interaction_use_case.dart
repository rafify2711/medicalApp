// drug_interactions_use_case.dart
import 'package:dio/dio.dart';
import 'package:graduation_medical_app/features/drug_conflict/data/models/drug_interaction_response.dart';
import 'package:injectable/injectable.dart';

import '../repository/drug_iteraction_repository.dart';

@injectable
class DrugInteractionsUseCase {
  final DrugInteractionsRepository repository;

  DrugInteractionsUseCase({required this.repository});

  Future<DrugInteractionResponse> checkDrugInteraction(String drug1, String drug2) async {
    return await repository.checkDrugInteraction(drug1, drug2);
  }

  Future<DrugInteractionResponse> getDrugSubstitutions(String drug) async {
    return await repository.getDrugSubstitutions(drug);
  }

  Future<DrugInteractionResponse> checkDiseaseDrugInteraction(String drug, String disease) async {
    return await repository.checkDiseaseDrugInteraction(drug, disease);
  }
}
