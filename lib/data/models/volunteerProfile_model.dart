// lib/data/models/volunteer_model.dart
class ProfileVolunteerModel {
  final String name;
  final String cellphone;
  final String occupation;
  final String genre;
  final String email;

  ProfileVolunteerModel({
    required this.name,
    required this.cellphone,
    required this.occupation,
    required this.genre,
    required this.email,
  });

  factory ProfileVolunteerModel.fromJson(Map<String, dynamic> json) {
    return ProfileVolunteerModel(
      name: json['name'],
      cellphone: json['cellphone'],
      occupation: json['occupation'],
      genre: json['genre'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cellphone': cellphone,
      'occupation': occupation,
      'genre': genre,
      'email': email,
    };
  }
}
