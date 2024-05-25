import 'package:flutter/material.dart';

class MoreEventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Más eventos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5CA666),
                ),
              ),
            ),
            SizedBox(height: 20),
            EventItem(title: 'Evento 1', location: 'Lugar 1', description: 'Descripción del evento 1'),
            EventItem(title: 'Evento 2', location: 'Lugar 2', description: 'Descripción del evento 2'),
            EventItem(title: 'Evento 3', location: 'Lugar 3', description: 'Descripción del evento 3'),
          ],
        ),
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  final String title;
  final String location;
  final String description;

  EventItem({required this.title, required this.location, required this.description});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(location),
          Text(description),
        ],
      ),
      onTap: () {
        // Acción al presionar un evento
      },
    );
  }
}
