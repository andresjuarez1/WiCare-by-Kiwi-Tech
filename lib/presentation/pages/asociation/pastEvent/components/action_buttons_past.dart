import 'package:flutter/material.dart';
import '../dialogs/volunteers_dialog.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return VolunteerDialog(
                  imagePath: 'assets/messi.jpg',
                  volunteerName: 'Nombre del Voluntario',
                  volunteerDescription: 'Descripción del voluntario',
                );
              },
            );
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xFF2E8139)),
            minimumSize: MaterialStateProperty.all<Size>(Size(80, 55)),
          ),
          child: Text(
            'Ver voluntarios',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
