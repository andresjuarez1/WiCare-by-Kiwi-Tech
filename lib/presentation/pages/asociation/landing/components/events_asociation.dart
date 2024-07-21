import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:locura1/data/datasources/remote/event_remote_data_source.dart';
import 'package:locura1/domain/entities/eventUnique.dart';
import 'package:locura1/presentation/pages/asociation/events/event_active.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ActiveEventsCarousel extends StatefulWidget {
  @override
  _ActiveEventsCarouselState createState() => _ActiveEventsCarouselState();
}

class _ActiveEventsCarouselState extends State<ActiveEventsCarousel> {
  late Future<List<EventUnique>> _activeEventsFuture;

  @override
  void initState() {
    super.initState();
    _activeEventsFuture = _fetchActiveEvents();
  }

  Future<List<EventUnique>> _fetchActiveEvents() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    final client = http.Client();
    final eventRemoteDataSource = EventRemoteDataSource(client, token);

    return eventRemoteDataSource.getEventsByAssociation();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EventUnique>>(
      future: _activeEventsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('error: $snapshot.error');
          return Center(child: Text('No hay eventos activos'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay eventos activos'));
        } else {
          final activeEvents = snapshot.data!;
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Eventos activos',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5CA666),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              CarouselSlider.builder(
                itemCount: activeEvents.length,
                itemBuilder: (context, index, realIndex) {
                  final event = activeEvents[index];
                  return GestureDetector(
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
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: event.picture.isNotEmpty
                              ? Image.network(
                            event.picture,
                            fit: BoxFit.cover,
                            width: 1000,
                            height: 200.0,
                          )
                              : Container(
                            width: 1000,
                            height: 200.0,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          width: 1000,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        Positioned(
                          bottom: 40.0,
                          left: 20.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              event.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.fade,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20.0,
                          left: 20.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              event.hour_start,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w200,
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
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}