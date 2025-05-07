// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_get_reservation_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserGetReservationResponseModel _$UserGetReservationResponseModelFromJson(
  Map<String, dynamic> json,
) => UserGetReservationResponseModel(
  message: json['message'] as String,
  reservations:
      (json['reservations'] as List<dynamic>)
          .map((e) => AppointmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$UserGetReservationResponseModelToJson(
  UserGetReservationResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'reservations': instance.reservations.map((e) => e.toJson()).toList(),
};
