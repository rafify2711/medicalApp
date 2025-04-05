import 'dart:io';

import 'package:graduation_medical_app/features/medical_dignosis/data/models/prdiction_models/prediction_model.dart';

abstract class PredictionRepository {
  Future<PredictionResponse> predictDisease(String disease, File imagePath);
}
