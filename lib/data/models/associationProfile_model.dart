// lib/data/models/volunteer_model.dart
class ProfileAssociationModel {
  final String name;
  final String cellphone;
  final String occupation;
  final String genre;
  final String email;

  ProfileAssociationModel({
    required this.name,
    required this.cellphone,
    required this.occupation,
    required this.genre,
    required this.email,
  });

  factory ProfileAssociationModel.fromJson(Map<String, dynamic> json) {
    return ProfileAssociationModel(
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
