import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/donation.dart';

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
      if (jsonData['data'] is List) {
        final List<dynamic> donationsJson = jsonData['data'];
        return donationsJson.map((json) {
          if (json is Map<String, dynamic>) {
            return Donation.fromJson(json);
          } else {
            print('Estructura inesperada de donación: $json');
            throw Exception('Estructura inesperada de donación');
          }
        }).toList();
      } else {
        print('Estructura inesperada de respuesta: $jsonData');
        return [];
      }
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
Future<void> updateDonationStatus(int donationId, String status, String token) async {
  print(donationId);
  final String url = '${dotenv.env['APIURL']}/donation/$donationId'; // Ajusta la URL según tu API
print('entre al update');
  try {
    final response = await http.put(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print('Donación actualizada exitosamente.');
    } else {
      print('Error: ${response.statusCode}');
      print('Mensaje de error: ${response.body}');
    }
  } catch (e) {
    print('Error en la solicitud: $e');
  }
}