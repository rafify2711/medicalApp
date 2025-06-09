class ScheduleModel {
  final String? id;
  final DateTime? date;
  final List<String>? timeSlots;

  ScheduleModel({
    this.id,
    this.date,
    this.timeSlots,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['_id'],
      date: DateTime.parse(json['date']),
      timeSlots: List<String>.from(json['timeSlots']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'date': date?.toIso8601String(),
      'timeSlots': timeSlots,
    };
  }
} 