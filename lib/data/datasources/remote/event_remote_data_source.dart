import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../domain/entities/event.dart';
import '../../../domain/entities/miniEvent.dart';
import '../../mappers/mini_events_mappers.dart';
import '../../models/event_model.dart';
import '../../models/mini_event_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EventRemoteDataSource {
  final http.Client client;
  final String token;

  EventRemoteDataSource(this.client, this.token);

  Future<void> createEvent2(EventModel event) async {
    // Define la URL del endpoint.
    final url = Uri.parse('${dotenv.env['APIURL']}/event');

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

  Future<void> createEvent(Event event, File image) async {
    final uri = Uri.parse('${dotenv.env['APIURL']}/event'); // Cambia la URL según tu API
    print('estoy en el user remote');
    // Crear una solicitud MultipartRequest
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token' // Agregar el token al encabezado
      ..fields['name'] = event.name
      ..fields['description'] = event.description
      ..fields['hour_start'] = event.hour_start
      ..fields['hour_end'] = event.hour_end
      ..fields['date'] = event.date
      ..fields['cathegory'] = event.cathegory;
    // Adjuntar la imagen al request si existe
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'picture', // Asegúrate de que este nombre coincida con el que espera tu API
        image.path,
      ));
    }
    print('--- Enviando solicitud ---');
    print('URL: $uri');
    print('Headers: ${request.headers}');
    print('Fields: ${request.fields}');
    if (image != null) {
      print('Imagen: ${image.path}');
    }

    // Enviar la solicitud y obtener la respuesta
    final response = await request.send();
    // Verificar el estado de la respuesta
    if (response.statusCode != 200) { // Cambia el código de estado según lo que espera tu API
      throw Exception('Error al crear el evento: ${response.reasonPhrase}');
    }
  }

  Future<void> getAllEvents(token ) async {
    final String url = '${dotenv.env['APIURL']}/event';

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
    final url = Uri.parse('${dotenv.env['APIURL']}/event');

    try {
      final response = await client.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('data')) {
          final List<dynamic> data = responseBody['data'];
          // Imprime los eventos recibidos
          print('Eventos recibidos: $data');

          // Convierte la respuesta JSON a una lista de MiniEventModel.
          final events = data.map((event) => MiniEventModel.fromJson(event)).toList();

          // Convierte la lista de MiniEventModel a una lista de MiniEvent usando el mapper.
          return events.map((eventModel) => miniEventModelToMiniEvent(eventModel)).toList();
        } else {
          throw Exception('La respuesta no contiene la clave "data"');
        }
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
