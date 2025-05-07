class Hospital {
  final String name;
  final String location;
  final String type;
  final List<String>? specialties;
  final String? website;

  Hospital({
    required this.name,
    required this.location,
    required this.type,
    this.specialties,
    this.website,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      type: json['type'] ?? '',
      specialties: json['specialties'] != null
          ? List<String>.from(json['specialties'])
          : null,
      website: json['website'],
    );
  }
}
