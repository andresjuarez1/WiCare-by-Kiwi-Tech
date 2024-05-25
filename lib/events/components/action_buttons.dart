import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            // acción cuando se presiona el botón "Me Apunto"
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF2E8139)),
            minimumSize: MaterialStateProperty.all<Size>(Size(80, 55)),
          ),
          child: Text(
            'Me Apunto',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            // acción cuando se presiona el botón "Donar"
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF2E8139)),
            minimumSize: MaterialStateProperty.all<Size>(Size(80, 55)),
          ),
          child: Text(
            'Donar',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
