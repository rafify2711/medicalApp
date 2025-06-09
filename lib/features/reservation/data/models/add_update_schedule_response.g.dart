// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_update_schedule_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddUpdateScheduleResponse _$AddUpdateScheduleResponseFromJson(
  Map<String, dynamic> json,
) => AddUpdateScheduleResponse(
  message: json['message'] as String,
  addedDates:
      (json['addedDates'] as List<dynamic>?)?.map((e) => e as String).toList(),
  updatedDates:
      (json['updatedDates'] as List<dynamic>).map((e) => e as String).toList(),
  schedule:
      (json['schedule'] as List<dynamic>)
          .map((e) => ScheduleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$AddUpdateScheduleResponseToJson(
  AddUpdateScheduleResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'addedDates': instance.addedDates,
  'updatedDates': instance.updatedDates,
  'schedule': instance.schedule,
};

AddUpdateScheduleData _$AddUpdateScheduleDataFromJson(
  Map<String, dynamic> json,
) => AddUpdateScheduleData(
  schedule:
      (json['schedule'] as List<dynamic>)
          .map((e) => ScheduleData.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$AddUpdateScheduleDataToJson(
  AddUpdateScheduleData instance,
) => <String, dynamic>{'schedule': instance.schedule};

ScheduleData _$ScheduleDataFromJson(Map<String, dynamic> json) => ScheduleData(
  date: DateTime.parse(json['date'] as String),
  timeSlots:
      (json['timeSlots'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$ScheduleDataToJson(ScheduleData instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'timeSlots': instance.timeSlots,
    };
