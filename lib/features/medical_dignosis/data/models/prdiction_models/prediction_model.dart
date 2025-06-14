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
  bool get isDental => disease?.toLowerCase() == 'dental';

  String? get displayImage {
    if (isKidneyStone|| isDental) {
      return detected_image;
    }
    return null;
  }
}

@JsonSerializable()
class PredictionResponse {
  final bool success;

  @JsonKey(name: "prediction")
  final PredictionModel? model;

  PredictionResponse({
    required this.success,
    this.model,
  });

  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    // ✅ الحالة 2 أو 3: flat structure
    if (!json.containsKey('success') && (json.containsKey('predicted_class') || json.containsKey('detected_image'))) {
      return PredictionResponse(
        success: true,
        model: PredictionModel.fromJson(json),
      );
    }

    // ✅ الحالة 1: nested structure
    if (json.containsKey('success') && json['success'] == true) {
      return _$PredictionResponseFromJson(json);
    }

    // ❌ أي شيء آخر يُعتبر فشل (مثلاً error)
    return PredictionResponse(success: false);
  }

  Map<String, dynamic> toJson() => _$PredictionResponseToJson(this);
}



