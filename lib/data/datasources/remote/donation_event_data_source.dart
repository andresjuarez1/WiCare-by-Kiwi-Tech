import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/donation.dart';

Future<void> getDonationsPending2(int userId, String token) async {
  print( userId);
  final String url = '${dotenv.env['APIURL']}/user/association/$userId/donations/pending';
  print('URL de la solicitud: $url'); // Agrega esta línea para depurar

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Donaciones pendientes:');
      print(json.encode(data)); // Imprime en formato JSON para mejor legibilidad
    } else {
      print('Error: ${response.statusCode}');
      print('Mensaje de error: ${response.body}');
    }
  } catch (e) {
    print('Error en la solicitud: $e');
  }
}
Future<List<Donation>> getDonationsPending(int userId, String token) async {
  final String url = '${dotenv.env['APIURL']}/user/association/$userId/donations/pending';
  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> donationsJson = jsonData['data'];
      return donationsJson.map((json) => Donation.fromJson(json)).toList();
    } else {
      print('Error: ${response.statusCode}');
      print('Mensaje de error: ${response.body}');
      return [];
    }
  } catch (e) {
    print('Error en la solicitud: $e');
    return [];
  }
}

