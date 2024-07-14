// lib/data/datasources/remote/user_remote_data_source.dart
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:locura1/data/models/association_model.dart';
import 'package:locura1/data/models/volunteerProfile_model.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import '../../models/company_model.dart';
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
  Future<void> registerCompany(CompanyModel company) async {
    final response = await client.post(
      Uri.parse('http://192.81.209.151:9000/user/company'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(company.toJson()),
    );
    print(response.body);
    print(company.toJson());

    if (response.statusCode != 200) {
      throw Exception('Failed to register company in user_remote');
    }
  }
  Future<void> getProfileVolunteer2(int userId, String token) async {
    final String url = 'http://192.81.209.151:9000/user/volunteer/$userId';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Perfil del usuario:');
        print(data);
      } else {
        print('Error: ${response.statusCode}');
        print('Mensaje de error: ${response.body}');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
    }
  }
  Future<Map<String, dynamic>> getProfileVolunteer(int userId, String token) async {
    final String url = 'http://192.81.209.151:9000/user/volunteer/$userId';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data'];
      } else {
        throw Exception('Failed to get volunteer profile');
      }
    } catch (e) {
      throw Exception('Error in request: $e');
    }
  }
  Future<void> getProfileAssociation2(int userId, String token) async {
    final String url = 'http://192.81.209.151:9000/user/association/$userId';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Perfil de la asociación:');
        print(data);
      } else {
        print('Error: ${response.statusCode}');
        print('Mensaje de error: ${response.body}');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
    }
  }
  Future<Map<String, dynamic>> getProfileAssociation(int userId, String token) async {
    print(userId);
    final String url = 'http://192.81.209.151:9000/user/association/$userId';
    //print('estpy aqui');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
        //print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data'];
      } else {
        throw Exception('Failed to get association profile');
      }
    } catch (e) {
      throw Exception('Error in request: $e');
    }
  }
  Future<Map<String, dynamic>> getProfileCompany(int userId, String token) async {
    //print(userId);
    final String url = 'http://192.81.209.151:9000/user/company/$userId';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data'];
      } else {
        throw Exception('Failed to get company profile');
      }
    } catch (e) {
      throw Exception('Error in request: $e');
    }
  }
  Future<void> updateProfilePicture(int userId, File imageFile) async {
    try {
      final Uri uri = Uri.parse('http://192.81.209.151:9000/user/upload/$userId');
      final request = http.MultipartRequest('PUT', uri);

      // Adjunta el archivo de imagen como FormData
      request.files.add(
        http.MultipartFile(
          'file',
          imageFile.readAsBytes().asStream(),
          imageFile.lengthSync(),
          filename: imageFile.path.split('/').last,
          contentType: MediaType('image', 'jpeg'), // Ajusta según el tipo de archivo
        ),
      );

      // Realiza la solicitud
      final streamedResponse = await request.send();

      // Maneja la respuesta
      if (streamedResponse.statusCode == 200) {
        print('Imagen de perfil actualizada con éxito');
      } else {
        throw Exception('Error al actualizar la imagen de perfil: ${streamedResponse.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }
}