import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../domain/entities/miniEvent.dart';
import '../../mappers/mini_events_mappers.dart';
import '../../models/event_model.dart';
import '../../models/mini_event_model.dart';

class EventRemoteDataSource {
  final http.Client client;
  final String token;

  EventRemoteDataSource(this.client, this.token);

  Future<void> createEvent2(EventModel event) async {
    final url = Uri.parse('${dotenv.env['APIURL']}/event');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode(event.toJson());
    final response = await client.post(url, headers: headers, body: body);

    if (response.statusCode != 200) {
      throw Exception('Failed to create event in source');
    }
  }

  Future<void> createEvent(EventModel event, File imageFile) async {
    final url = Uri.parse('${dotenv.env['APIURL']}/event');

    final headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['name'] = event.name
      ..fields['description'] = event.description
      ..fields['hour_start'] = event.hour_start
      ..fields['hour_end'] = event.hour_end
      ..fields['date'] = event.date
      ..fields['cathegory'] = event.cathegory
      ..fields['location'] = event.location;

    if (imageFile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('picture', imageFile.path));
    }

    var response = await request.send();

    if (response.statusCode != 201) {
      throw Exception('Failed to create event in source');
    }
  }

  Future<void> getAllEvents(token) async {
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

        if (responseBody.containsKey('data') && responseBody['data'] is List) {
          final List<dynamic> data = responseBody['data'];
          print('Eventos recibidos: $data');

          final events =
              data.map((event) => MiniEventModel.fromJson(event)).toList();

          return events
              .map((eventModel) => miniEventModelToMiniEvent(eventModel))
              .toList();
        } else {
          throw Exception(
              'La respuesta no contiene una lista en la clave "data"');
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
