import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/appointment_model/appointment_model.dart';


part 'user_get_reservation_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserGetReservationResponseModel {
  final String message;
  final List<AppointmentModel> reservations;

  UserGetReservationResponseModel({required this.message, required this.reservations});

  factory UserGetReservationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserGetReservationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserGetReservationResponseModelToJson(this);
}

