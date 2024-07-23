import 'package:flutter/material.dart';
import 'package:locura1/data/models/volunteer_event.dart';
import 'package:locura1/presentation/pages/asociation/events/dialogs/volunteer_profile_asociation.dart';

class VolunteerDialog extends StatefulWidget {
  final Future<List<VolunteerInEvent>> volunteersFuture;

  VolunteerDialog({required this.volunteersFuture});

  @override
  _VolunteerDialogState createState() => _VolunteerDialogState();
}

class _VolunteerDialogState extends State<VolunteerDialog> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VolunteerInEvent>>(
      future: widget.volunteersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(
            Text('Error: ${snapshot.error}'),
          );
          return AlertDialog(
            backgroundColor: Colors.white,
            content: const SizedBox(
              height: 100,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20.0),
                    Text('No se encontraron voluntarios para este evento',
                        style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cerrar', style:TextStyle(fontFamily: 'PoppinsRegular', fontSize: 14, color: Colors.black),),
              ),
            ],
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No volunteers available'));
        } else {
          final volunteers = snapshot.data!;
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Voluntarios'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: volunteers.map((volunteer) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VolunteerDetailPage(volunteer: volunteer),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(volunteer.profile.profilePicture),
                      ),
                      title: Text(volunteer.profile.name),
                      subtitle: Text(volunteer.profile.occupation),
                    ),
                  );
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cerrar'),
              ),
            ],
          );
        }
      },
    );
  }
}

