import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/datasources/remote/event_remote_data_source.dart';
import 'components/navbar.dart';
import 'components/custom_drawer.dart';
import 'components/search_events.dart';
import 'components/upcoming_events_carousel.dart';
import 'components/donation_part.dart';
import 'components/new_events_carousel.dart';
import '../newEvent/event.dart';
import '../events/event.dart';
import 'package:http/http.dart' as http;

class VolunteerPage extends StatelessWidget {
  Future <void> _getProfile() async {
    print('Botón "Obtener eventos');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    print(token);

    if (token != null ) {
      final EventRemoteDataSource eventRemoteDataSource = EventRemoteDataSource(http.Client(), token);
      await eventRemoteDataSource.getAllEvents(token);
      print('Eventos todos');

    } else {
      throw Exception('Token o userId no encontrados en SharedPreferences');
    }
  }

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

  final List<Map<String, String>> newEvents = [
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Nuevo evento 1',
      'subtitle': 'Organización 4'
    },
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Nuevo evento 2',
      'subtitle': 'Organización 5'
    },
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Nuevo evento 3',
      'subtitle': 'Organización 6'
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

  void _navigateToNewEvent(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewEventPage(eventTitle: title),
      ),
    );
  }

  void _onDonateConfirmed() {
    print('Donación confirmada');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      drawer: CustomDrawer(
          attendedEvents: attendedEvents),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _getProfile,
              child: Text('Obtener info'),
            ),
            const SizedBox(height: 20),
            SearchEvents(
              onChanged: (value) {
                // acción al cambiar el texto del campo de búsqueda
              },
            ),
            const SizedBox(height: 10),
            UpcomingEventsCarousel(
              imgList: imgList,
              navigateToEvent: _navigateToEvent,
            ),
            const SizedBox(height: 30),
            NewEventsCarousel(
              imgList: newEvents,
              navigateToEvent: _navigateToNewEvent,
            ),
            const SizedBox(height: 30),
            FooterComponent(
              onDonateConfirmed: _onDonateConfirmed,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
