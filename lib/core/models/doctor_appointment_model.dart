class ReservationResponse {
  final String? message;
  final List<Reservation>? reservations;

  ReservationResponse({this.message, this.reservations});

  factory ReservationResponse.fromJson(Map<String, dynamic> json) {
    return ReservationResponse(
      message: json['message'],
      reservations: (json['reservations'] as List<dynamic>?)
          ?.map((e) => Reservation.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'reservations': reservations?.map((e) => e.toJson()).toList(),
    };
  }
}

class Reservation {
  final String? id;
  final DateTime? date;
  final String? timeSlot;
  final String? status;
  final Doctor? doctor;
  final User? user;

  Reservation({
    this.id,
    this.date,
    this.timeSlot,
    this.status,
    this.doctor,
    this.user,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      timeSlot: json['timeSlot'],
      status: json['status'],
      doctor: json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date?.toIso8601String(),
      'timeSlot': timeSlot,
      'status': status,
      'doctor': doctor?.toJson(),
      'user': user?.toJson(),
    };
  }
}

class Doctor {
  final String? id;
  final String? name;
  final String? specialization;

  Doctor({this.id, this.name, this.specialization});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      specialization: json['specialization'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
    };
  }
}

class User {
  final String? id;
  final String? username;
  final String? email;

  User({this.id, this.username, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }
}
