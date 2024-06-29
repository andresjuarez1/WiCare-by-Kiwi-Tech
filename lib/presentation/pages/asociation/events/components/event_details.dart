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
            'Día de las madres es una actividad que se realiza cada año en la asociación corazón, en la cual se celebra a todas las madres de la comunidad, se les brinda un espacio de esparcimiento y se les obsequian regalos. La actividad se realiza en el mes de mayo y se lleva a cabo en las instalaciones de la asociación.',
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
