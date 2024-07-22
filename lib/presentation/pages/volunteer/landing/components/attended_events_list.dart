import 'package:flutter/material.dart';
import '../../assistedEvents/attended_events_page.dart';
import 'package:locura1/domain/entities/eventUnique.dart';

class AttendedEventsList extends StatelessWidget {
  final List<EventUnique> attendedEvents;

  AttendedEventsList({required this.attendedEvents});

  void _navigateToAttendedEvents(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AttendedEventsPage(attendedEvents: attendedEvents),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Eventos Asistidos',
                style: TextStyle(
                  fontFamily: 'PoppinsRegular',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5CA666),
                ),
              ),
              TextButton(
                onPressed: () {
                  _navigateToAttendedEvents(context);
                },
                child: const Text(
                  'Ver más',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF717171),
                    fontFamily: 'PoppinsRegular',
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: attendedEvents.length,
          itemBuilder: (BuildContext context, int index) {
            final event = attendedEvents[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(
                      children: [
                        event.picture != null
                            ? Image.network(
                                event.picture,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              )
                            : SizedBox(width: 100, height: 100),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0),
                        if (event.name != null)
                          Text(
                            event.name,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsRegular',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        const SizedBox(height: 5.0),
                        if (event.description != null)
                          Text(
                            event.date,
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 13.0,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
