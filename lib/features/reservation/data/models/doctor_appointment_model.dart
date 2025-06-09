class DoctorAppointmentModel {
  final String id;
  final String patientId;
  final String patientName;
  final String date;
  final String time;
  final String status;
  final String? notes;

  DoctorAppointmentModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.date,
    required this.time,
    required this.status,
    this.notes,
  });

  factory DoctorAppointmentModel.fromJson(Map<String, dynamic> json) {
    return DoctorAppointmentModel(
      id: json['_id'] ?? '',
      patientId: json['patientId'] ?? '',
      patientName: json['patientName'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      status: json['status'] ?? '',
      notes: json['notes'],
    );
  }
} 