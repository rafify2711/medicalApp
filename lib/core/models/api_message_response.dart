import 'package:json_annotation/json_annotation.dart';


part 'api_message_response.g.dart';
@JsonSerializable()
class ApiMessageResponse {
  final String? message;

  ApiMessageResponse({this.message});

  factory ApiMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiMessageResponseToJson(this);
}

@JsonSerializable()
class Email {
  final String? email;
  Email({this.email});
  factory Email.fromJson(Map<String, dynamic> json) =>
      _$EmailFromJson(json);
  Map<String, dynamic> toJson() => _$EmailToJson(this);

}