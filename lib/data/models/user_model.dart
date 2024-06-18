// lib/data/models/user_model.dart
class UserModel {
  final String email;
  final String role;

  UserModel({required this.email, required this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      role: json['role'],
    );
  }
}