import 'package:flutter/material.dart';

class VolunteerCard extends StatelessWidget {
  final String imagePath;
  final String volunteerName;
  final String volunteerDescription;

  VolunteerCard({
    required this.imagePath,
    required this.volunteerName,
    required this.volunteerDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 30,
        ),
        title: Text(
          volunteerName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(volunteerDescription),
        onTap: () {
        },
      ),
    );
  }
}
