import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../domain/entities/miniEvent.dart';
import '../../mappers/mini_events_mappers.dart';
import '../../models/event_model.dart';
import '../../models/mini_event_model.dart';

class EventRemoteDataSource {
  final http.Client client;
  final String token;

  EventRemoteDataSource(this.client, this.token);

  Future<void> createEvent2(EventModel event) async {
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
  Future<void> createEvent(EventModel event, File imageFile) async {
    final url = Uri.parse('http://192.81.209.151:9000/event');

    // Define los headers, incluyendo el token de autorización.
    final headers = {
      'Authorization': 'Bearer $token', // Agrega el token en el encabezado de autorización.
    };

    // Crear un MultipartRequest
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['name'] = event.name
      ..fields['description'] = event.description
      ..fields['hour_start'] = event.hour_start
      ..fields['hour_end'] = event.hour_end
      ..fields['date'] = event.date
      ..fields['cathegory'] = event.cathegory
      ..fields['location'] = event.location;

    // Adjuntar la imagen al request si existe
    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('picture', imageFile.path));
    }

    // Enviar el request y obtener la respuesta
    var response = await request.send();

    // Verificar el estado de la respuesta
    if (response.statusCode != 201) { // Asegúrate de que el estado de respuesta esperado sea 201.
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
        //print('Eventos');
        //print(data);
      } else {
        print('Error: ${response.statusCode}');
        print('Mensaje de error: ${response.body}');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
    }
  }
  Future<List<MiniEvent>> getAllMiniEvents() async {
    final url = Uri.parse('http://192.81.209.151:9000/event');

    try {
      final response = await client.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        //print('Eventos recibidos: $data');

        // Convierte la respuesta JSON a una lista de MiniEventModel.
        final events = data.map((event) => MiniEventModel.fromJson(event)).toList();

        // Convierte la lista de MiniEventModel a una lista de MiniEvent usando el mapper.
        return events.map((eventModel) => miniEventModelToMiniEvent(eventModel)).toList();
      } else {
        print('Error al obtener los eventos: ${response.statusCode}');
        print('Mensaje de error: ${response.body}');
        throw Exception('Failed to get events: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      throw Exception('Failed to get events: $e');
    }
  }
}
