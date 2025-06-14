import '../../../auth/data/models/sign_in_model/login_response.dart';

class UpdateUserModel {
  final String? username;
  final String? phone;
  final DateTime? dob;
  final String? address;
  final List<String>? medicationHistory;
  final List<String>? medicalHistory;
  final Gender? gender;

  UpdateUserModel({
    this.medicalHistory,
    this.username,
    this.phone,
    this.dob,
    this.address,
    this.medicationHistory,
    this.gender
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (username != null && username!.isNotEmpty) data['username'] = username;
    if (phone != null && phone!.isNotEmpty) data['phone'] = phone;
    if (dob != null) data['DOB'] = dob!.toIso8601String();
    if (address != null && address!.isNotEmpty) data['Adress'] = address;
    if (medicationHistory != null && medicationHistory!.isNotEmpty) {
      data['medicationHistory'] = medicationHistory;
    }
    if (medicalHistory != null && medicalHistory!.isNotEmpty) {
      data['medicalHistory'] = medicalHistory;
    }

    return data;
  }
}
