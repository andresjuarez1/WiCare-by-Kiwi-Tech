import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/event_model.dart';

class EventRemoteDataSource {
  final http.Client client;
  final String token;

  EventRemoteDataSource(this.client, this.token);

  Future<void> createEvent(EventModel event) async {
    // Define la URL del endpoint.
    final url = Uri.parse('http://192.81.209.151:9000/event');

    // Define los headers, incluyendo el token de autorización.
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Agrega el token en el encabezado de autorización.
    };

    final body = jsonEncode(event.toJson());
    final response = await client.post(url, headers: headers, body: body);

    if (response.statusCode != 200) { // Asegúrate de que el estado de respuesta esperado sea 201.
      throw Exception('Failed to create event in source');
    }
  }
  Future<void> getAllEvents(token ) async {
    final String url = 'http://192.81.209.151:9000/event';

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
        print('Eventos');
        print(data);
      } else {
        print('Error: ${response.statusCode}');
        print('Mensaje de error: ${response.body}');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
    }
  }
}
