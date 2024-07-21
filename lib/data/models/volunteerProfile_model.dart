// lib/data/models/volunteer_model.dart
class ProfileVolunteerModel {
  final String name;
  final String cellphone;
  final String occupation;
  final String genre;
  final String email;
  final String? profilePicture;
  final int id;

  ProfileVolunteerModel({
    required this.name,
    required this.cellphone,
    required this.occupation,
    required this.genre,
    required this.email,
    this.profilePicture,
    required this.id
  });

  factory ProfileVolunteerModel.fromJson(Map<String, dynamic> json) {
    return ProfileVolunteerModel(
      name: json['name'],
      cellphone: json['cellphone'],
      occupation: json['occupation'],
      genre: json['genre'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      id: json['id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cellphone': cellphone,
      'occupation': occupation,
      'genre': genre,
      'email': email,
      'profilePicture': profilePicture,
      'id': id
    };
  }
}
