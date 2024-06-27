// lib/domain/entities/volunteer_profile.dart

class AssociationProfile {
  final String name;
  final String cellphone;
  final String occupation;
  final String genre;
  final String email;

  AssociationProfile({
    required this.name,
    required this.cellphone,
    required this.occupation,
    required this.genre,
    required this.email,
  });

  factory AssociationProfile.fromJson(Map<String, dynamic> json) {
    return AssociationProfile(
      name: json['name'],
      cellphone: json['cellphone'],
      occupation: json['occupation'],
      genre: json['genre'],
      email: json['email'],
    );
  }
}
