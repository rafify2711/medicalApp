// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_prediction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedPrediction _$SavedPredictionFromJson(Map<String, dynamic> json) =>
    SavedPrediction(
      id: json['id'] as String,
      disease: json['disease'] as String,
      predictedClass: json['predictedClass'] as String,
      confidence: (json['confidence'] as num?)?.toDouble(),
      detectedImage: json['detectedImage'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$SavedPredictionToJson(SavedPrediction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'disease': instance.disease,
      'predictedClass': instance.predictedClass,
      'confidence': instance.confidence,
      'detectedImage': instance.detectedImage,
      'timestamp': instance.timestamp.toIso8601String(),
    };
