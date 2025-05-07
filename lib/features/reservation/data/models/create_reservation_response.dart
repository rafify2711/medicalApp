import 'package:json_annotation/json_annotation.dart';

part 'create_reservation_response.g.dart';

@JsonSerializable()
class CreateReservationResponse {
  final String message;
  final ReservationModel reservation;

  CreateReservationResponse(this.message, this.reservation);

  factory CreateReservationResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateReservationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateReservationResponseToJson(this);
}

@JsonSerializable()
class ReservationModel {
  final String? doctor;
  final String? user;
  final DateTime? date;
  final String? timeSlot;
  final String? status;
  @JsonKey(name: "_d")
  final String? id;
  @JsonKey(name: "__v")
  final String? v;

  ReservationModel(
    this.doctor,
    this.user,
    this.date,
    this.timeSlot,
    this.status,
    this.id,
    this.v,
  );

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReservationModelToJson(this);
}
