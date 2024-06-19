import 'package:flutter/material.dart';

class PastEventsList extends StatelessWidget {
  final List<Map<String, String>> pastEvents;
  final Function(BuildContext, Map<String, String>) navigateToPastEvent;
  final Function(BuildContext) navigateToAllPastEvents;

  PastEventsList({
    required this.pastEvents,
    required this.navigateToPastEvent,
    required this.navigateToAllPastEvents,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 18.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Eventos Pasados',
                style: TextStyle(
                  fontFamily: 'PoppinsRegular',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5CA666),
                ),
              ),
              TextButton(
                onPressed: () {
                  navigateToAllPastEvents(context);
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
        SizedBox(height: 10.0),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: pastEvents.length,
          itemBuilder: (BuildContext context, int index) {
            final event = pastEvents[index];
            return InkWell(
              onTap: () => navigateToPastEvent(context, event),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                          SizedBox(height: 10),
                          Text(
                            event['title']!,
                            style: const TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            event['location']!,
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.0,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            event['description']!,
                            style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 12.0,
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
      ],
    );
  }
}
