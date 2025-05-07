class Pharmacy {
  final String name;
  final List<Branch> branches;

  Pharmacy({
    required this.name,
    required this.branches,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      name: json['name'],
      branches: (json['branches'] as List<dynamic>)
          .map((b) => Branch.fromJson(b))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'branches': branches.map((b) => b.toJson()).toList(),
    };
  }
}

class Branch {
  final String name;
  final String address;
  final String phone;
  final String website;

  Branch({
    required this.name,
    required this.address,
    required this.phone,
    required this.website,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      website: json['website'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
      'website': website,
    };
  }
}
