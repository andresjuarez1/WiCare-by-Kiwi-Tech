import 'package:http/http.dart' as http;
import 'dart:convert';
import '../entities/users.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginUser {
  Future<User?> call(String email, String password) async {
    final response = await http.post(
      Uri.parse('${dotenv.env['APIURL']}/user'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      print('estoy aqui');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final responseData = jsonDecode(response.body);
      final int userId = responseData['data']['id'];
      final String? token = responseData['token'];
      if (token == null) {
        print('Token no encontrado en la respuesta.');
        return null;
      }
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('token', token);
      await sharedPreferences.setInt('userId', userId);

      final data = responseData['data'];

      return User(email: email, role: data['role']);
    } else {
      return null;
    }
  }
}
