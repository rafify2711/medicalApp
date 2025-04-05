
import 'dart:io';

import 'package:graduation_medical_app/features/medical_dignosis/data/models/prdiction_models/prediction_model.dart';
import 'package:graduation_medical_app/features/medical_dignosis/domain/repository/prediction_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PredictionUseCase {
  final PredictionRepository predictionRepo;

  PredictionUseCase(this.predictionRepo);

  Future<PredictionResponse> predict(String disease, File imagePath) {
    return predictionRepo.predictDisease(disease, imagePath);
    
  }
}
