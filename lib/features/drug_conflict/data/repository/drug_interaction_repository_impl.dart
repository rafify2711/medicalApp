// drug_interactions_repository_impl.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/drug_iteraction_repository.dart';
import '../data_source/drug_interaction_data_source.dart';
import '../models/drug_interaction_response.dart';

@Injectable(as: DrugInteractionsRepository)
class DrugInteractionsRepositoryImpl implements DrugInteractionsRepository {
  final DrugInteractionsRemoteDataSource remoteDataSource;

  DrugInteractionsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DrugInteractionResponse> checkDrugInteraction(String drug1, String drug2) async {
    return await remoteDataSource.checkDrugInteraction(drug1, drug2);
  }

  @override
  Future<DrugInteractionResponse> getDrugSubstitutions(String drug) async {
    return await remoteDataSource.getDrugSubstitutions(drug);
  }

  @override
  Future<DrugInteractionResponse> checkDiseaseDrugInteraction(String drug, String disease) async {
    return await remoteDataSource.checkDiseaseDrugInteraction(drug, disease);
  }
}
