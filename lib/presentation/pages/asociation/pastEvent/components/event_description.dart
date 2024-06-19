import 'package:flutter/material.dart';

class EventDescription extends StatelessWidget {
  final String eventTitle;
  final String eventLocation;
  final String eventDescription;

  EventDescription({
    required this.eventTitle,
    required this.eventLocation,
    required this.eventDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eventTitle,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'PoppinsRegular',
            color: Color(0xFF5CA666),
          ),
        ),
        SizedBox(height: 8),
        Text(
          eventLocation,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 16),
        const Text(
          'Descripción',
          style: TextStyle(
            fontFamily: 'PoppinsRegular',
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 7),
        Text(
          eventDescription,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'PoppinsRegular',
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
