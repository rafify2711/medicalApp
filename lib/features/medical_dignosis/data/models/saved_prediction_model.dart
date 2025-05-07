import 'package:json_annotation/json_annotation.dart';

part 'saved_prediction_model.g.dart';

@JsonSerializable()
class SavedPrediction {
  final String id;
  final String disease;
  final String predictedClass;
  final double? confidence;
  final String? detectedImage;
  final DateTime timestamp;

  SavedPrediction({
    required this.id,
    required this.disease,
    required this.predictedClass,
    this.confidence,
    this.detectedImage,
    required this.timestamp,
  });

  factory SavedPrediction.fromJson(Map<String, dynamic> json) => _$SavedPredictionFromJson(json);
  Map<String, dynamic> toJson() => _$SavedPredictionToJson(this);
} 