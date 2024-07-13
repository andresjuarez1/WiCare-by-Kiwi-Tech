class VolunteerProfile {
  final String name;
  final String cellphone;
  final String occupation;
  final String genre;
  final String email;
  final String profilePicture;

  VolunteerProfile({
    required this.name,
    required this.cellphone,
    required this.occupation,
    required this.genre,
    required this.email,
    required this.profilePicture
  });

  factory VolunteerProfile.fromJson(Map<String, dynamic> json) {
    return VolunteerProfile(
      name: json['name'],
      cellphone: json['cellphone'],
      occupation: json['occupation'],
      genre: json['genre'],
      email: json['email'],
      profilePicture: json['profilePicture'],
    );
  }
}
