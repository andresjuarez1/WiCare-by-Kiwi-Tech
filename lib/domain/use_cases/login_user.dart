// lib/domain/usecases/login_user.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../entities/users.dart';

class LoginUser {
  Future<User?> call(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://146.190.64.233:3000/user'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return User(email: email, role: data['role']);
    } else {
      return null;
    }
  }
}
