import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../../domain/entities/miniEvent.dart';
import '../../newMoreEvents/new_more_events.dart';

class NewEventsCarousel extends StatelessWidget {
  final List<MiniEvent> eventsList;
  final Function(BuildContext, String) navigateToEvent;

  NewEventsCarousel({
    required this.eventsList,
    required this.navigateToEvent,
  });

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
                    navigateToEvent(context, event.name);
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
                            child: Text(
                              event.name,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
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
                            event.associationName,
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
