class VolunteerInfo {
  final int id;
  final String email;
  final String role;
  final String name;
  final String? description;
  final String cellphone;
  final String genre;
  final String occupation;
  final String profilePicture;

  VolunteerInfo({
    required this.id,
    required this.email,
    required this.role,
    required this.name,
    this.description,
    required this.cellphone,
    required this.genre,
    required this.occupation,
    required this.profilePicture,
  });

  factory VolunteerInfo.fromJson(Map<String, dynamic> json) {
    return VolunteerInfo(
      id: json['id'],
      email: json['email'],
      role: json['role'],
      name: json['name'],
      description: json['description'],
      cellphone: json['cellphone'],
      genre: json['genre'],
      occupation: json['occupation'],
      profilePicture: json['profilePicture'],
    );
  }
}


class VolunteerInEvent {
  final int userId;
  final VolunteerInfo profile;

  VolunteerInEvent({
    required this.userId,
    required this.profile,
  });

  factory VolunteerInEvent.fromJson(Map<String, dynamic> json) {
    return VolunteerInEvent(
      userId: json['user_id'],
      profile: VolunteerInfo.fromJson(json['profile']),
    );
  }
}