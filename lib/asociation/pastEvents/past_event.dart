import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {
  final String eventTitle;
  final String eventImage;
  final String eventLocation;
  final String eventDescription;

  EventDetailsPage({
    required this.eventTitle,
    required this.eventImage,
    required this.eventLocation,
    required this.eventDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eventTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(eventImage),
            SizedBox(height: 16),
            Text(
              eventTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              eventLocation,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Text(
              eventDescription,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
