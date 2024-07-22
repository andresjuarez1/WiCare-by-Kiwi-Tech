import 'package:flutter/material.dart';
import 'package:locura1/domain/entities/eventUnique.dart';
import 'package:locura1/presentation/pages/asociation/events/event_active.dart'; // Asegúrate de que esta sea la página correcta

class AllPastEventsList extends StatelessWidget {
  final List<EventUnique> pastEvents;

  AllPastEventsList({required this.pastEvents});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18.0),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Eventos Pasados',
                style: TextStyle(
                  fontFamily: 'PoppinsRegular',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5CA666),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        pastEvents.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'No hay eventos pasados.',
                  style: TextStyle(
                    fontFamily: 'PoppinsRegular',
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: pastEvents.length,
                itemBuilder: (BuildContext context, int index) {
                  final event = pastEvents[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventPageActive(
                              event: event,
                            ),
                          ),
                        );
                      },
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
                                    : const SizedBox(width: 80, height: 80),
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
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
                                if (event.date != null)
                                  Text(
                                    event.date,
                                    style: const TextStyle(
                                      fontFamily: 'PoppinsRegular',
                                      fontSize: 13.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
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
