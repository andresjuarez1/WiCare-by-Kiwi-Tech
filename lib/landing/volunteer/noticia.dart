import 'package:flutter/material.dart';

class EventPage extends StatelessWidget {
  final String eventTitle;

  EventPage({required this.eventTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eventTitle),
      ),
      body: Center(
        child: Text('Detalles del $eventTitle'),
      ),
    );
  }
}