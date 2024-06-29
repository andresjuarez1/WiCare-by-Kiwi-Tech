import 'package:flutter/material.dart';

class EventDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Descripción',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'PoppinsRegular',
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Día del niño en la asociación nueva vida, se realizará una actividad para todos los niños de la asociación, se les dará un pequeño detalle y se les realizará una actividad de relajación. Se necesita voluntarios para la organización del evento.',
            style: TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w200,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
