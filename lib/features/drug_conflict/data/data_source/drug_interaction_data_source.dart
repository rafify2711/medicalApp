// drug_interactions_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation_medical_app/features/drug_conflict/data/models/drug_interaction_response.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';

@lazySingleton
class DrugInteractionsRemoteDataSource {
  final ApiClient apiClient;

  DrugInteractionsRemoteDataSource({required this.apiClient});

  Future<DrugInteractionResponse> checkDrugInteraction(String drug1, String drug2) async {
    try {
      return await apiClient.checkDrugInteraction(drug1, drug2);
    } catch (e) {
      rethrow;
    }
  }

  Future<DrugInteractionResponse> getDrugSubstitutions(String drug) async {
    try {
      return await apiClient.getDrugSubstitutions(drug);
    } catch (e) {
      rethrow;
    }
  }

  Future<DrugInteractionResponse> checkDiseaseDrugInteraction(String drug, String disease) async {
    try {
      return await apiClient.checkDiseaseDrugInteraction(drug, disease);
    } catch (e) {
      rethrow;
    }
  }
}
