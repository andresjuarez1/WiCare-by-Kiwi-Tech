import 'package:flutter/material.dart';
import 'package:locura1/domain/entities/eventUnique.dart';

class OrganizerInfo extends StatelessWidget {
  final EventUnique event;

  OrganizerInfo({required this.event});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Información del encargado',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'PoppinsRegular',
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Christian Bumteros',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Encargado de la asociación nueva vida',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 13,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
