class VolunteerProfile {
  final String name;
  final String cellphone;
  final String occupation;
  final String genre;
  final String email;
  final String? profilePicture;
  final int id;
  final String description;

  VolunteerProfile(
      {required this.name,
      required this.cellphone,
      required this.occupation,
      required this.genre,
      required this.email,
      this.profilePicture,
      required this.id,
        required this.description
      });

  factory VolunteerProfile.fromJson(Map<String, dynamic> json) {
    return VolunteerProfile(
      name: json['name'],
      cellphone: json['cellphone'],
      occupation: json['occupation'],
      genre: json['genre'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      id: json['id'],
        description: json['description']
    );
  }
}
