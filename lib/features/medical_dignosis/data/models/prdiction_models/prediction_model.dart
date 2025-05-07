import 'package:json_annotation/json_annotation.dart';

part 'prediction_model.g.dart';

@JsonSerializable()
class PredictionModel {
  final String? predicted_class;
  final double? confidence;
  final String? detected_image;
  final String? disease;

  PredictionModel({
    this.confidence,
    this.predicted_class,
    this.detected_image,
    this.disease,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) => _$PredictionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionModelToJson(this);

  bool get isKidneyStone => disease?.toLowerCase() == 'kidney-stone';

  String? get displayImage {
    if (isKidneyStone) {
      return detected_image;
    }
    return null;
  }
}

@JsonSerializable()
class PredictionResponse {
  final bool success;
  @JsonKey(name: "prediction")
  final PredictionModel model;

  PredictionResponse({
    required this.model,
    required this.success,
  });

  factory PredictionResponse.fromJson(Map<String, dynamic> json) => _$PredictionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionResponseToJson(this);
}