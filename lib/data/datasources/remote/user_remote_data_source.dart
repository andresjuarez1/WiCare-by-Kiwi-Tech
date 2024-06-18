// lib/data/datasources/remote/user_remote_data_source.dart
import 'package:http/http.dart' as http;
import 'package:locura1/domain/entities/volunteer.dart';
import 'dart:convert';

import '../../models/user_model.dart';
import '../../models/volunteer_model.dart';

class UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSource(this.client);

  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('http://146.190.64.233:3000/user'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> registerVolunteer(VolunteerModel volunteer) async {
    final response = await client.post(
      Uri.parse('http://146.190.64.233:3000/volunteer/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(volunteer.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register volunteer');
    }
  }
}