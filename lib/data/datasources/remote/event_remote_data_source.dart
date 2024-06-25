import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/event_model.dart';

class EventRemoteDataSource {
  final http.Client client;
  final String token;

  EventRemoteDataSource(this.client, this.token);

  Future<void> createEvent(EventModel eventModel) async {
    print('estoy en source');
    final url = Uri.parse('http://3.212.131.198:9000/event');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode({
      'name': eventModel.name,
      'description': eventModel.description,
      'hour': eventModel.hour,
      'date': eventModel.date,
      'cathegory': eventModel.cathegory,
      'location': eventModel.location,
    });

    final response = await client.post(url, headers: headers, body: body);

    if (response.statusCode != 201) {
      throw Exception('Error al crear el evento');
    }
  }
}
