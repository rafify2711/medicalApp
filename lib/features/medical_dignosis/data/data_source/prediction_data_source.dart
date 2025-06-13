import 'dart:io';
import 'package:dio/dio.dart';
import 'package:graduation_medical_app/core/network/api_client.dart';
import 'package:injectable/injectable.dart';
import '../models/prdiction_models/prediction_model.dart';

abstract class PredictionDataSource {
  Future<PredictionResponse> predictDisease(String disease, File imageFile);
}

@LazySingleton(as: PredictionDataSource)
class PredictionDataSourceImpl implements PredictionDataSource {
  final ApiClientPrediction apiClientPrediction;
  final ApiClientLocalPrediction apiClientLocalPrediction;

  PredictionDataSourceImpl(this.apiClientPrediction, this.apiClientLocalPrediction);

  @override
  Future<PredictionResponse> predictDisease(String disease, File imageFile) async {


    return _predictByDisease(disease, imageFile);
  }

  Future<PredictionResponse> _predictByDisease(String disease, File imagePath) {
    switch (disease.toLowerCase()) {
      case "covid19":
        return apiClientPrediction.predictCovid19(imagePath);
      case "brain-tumor":
        return apiClientPrediction.predictBrainTumor(imagePath);
      case "kidney-stone":
        return apiClientPrediction.predictKidneyStone(imagePath);
      case "skin-cancer":
        return apiClientPrediction.predictSkinCancer(imagePath);
      case "tuberculosis":
        return apiClientPrediction.predictTuberculosis(imagePath);

      case "eye-diseases":
        return apiClientPrediction.predictEyeDiseases(imagePath);

      case "alzheimer":
        return apiClientPrediction.predictAlzheimer(imagePath);

      case "dental":
        return apiClientLocalPrediction.predictDental(imagePath);
      case "colon-diseases":
        return apiClientLocalPrediction.predictColon(imagePath);
      case "oral-diseases":
        return apiClientLocalPrediction.predictOral(imagePath);

      default:
        throw Exception("Unknown disease type: $disease");
    }
  }
}
