// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_schedule_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteScheduleData _$DeleteScheduleDataFromJson(Map<String, dynamic> json) =>
    DeleteScheduleData(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$DeleteScheduleDataToJson(DeleteScheduleData instance) =>
    <String, dynamic>{'date': instance.date?.toIso8601String()};
