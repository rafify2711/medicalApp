import 'package:json_annotation/json_annotation.dart';


part 'login_response.g.dart';
@JsonSerializable()
class LoginResponse{
  String message;
  String token;
  String role;
  String userId;
  LoginResponse({
    required this.message,
    required this.token,
    required this.role,
    required this.userId,
  }
      );
  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
enum Gender { male, female, other }

