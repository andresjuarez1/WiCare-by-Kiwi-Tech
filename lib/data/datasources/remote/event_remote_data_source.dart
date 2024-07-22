import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:locura1/data/models/volunteer_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/entities/event.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:locura1/domain/entities/eventUnique.dart';
import '../../../domain/entities/miniEvent.dart';
import '../../mappers/mini_events_mappers.dart';
import '../../models/event_model.dart';
import '../../models/mini_event_model.dart';
import 'package:http_parser/http_parser.dart';

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

  Future<void> createEvent(Event event, File image) async {
    final uri = Uri.parse('${dotenv.env['APIURL']}/event');
    print('estoy en el user remote');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['name'] = event.name
      ..fields['description'] = event.description
      ..fields['hour_start'] = event.hour_start
      ..fields['hour_end'] = event.hour_end
      ..fields['date'] = event.date
      ..fields['cathegory'] = event.cathegory;
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'picture',
        image.path,
        contentType: MediaType('image', 'jpeg'),
      ));
    }
    print('--- Enviando solicitud ---');
    print('URL: $uri');
    print('Headers: ${request.headers}');
    print('Fields: ${request.fields}');
    if (image != null) {
      print('Imagen: ${image.path}');
    }

    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Error al crear el evento: ${response.reasonPhrase}');
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

  Future<List<EventUnique>> getEventsByAssociation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');

    if (userId == null) {
      throw Exception('User ID not found in SharedPreferences');
    }

    final url =
        Uri.parse('${dotenv.env['APIURL']}/user/association/$userId/events');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await client.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('data')) {
          final List eventsData = data['data'];
          return eventsData.map((eventJson) {
            return EventUnique.fromJson(eventJson);
          }).toList();
        } else {
          throw Exception('Invalid response format: No "data" key found.');
        }
      } else {
        print('Error: ${response.statusCode}');
        print('Mensaje de error: ${response.body}');
        throw Exception('Failed to load events by association');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<List<VolunteerInEvent>> getVolunteersByEventId(int eventId) async {
    final url = Uri.parse('${dotenv.env['APIURL']}/event/$eventId/volunteers');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    print('URL: $url');
    print('Headers: $headers');
    try {
      final response = await client.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('data')) {
          final List volunteersData = data['data'];
          return volunteersData.map((volunteerJson) {
            return VolunteerInEvent.fromJson(volunteerJson);
          }).toList();
        } else {
          throw Exception('Invalid response format: No "data" key found.');
        }
      } else {
        print('Error: ${response.statusCode}');
        print('Mensaje de error: ${response.body}');
        throw Exception('Failed to load volunteers');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<List<EventUnique>> getFinishedEventsForUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');

    if (userId == null) {
      throw Exception('User ID not found in SharedPreferences');
    }

    final url = Uri.parse(
        '${dotenv.env['APIURL']}/user/volunteer/$userId/events/finished');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await client.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('data')) {
          final List eventsData = data['data'];
          return eventsData.map((eventJson) {
            return EventUnique.fromJson(eventJson);
          }).toList();
        } else {
          throw Exception('Invalid response format: No "data" key found.');
        }
      } else {
        print('Error: ${response.statusCode}');
        print('Mensaje de error: ${response.body}');
        throw Exception('Failed to load finished events for user');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<List<dynamic>> getActiveEvents() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString('token');
    final int? userId = sharedPreferences.getInt('userId');

    if (token == null) {
      throw Exception('Token no encontrado');
    }

    if (userId == null) {
      throw Exception('ID del usuario no encontrado');
    }

    final String url =
        '${dotenv.env['APIURL']}/user/volunteer/$userId/events/coming';

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        return data;
      } else {
        throw Exception(
            'Failed to fetch active events: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error in request: $e');
    }
  }
}
