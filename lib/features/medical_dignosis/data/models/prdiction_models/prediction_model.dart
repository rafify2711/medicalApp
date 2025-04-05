

import 'package:json_annotation/json_annotation.dart';

part 'prediction_model.g.dart';

@JsonSerializable()
class PredictionModel {
  String predicted_class;
  double confidence;
  String? detected_image;
  PredictionModel({required this.confidence,required this.predicted_class,this.detected_image});

  factory PredictionModel.fromJson(Map<String, dynamic> json) => _$PredictionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionModelToJson(this);
}


@JsonSerializable()
class PredictionResponse{
  bool success;
  @JsonKey(name: "prediction")
  PredictionModel model;
  PredictionResponse({required this.model,required this.success});
  factory PredictionResponse.fromJson(Map<String, dynamic> json) => _$PredictionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionResponseToJson(this);
}