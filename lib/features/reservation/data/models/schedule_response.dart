import 'schedule_model.dart';

class ScheduleResponse {
  final List<ScheduleModel> schedule;

  ScheduleResponse({required this.schedule});

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) {
    return ScheduleResponse(
      schedule: (json['schedule'] as List)
          .map((item) => ScheduleModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schedule': schedule.map((item) => item.toJson()).toList(),
    };
  }
} 