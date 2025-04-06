import 'package:json_annotation/json_annotation.dart';

part 'drug_interaction_response.g.dart';

@JsonSerializable()
class DrugInteractionResponse {
  final String result;
  DrugInteractionResponse(this.result);


  factory DrugInteractionResponse.fromJson(Map<String, dynamic> json) =>
      _$DrugInteractionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DrugInteractionResponseToJson(this);
}