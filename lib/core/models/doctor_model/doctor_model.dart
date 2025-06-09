class DoctorModel {
  final ContactModel? contact;
  final String? name;
  final List<String>? careerPath;
  final List<String>? highlights;
  final String? id;
  final String? username;
  final String? email;
  final String? specialty;
  final String? password;
  final String? phone;
  final String? gender;
  final String? changePasswordTime;
  final bool? isDeleted;
  final String? profilePhoto;
  final List<String>? reservations;
  final List<dynamic>? schedule; // ممكن تكون String أو ScheduleModel
  final int? v;
  final String? role;
  final String? bio;
  final int? experience;
  final String? updatedAt;

  DoctorModel({
    this.contact,
    this.name,
    this.careerPath,
    this.highlights,
    this.id,
    this.username,
    this.email,
    this.specialty,
    this.password,
    this.phone,
    this.gender,
    this.changePasswordTime,
    this.isDeleted,
    this.profilePhoto,
    this.reservations,
    this.schedule,
    this.v,
    this.role,
    this.bio,
    this.experience,
    this.updatedAt,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      contact: json['contact'] != null ? ContactModel.fromJson(json['contact']) : null,
      name: json['name'],
      careerPath: (json['careerPath'] as List?)?.cast<String>(),
      highlights: (json['highlights'] as List?)?.cast<String>(),
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      specialty: json['specialty'],
      password: json['password'],
      phone: json['phone'],
      gender: json['gender'],
      changePasswordTime: json['changePasswordTime'],
      isDeleted: json['isDeleted'],
      profilePhoto: json['profilePhoto'],
      reservations: (json['reservations'] as List?)?.cast<String>(),
      schedule: json['schedule'] != null
          ? (json['schedule'] as List).map((item) {
        if (item is String) return item;
        return ScheduleModel.fromJson(item);
      }).toList()
          : null,
      v: json['__v'],
      role: json['role'],
      bio: json['bio'],
      experience: json['experience'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contact': contact?.toJson(),
      'name': name,
      'careerPath': careerPath,
      'highlights': highlights,
      '_id': id,
      'username': username,
      'email': email,
      'specialty': specialty,
      'password': password,
      'phone': phone,
      'gender': gender,
      'changePasswordTime': changePasswordTime,
      'isDeleted': isDeleted,
      'profilePhoto': profilePhoto,
      'reservations': reservations,
      'schedule': schedule?.map((item) {
        if (item is String) return item;
        return (item as ScheduleModel).toJson();
      }).toList(),
      '__v': v,
      'role': role,
      'bio': bio,
      'experience': experience,
      'updatedAt': updatedAt,
    };
  }
}

class ScheduleModel {
  final DateTime? date;
  final List<String>? timeSlots;
  final String? id;

  ScheduleModel({this.date, this.timeSlots, this.id});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      timeSlots: (json['timeSlots'] as List?)?.cast<String>(),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date?.toIso8601String(),
      'timeSlots': timeSlots,
      'id': id,
    };
  }
}

class ContactModel {
  final String? facebook;
  final String? linkedin;
  final String? twitter;
  final String? website;
  final String? whatsapp;
  final String? phone;

  ContactModel({
    this.facebook,
    this.linkedin,
    this.twitter,
    this.website,
    this.whatsapp,
    this.phone,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      facebook: json['facebook'],
      linkedin: json['linkedin'],
      twitter: json['twitter'],
      website: json['website'],
      whatsapp: json['whatsapp'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'facebook': facebook,
      'linkedin': linkedin,
      'twitter': twitter,
      'website': website,
      'whatsapp': whatsapp,
      'phone': phone,
    };
  }
}
