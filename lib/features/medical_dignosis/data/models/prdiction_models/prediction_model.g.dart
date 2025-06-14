// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PredictionModel _$PredictionModelFromJson(Map<String, dynamic> json) =>
    PredictionModel(
      confidence: (json['confidence'] as num?)?.toDouble(),
      predicted_class: json['predicted_class'] as String?,
      detected_image: json['detected_image'] as String?,
      disease: json['disease'] as String?,
    );

Map<String, dynamic> _$PredictionModelToJson(PredictionModel instance) =>
    <String, dynamic>{
      'predicted_class': instance.predicted_class,
      'confidence': instance.confidence,
      'detected_image': instance.detected_image,
      'disease': instance.disease,
    };

PredictionResponse _$PredictionResponseFromJson(Map<String, dynamic> json) =>
    PredictionResponse(
      success: json['success'] as bool,
      model:
          json['prediction'] == null
              ? null
              : PredictionModel.fromJson(
                json['prediction'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$PredictionResponseToJson(PredictionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'prediction': instance.model,
    };
