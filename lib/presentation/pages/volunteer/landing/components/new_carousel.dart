import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:locura1/domain/entities/eventUnique.dart';
import '../../../../../domain/entities/miniEvent.dart';
import '../../newMoreEvents/new_more_events.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../data/datasources/remote/event_remote_data_source.dart';
import 'package:http/http.dart' as http;

class NewEventsCarousel extends StatelessWidget {
  final List<MiniEvent> eventsList;
  final Function(BuildContext, EventUnique) navigateToEvent;

  NewEventsCarousel({
    required this.eventsList,
    required this.navigateToEvent,
  });

  Future<void> _handleEventTap(BuildContext context, int eventId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      final EventRemoteDataSource eventRemoteDataSource =
          EventRemoteDataSource(http.Client(), token);
      final EventUnique event = await eventRemoteDataSource.getEventById(eventId);

      navigateToEvent(context, event);
    } else {
      throw Exception('Token not found in SharedPreferences');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Nuevos eventos',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'PoppinsRegular',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5CA666),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewMoreEventsPage(),
                    ),
                  );
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
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: eventsList.map((event) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    _handleEventTap(context, event.id);
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          width: 1000,
                          height: 200.0,
                          color: Colors.grey.shade300,
                          child: Center(
                            child: Image.network(
                              event.picture,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        width: 250.0,
                        bottom: 30.0,
                        left: 20.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            event.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'PoppinsRegular',
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            softWrap: true,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10.0,
                        left: 20.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            event.description,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14.0,
                            ),
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
