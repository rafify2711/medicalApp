// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationDataModel _$ReservationDataModelFromJson(
  Map<String, dynamic> json,
) => ReservationDataModel(
  doctorId: json['doctorId'] as String,
  date: DateTime.parse(json['date'] as String),
  userId: json['userId'] as String,
  timeSlot: json['timeSlot'] as String?,
);

Map<String, dynamic> _$ReservationDataModelToJson(
  ReservationDataModel instance,
) => <String, dynamic>{
  'doctorId': instance.doctorId,
  'userId': instance.userId,
  'date': instance.date.toIso8601String(),
  'timeSlot': instance.timeSlot,
};
