import 'package:flutter/material.dart';
import 'package:locura1/domain/entities/eventUnique.dart';

class EventDetails extends StatelessWidget {
  final EventUnique event;

  EventDetails({required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Align(
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
          const SizedBox(height: 10),
          Text(
            event.description,
            style: const TextStyle(
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
