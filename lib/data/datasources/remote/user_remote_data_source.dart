// lib/data/datasources/remote/user_remote_data_source.dart
import 'package:http/http.dart' as http;
import 'package:locura1/data/models/association_model.dart';
import 'dart:convert';

import '../../models/user_model.dart';
import '../../models/volunteer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSource(this.client);

  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('http://192.81.209.151:9000/user'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),

    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];

      // Extracción del token de la respuesta
      final String token = data['token'];

      // Guardado del token en SharedPreferences
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('token', token);
      print('Token guardado en SharedPreferences: $token');

      // Devolución del modelo de usuario con los datos obtenidos
      return UserModel.fromJson(data);

    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> registerVolunteer(VolunteerModel volunteer) async {
    final response = await client.post(
      Uri.parse('http://192.81.209.151:9000/user/volunteer'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(volunteer.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register volunteer');
    }
  }
  Future<void> registerAssociation(AssociationModel association) async {
    final response = await client.post(
      Uri.parse('http://192.81.209.151:9000/user/association'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(association.toJson()),
    );
    print(response.body);
    print(association.toJson());

    if (response.statusCode != 200) {
      throw Exception('Failed to register association in user_remote');
    }
  }
}