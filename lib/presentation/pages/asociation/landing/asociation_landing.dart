// association_landing_page.dart
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
import 'components/custom_drawer.dart';
import '../map/select_location_page.dart';
import '../map/show_location_page.dart';

class AssociationLandingPage extends StatelessWidget {
  final List<Map<String, String>> imgList = [
    {
      'image': 'assets/mau.jpg',
      'title': 'Mau',
    },
    {
      'image': 'assets/messi.jpg',
      'title': 'Leo',
    },
    {
      'image': 'assets/samuel.jpg',
      'title': 'Samuel',
    },
  ];

  final List<Map<String, String>> pastEvents = [
    {
      'image': 'assets/dia-niños.jpg',
      'title': 'Día del niño',
      'location': 'Asilo Corazón',
      'description': ''
    },
    {
      'image': 'assets/abuelitos.jpg',
      'title': 'Pintar con los abuelitos',
      'location': 'Asilo Corazón',
      'description': 'Descripción del evento pasado 2'
    },
  ];

  final List<Map<String, String>> eventActiveImg = [
    {
      'image': 'assets/madres.jpg',
      'title': 'Día de las madres',
      'description': 'Asilo corazón'
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

  void _navigateToSelectLocation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectLocationPage(),
      ),
    );
  }

  void _navigateToShowLocation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowLocationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ActiveEvents(
                activeEvents: eventActiveImg,
                navigateToEvent: _navigateToEvent,
              ),
              SizedBox(height: 10),
              VolunteersCarousel(
                imgList: imgList,
                navigateToVolunteers: _navigateToVolunteers,
                navigateToVolunteerDetails: _navigateToVolunteers,
              ),
              SizedBox(height: 10),
              PastEventsList(
                pastEvents: pastEvents,
                navigateToPastEvent: _navigateToPastEvent,
                navigateToAllPastEvents: _navigateToAllPastEvents,
              ),
              
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _navigateToSelectLocation(context),
                child: const Text('Seleccionar Ubicación'),
              ),
              ElevatedButton(
                onPressed: () => _navigateToShowLocation(context),
                child: const Text('Mostrar Ubicación Guardada'),
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
