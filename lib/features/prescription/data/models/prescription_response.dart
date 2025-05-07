import 'package:json_annotation/json_annotation.dart';

part 'prescription_response.g.dart';  // This part file will be generated

@JsonSerializable()
class PrescriptionResponse {
  @JsonKey(name: 'Detected text')
  final String? detectedText;

  PrescriptionResponse({required this.detectedText});

  // Factory constructor for JSON deserialization
  factory PrescriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionResponseFromJson(json);

  // Method to convert to JSON
  Map<String, dynamic> toJson() => _$PrescriptionResponseToJson(this);
}
