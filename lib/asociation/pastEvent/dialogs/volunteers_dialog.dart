import 'package:flutter/material.dart';

class VolunteerDialog extends StatelessWidget {
  final String imagePath;
  final String volunteerName;
  final String volunteerDescription;

  VolunteerDialog({
    required this.imagePath,
    required this.volunteerName,
    required this.volunteerDescription,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(
            volunteerName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            volunteerDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cerrar'),
        ),
      ],
    );
  }
}
