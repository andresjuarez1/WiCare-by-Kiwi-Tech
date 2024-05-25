import 'package:flutter/material.dart';
import 'components/landing/navbar.dart';
import 'components/landing/custom_drawer.dart';
import 'components/landing/search_events.dart';
import 'components/landing/upcoming_events_carousel.dart';
import 'components/landing/attended_events_list.dart';
import 'components/landing/donation_part.dart';
import '../../events/event.dart';

class VolunteerPage extends StatelessWidget {
  final List<Map<String, String>> imgList = [
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Extinguir el fuego en el mactumatza 1',
      'subtitle': 'Organización 1'
    },
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Extinguir el fuego en el mactumatza 2',
      'subtitle': 'Organización 2'
    },
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Extinguir el fuego en el mactumatza 3',
      'subtitle': 'Organización 3'
    },
  ];

  final List<Map<String, String>> attendedEvents = [
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Evento Asistido 1',
      'location': 'Lugar 1',
      'description': 'Descripción del evento asistido 1'
    },
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Evento Asistido 2',
      'location': 'Lugar 2',
      'description': 'Descripción del evento asistido 2'
    },
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Evento Asistido 3',
      'location': 'Lugar 3',
      'description': 'Descripción del evento asistido 3'
    },
  ];

  void _navigateToEvent(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventPage(eventTitle: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            SearchEvents(
              onChanged: (value) {
                // acción al cambiar el texto del campo de búsqueda
              },
            ),
            UpcomingEventsCarousel(
              imgList: imgList,
              navigateToEvent: _navigateToEvent,
            ),
            SizedBox(height: 20),
            AttendedEventsList(
              attendedEvents: attendedEvents,
            ),
            SizedBox(height: 20),
            FooterComponent(
              onPressed: () {
                // acción al presionar el botón de donar
              },
            ),
          ],
        ),
      ),
    );
  }
}
