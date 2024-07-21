import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:locura1/data/models/association_model.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:locura1/data/models/company_list.dart';
import '../../models/company_model.dart';
import '../../models/user_model.dart';
import '../../models/volunteer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSource(this.client);

  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('${dotenv.env['APIURL']}/user'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];

      final String token = data['token'];
      final int userId = data['data']['id'];

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('token', token);
      await sharedPreferences.setInt('userId', userId);
      print('Token guardado en SharedPreferences: $token');

      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> registerVolunteer(VolunteerModel volunteer) async {
    final response = await client.post(
      Uri.parse('${dotenv.env['APIURL']}/user/volunteer'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(volunteer.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register volunteer');
    }
  }

  Future<void> registerAssociation(AssociationModel association) async {
    final response = await client.post(
      Uri.parse('${dotenv.env['APIURL']}/user/association'),
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
      Uri.parse('${dotenv.env['APIURL']}/user/company'),
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
    final String url = '${dotenv.env['APIURL']}/user/volunteer/$userId';
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

  Future<Map<String, dynamic>> getProfileVolunteer(
      int userId, String token) async {
    final String url = '${dotenv.env['APIURL']}/user/volunteer/$userId';

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
    final String url = '${dotenv.env['APIURL']}/user/association/$userId';

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

  Future<Map<String, dynamic>> getProfileAssociation(
      int userId, String token) async {
    print(userId);
    final String url = '${dotenv.env['APIURL']}/user/association/$userId';
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
        throw Exception('Failed to get association profile');
      }
    } catch (e) {
      throw Exception('Error in request: $e');
    }
  }

  Future<Map<String, dynamic>> getProfileCompany(
      int userId, String token) async {
    final String url = '${dotenv.env['APIURL']}/user/company/$userId';
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

  Future<void> updateProfilePicture(
      int userId, File image, String token) async {
    final request = http.MultipartRequest(
        'PUT', Uri.parse('${dotenv.env['APIURL']}/user/upload/$userId'));

    request.headers['Authorization'] = 'Bearer $token';
    print('estoy en el user remote');
    request.files.add(await http.MultipartFile.fromPath(
      'profilePicture',
      image.path,
      contentType: MediaType('image', 'jpeg'),
    ));
    request.fields['userId'] = userId.toString();

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception(
          'Error al actualizar la imagen de perfil: ${response.reasonPhrase}');
    }
  }

  Future<void> postBankDetails(
      int userId, Map<String, dynamic> bankDetails, String token) async {
    final response = await client.post(
      Uri.parse('${dotenv.env['APIURL']}/user/association/$userId/bank'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(bankDetails),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to post bank details');
    }
  }

  Future<Map<String, dynamic>> getBankDetails(int userId, String token) async {
    final String url = '${dotenv.env['APIURL']}/user/association/$userId/bank';
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
        throw Exception('Failed to get association bank details');
      }
    } catch (e) {
      throw Exception('Error in request: $e');
    }
  }

  Future<List<CompanyRankingModel>> getCompanyRankings() async {
    final String url = '${dotenv.env['APIURL']}/donation/ranking';

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((item) => CompanyRankingModel.fromJson(item)).toList();
      } else {
        throw Exception(
            'Failed to fetch company rankings: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error during fetching company rankings: $e');
      throw Exception('Error in request: $e');
    }
  }

  Future<int?> getVolunteerId() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getInt('userId');
  }

  Future<void> subscribeToEvent(int eventId) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString('token');
    final int? volunteerId = sharedPreferences.getInt('userId');

    if (token == null) {
      throw Exception('Token no encontrado');
    }

    if (volunteerId == null) {
      throw Exception('ID del voluntario no encontrado');
    }

    final response = await client.post(
      Uri.parse('${dotenv.env['APIURL']}/event/$eventId/volunteers'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'volunteer_id': volunteerId}),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Error al suscribirse al evento: ${response.reasonPhrase}');
    }

    print('Suscripción al evento exitosa');
  }
}
