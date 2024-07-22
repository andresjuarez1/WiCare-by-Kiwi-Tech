import 'package:flutter/material.dart';
import 'package:locura1/data/models/volunteer_event.dart';
import 'package:locura1/presentation/pages/asociation/events/dialogs/volunteers_dialog.dart';

class ActionButtons extends StatelessWidget {
  final Future<List<VolunteerInEvent>> volunteersFuture;

  ActionButtons({required this.volunteersFuture});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) =>
                  VolunteerDialog(volunteersFuture: volunteersFuture),
            );
          },
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all<Color>(const Color(0xFF2E8139)),
            minimumSize: WidgetStateProperty.all<Size>(const Size(70, 45)),
          ),
          child: const Text(
            'Ver voluntarios',
            style: TextStyle(color: Colors.white, fontFamily: 'PoppinsRegular'),
          ),
        ),
      ],
    );
  }
}
