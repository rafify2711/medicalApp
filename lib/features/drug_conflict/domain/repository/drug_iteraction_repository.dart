// drug_interactions_repository.dart
import 'package:dio/dio.dart';

import '../../data/models/drug_interaction_response.dart';

abstract class DrugInteractionsRepository {
  Future<DrugInteractionResponse> checkDrugInteraction(String drug1, String drug2);
  Future<DrugInteractionResponse> getDrugSubstitutions(String drug);
  Future<DrugInteractionResponse> checkDiseaseDrugInteraction(String drug, String disease);
}