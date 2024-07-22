import 'package:flutter/material.dart';
import 'package:locura1/data/datasources/remote/event_remote_data_source.dart';
import 'package:locura1/domain/entities/eventUnique.dart';
import 'package:locura1/presentation/pages/volunteer/newEvent/event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ActiveEventsList extends StatefulWidget {
  @override
  _ActiveEventsListState createState() => _ActiveEventsListState();
}

class _ActiveEventsListState extends State<ActiveEventsList> {
  List<EventUnique> activeEvents = [];

  @override
  void initState() {
    super.initState();
    _getActiveEvents();
  }

  Future<void> _getActiveEvents() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      final EventRemoteDataSource eventRemoteDataSource =
          EventRemoteDataSource(http.Client(), token);
      final List<dynamic> events =
          await eventRemoteDataSource.getActiveEvents();

      setState(() {
        activeEvents = events.map((e) => EventUnique.fromJson(e)).toList();
      });
    } else {
      throw Exception('Token o userId no encontrados en SharedPreferences');
    }
  }

  void _navigateToEventDetail(BuildContext context, EventUnique event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewEventPage(event: event),
      ),
    );
  }

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
                'Eventos Activos',
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
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: activeEvents.length,
          itemBuilder: (BuildContext context, int index) {
            final event = activeEvents[index];
            return GestureDetector(
              onTap: () => _navigateToEventDetail(context, event),
              child: Padding(
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
                              : const SizedBox(width: 100, height: 100),
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
