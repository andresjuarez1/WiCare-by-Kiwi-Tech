// lib/data/models/user_model.dart
class UserModel {
  final String email;
  final String role;
  final String token;

  UserModel({required this.email, required this.role, required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      role: json['role'],
        token: json['token'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'role': role,
      'token': token,
    };
  }
}
