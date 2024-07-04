// lib/domain/entities/volunteer_profile.dart

class CompanyProfile {
  final String name;
  final String cellphone;
  final String location;
  final String description;
  final String email;

  CompanyProfile({
    required this.name,
    required this.cellphone,
    required this.location,
    required this.description,
    required this.email,
  });

  factory CompanyProfile.fromJson(Map<String, dynamic> json) {
    return CompanyProfile(
      name: json['name'],
      cellphone: json['cellphone'],
      location: json['location'],
      description: json['description'],
      email: json['email'],
    );
  }
}
