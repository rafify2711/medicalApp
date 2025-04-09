import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/doctor_model/doctor_model.dart';

part 'add_update_schedule_response.g.dart';

@JsonSerializable()
class AddUpdateScheduleResponse {
  final String message;
  @JsonKey(name: 'addedDates')
  final List<String>? addedDates;
  @JsonKey(name: 'updatedDates')
  final List<String> updatedDates;
  final List<ScheduleModel> schedule;

  AddUpdateScheduleResponse({
    required this.message,
     this.addedDates,
    required this.updatedDates,
    required this.schedule,
  });

  factory AddUpdateScheduleResponse.fromJson(Map<String, dynamic> json) =>
      _$AddUpdateScheduleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddUpdateScheduleResponseToJson(this);
}

@JsonSerializable()
class AddUpdateScheduleData {
  List<ScheduleData> schedule;

  AddUpdateScheduleData({required this.schedule});

  factory AddUpdateScheduleData.fromJson(Map<String, dynamic> json) =>
      _$AddUpdateScheduleDataFromJson(json);
  Map<String, dynamic> toJson() => _$AddUpdateScheduleDataToJson(this);
}



@JsonSerializable()
class ScheduleData {
  final DateTime date;
  late final List<String> timeSlots;

  ScheduleData({
    required this.date,
    required this.timeSlots,

  });

  factory ScheduleData.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDataFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleDataToJson(this);
}

