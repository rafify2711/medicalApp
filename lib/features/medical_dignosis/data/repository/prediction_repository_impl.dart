import 'dart:io';

import 'package:graduation_medical_app/features/medical_dignosis/data/models/prdiction_models/prediction_model.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/prediction_repository.dart';
import '../data_source/prediction_data_source.dart';

@Injectable(as: PredictionRepository)
class PredictionRepoImpl implements PredictionRepository {
  final PredictionDataSource predictionDataSource;

  PredictionRepoImpl(this.predictionDataSource);

  @override
  Future<PredictionResponse> predictDisease(String disease, File imagePath) async {
    if (await imagePath.exists()) {
      print("✅ file exists. path: ${imagePath.path}");
    } else {
      print("❌file doesn't exist.");
    }
    print(imagePath);

    final response = await predictionDataSource.predictDisease(disease, imagePath);
    return response;
  }
}
  
