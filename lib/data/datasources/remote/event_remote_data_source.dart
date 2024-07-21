import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:locura1/domain/entities/eventUnique.dart';
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
        final data = jsonDecode(response.body);
        if (data.containsKey('data')) {
          final List eventsData = data['data'];
          return eventsData.map((eventJson) {
            final miniEventModel = MiniEventModel.fromJson(eventJson);
            return miniEventModelToMiniEvent(miniEventModel);
          }).toList();
        } else {
          throw Exception('Invalid response format: No "data" key found.');
        }
      } else {
        print('Error: ${response.statusCode}');
        print('Mensaje de error: ${response.body}');
        throw Exception('Failed to load mini events');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<EventUnique> getEventById(int id) async {
    final url = Uri.parse('${dotenv.env['APIURL']}/event/$id');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return EventUnique.fromJson(data);
    } else {
      throw Exception('Failed to load event');
    }
  }

  Future<List<EventModel>> getEventsByCategory(String category) async {
    final url = Uri.parse('${dotenv.env['APIURL']}/event/cathegory/$category');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.containsKey('data')) {
        final List eventsData = data['data'];
        return eventsData.map((eventJson) {
          return EventModel.fromJson(eventJson);
        }).toList();
      } else {
        throw Exception('Invalid response format: No "data" key found.');
      }
    } else {
      throw Exception('Failed to load events by category');
    }
  }
}
