import 'package:flutter/material.dart';
import 'package:locura1/domain/entities/eventUnique.dart';

class AttendedEventsPage extends StatelessWidget {
  final List<EventUnique> attendedEvents;

  AttendedEventsPage({required this.attendedEvents});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Eventos asistidos',
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'PoppinsRegular',
            fontWeight: FontWeight.w600,
            color: Color(0xFF5CA666),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: attendedEvents.length,
          itemBuilder: (BuildContext context, int index) {
            final event = attendedEvents[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : SizedBox(width: 100, height: 100),
                        Container(
                          width: 100,
                          height: 100,
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
                            event.description,
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 13.0,
                              color: Colors.grey[600],
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
      ),
    );
  }
}
