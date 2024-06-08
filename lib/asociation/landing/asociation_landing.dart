import 'package:flutter/material.dart';
import 'components/navbar_asociation.dart';
import 'components/active_events.dart';
import 'components/volunteers_carousel.dart';
import 'components/past_events.dart';
import 'components/donation_part.dart';
import '../events/event_active.dart';
import '../volunteers/volunteers_details.dart';
import '../pastEvent/past_event.dart';
import '../pastEventsPage/past_events_page.dart';

class AssociationLandingPage extends StatelessWidget {
  final List<Map<String, String>> imgList = [
    {
      'image': 'assets/messi.jpg',
      'title': 'Voluntario 1',
    },
    {
      'image': 'assets/messi.jpg',
      'title': 'Voluntario 2',
    },
    {
      'image': 'assets/messi.jpg',
      'title': 'Voluntario 3',
    },
  ];

  final List<Map<String, String>> pastEvents = [
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Evento Pasado 1',
      'location': 'Lugar 1',
      'description': 'Descripción del evento pasado 1'
    },
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Evento Pasado 2',
      'location': 'Lugar 2',
      'description': 'Descripción del evento pasado 2'
    },
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Evento Pasado 3',
      'location': 'Lugar 3',
      'description': 'Descripción del evento pasado 3'
    },
  ];

  final List<Map<String, String>> eventActiveImg = [
    {
      'image': 'assets/carrusel-image1.png',
      'title': 'Extinguir el fuego del mactumactza',
      'description': 'Descripción del evento activo'
    }
  ];

  void _navigateToEvent(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventPageActive(eventTitle: title),
      ),
    );
  }

  void _navigateToVolunteers(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VolunteerDetailsPage(
          volunteerName: title,
          imageUrl: imgList
              .firstWhere((element) => element['title'] == title)['image']!,
        ),
      ),
    );
  }

  void _navigateToPastEvent(BuildContext context, Map<String, String> event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetailsPage(
          eventTitle: event['title']!,
          eventImage: event['image']!,
          eventLocation: event['location']!,
          eventDescription: event['description']!,
        ),
      ),
    );
  }

  void _navigateToAllPastEvents(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllPastEventsPage(
          pastEvents: pastEvents,
          navigateToPastEvent: _navigateToPastEvent,
        ),
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
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ActiveEvents(
                activeEvents: eventActiveImg,
                navigateToEvent: _navigateToEvent,
              ),
              SizedBox(height: 20),
              VolunteersCarousel(
                imgList: imgList,
                navigateToVolunteers: _navigateToVolunteers,
                navigateToVolunteerDetails: _navigateToVolunteers,
              ),
              SizedBox(height: 20),
              PastEventsList(
                pastEvents: pastEvents,
                navigateToPastEvent: _navigateToPastEvent,
                navigateToAllPastEvents: _navigateToAllPastEvents,
              ),
              SizedBox(height: 20),
              FooterComponent(
                onDonateConfirmed: _onDonateConfirmed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
