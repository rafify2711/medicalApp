// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_reservation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateReservationResponse _$CreateReservationResponseFromJson(
  Map<String, dynamic> json,
) => CreateReservationResponse(
  json['message'] as String,
  ReservationModel.fromJson(json['reservation'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateReservationResponseToJson(
  CreateReservationResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'reservation': instance.reservation,
};

ReservationModel _$ReservationModelFromJson(Map<String, dynamic> json) =>
    ReservationModel(
      json['doctor'] as String?,
      json['user'] as String?,
      json['date'] == null ? null : DateTime.parse(json['date'] as String),
      json['timeSlot'] as String?,
      json['status'] as String?,
      json['_d'] as String?,
      (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$ReservationModelToJson(ReservationModel instance) =>
    <String, dynamic>{
      'doctor': instance.doctor,
      'user': instance.user,
      'date': instance.date?.toIso8601String(),
      'timeSlot': instance.timeSlot,
      'status': instance.status,
      '_d': instance.id,
      '__v': instance.v,
    };
