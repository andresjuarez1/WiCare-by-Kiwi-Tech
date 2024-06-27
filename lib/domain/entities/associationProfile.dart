// lib/domain/entities/volunteer_profile.dart

class AssociationProfile {
  final String name;
  final String cellphone;
  final String location;
  final String description;
  final String email;

  AssociationProfile({
    required this.name,
    required this.cellphone,
    required this.location,
    required this.description,
    required this.email,
  });

  factory AssociationProfile.fromJson(Map<String, dynamic> json) {
    return AssociationProfile(
      name: json['name'],
      cellphone: json['cellphone'],
      location: json['location'],
      description: json['description'],
      email: json['email'],
    );
  }
}
