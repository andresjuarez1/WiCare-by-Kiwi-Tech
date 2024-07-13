import 'package:flutter/material.dart';
import './components/navbar.dart';
import './components/custom_drawer.dart';
import './components/search_events.dart';
import './components/upcoming_events_carousel.dart';
import './components/attended_events_list.dart';
import './components/donation_part.dart';
import '../events/event.dart';

class CompanyLandingPage extends StatelessWidget {
  final List<Map<String, String>> imgList = [
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Evento Corporativo 1',
      'subtitle': 'Organización 1'
    },
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Evento Corporativo 2',
      'subtitle': 'Organización 2'
    },
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Evento Corporativo 3',
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

  void _onDonateConfirmed() {
    print('Donación confirmada');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: Navbar(),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            SearchEvents(
              onChanged: (value) {},
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
            FooterComponent(),
          ],
        ),
      ),
    );
  }
}
