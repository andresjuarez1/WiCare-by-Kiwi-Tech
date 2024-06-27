// lib/domain/entities/volunteer_profile.dart

class VolunteerProfile {
  final String name;
  final String cellphone;
  final String occupation;
  final String genre;
  final String email;

  VolunteerProfile({
    required this.name,
    required this.cellphone,
    required this.occupation,
    required this.genre,
    required this.email,
  });

  factory VolunteerProfile.fromJson(Map<String, dynamic> json) {
    return VolunteerProfile(
      name: json['name'],
      cellphone: json['cellphone'],
      occupation: json['occupation'],
      genre: json['genre'],
      email: json['email'],
    );
  }
}
