import 'package:flutter/material.dart';

class AllPastEventsPage extends StatelessWidget {
  final List<Map<String, String>> pastEvents;
  final Function(BuildContext, Map<String, String>) navigateToPastEvent;

  AllPastEventsPage({required this.pastEvents, required this.navigateToPastEvent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos los Eventos Pasados'),
      ),
      body: ListView.builder(
        itemCount: pastEvents.length,
        itemBuilder: (BuildContext context, int index) {
          final event = pastEvents[index];
          return InkWell(
            onTap: () => navigateToPastEvent(context, event),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      event['image']!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event['title']!,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          event['location']!,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          event['description']!,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
