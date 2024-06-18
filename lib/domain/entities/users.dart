// lib/models/user.dart
class User {
  final String email;
  final String role;

  User({required this.email, required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      role: json['role'],
    );
  }
}
