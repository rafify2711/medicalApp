import 'dart:convert'; // لتحويل الصورة إلى Base64
import 'dart:typed_data'; // للتعامل مع الصور في الويب
import 'dart:io'; // للتعامل مع الملفات في الهاتف
import 'package:flutter/foundation.dart'; // للكشف عن بيئة التشغيل
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../domain/use_cases/prediction_usecase.dart';
import '../../data/models/prdiction_models/prediction_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/medical_dignosis/data/models/saved_prediction_model.dart';


part 'prediction_state.dart';


@injectable
class PredictionCubit extends Cubit<PredictionState> {
  final PredictionUseCase _predictionUseCase;
  final SharedPreferences _prefs;
  static const String _predictionsKey = 'saved_predictions';

  PredictionCubit({
    required PredictionUseCase predictionUseCase,
    required SharedPreferences prefs,
  })  : _predictionUseCase = predictionUseCase,
        _prefs = prefs,
        super(PredictionInitial());

  Future<void> predictDisease(String disease, {File? imageFile, Uint8List? webImage}) async {
    emit(PredictionLoading());
    try {
      final result = await _predictionUseCase.predict(
        disease,
        imageFile!
      );
      // Add disease type to the prediction model
      final predictionWithDisease = PredictionModel(
        predicted_class: result.model!.predicted_class,
        confidence: result.model!.confidence,
        detected_image: result.model!.detected_image,
        disease: disease,
      );
      emit(PredictionSuccess(predictionWithDisease));
      _savePrediction(predictionWithDisease, disease);
    } catch (e) {
      emit(PredictionError(e.toString()));
    }
  }

  void clearPrediction() {
    emit(PredictionInitial());
  }

  void _savePrediction(PredictionModel prediction, String disease) {
    final savedPrediction = SavedPrediction(
      id: const Uuid().v4(),
      disease: disease,
      predictedClass: prediction.predicted_class ?? '',
      confidence: prediction.confidence,
      detectedImage: prediction.detected_image,
      timestamp: DateTime.now(),
    );

    final predictions = _getSavedPredictions();
    predictions.insert(0, savedPrediction);
    _savePredictionsToPrefs(predictions);
  }

  List<SavedPrediction> _getSavedPredictions() {
    final predictionsJson = _prefs.getStringList(_predictionsKey) ?? [];
    return predictionsJson
        .map((json) => SavedPrediction.fromJson(jsonDecode(json)))
        .toList();
  }

  void _savePredictionsToPrefs(List<SavedPrediction> predictions) {
    final predictionsJson = predictions
        .map((prediction) => jsonEncode(prediction.toJson()))
        .toList();
    _prefs.setStringList(_predictionsKey, predictionsJson);
  }

  void loadPredictionHistory() {
    emit(PredictionHistoryLoading());
    try {
      final predictions = _getSavedPredictions();
      emit(PredictionHistoryLoaded(predictions));
    } catch (e) {
      emit(PredictionError('Failed to load prediction history'));
    }
  }

  void deletePrediction(String id) {
    try {
      final predictions = _getSavedPredictions();
      predictions.removeWhere((prediction) => prediction.id == id);
      _savePredictionsToPrefs(predictions);
      emit(PredictionHistoryLoaded(predictions));
    } catch (e) {
      emit(PredictionError('Failed to delete prediction'));
    }
  }
}
